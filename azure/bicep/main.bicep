targetScope = 'subscription'

@maxLength(17)
param prefix string
param location string = deployment().location
param tags object = {}

param appiKind string
param appiType string

param kvSku string
param kvObjectId string
param kvPermissions object

param pdnszName string
param pdnszRegistration bool
param pdnszTtl int

param pipLabels array
param pipSku string
param pipAllocation string

param stCount int = 1
param stKind string
param stSku string
param stPublicAccess bool
param stHttpsOnly bool
param stTlsVersion string

param vnetAddressPrefix string = ''

var prefixStripped = toLower(replace(prefix, '-', ''))
var tenantId = subscription().tenantId

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'rg-${prefix}-001'
  location: location
  tags: tags
}

module appi 'modules/appi.bicep' = {
  name: 'appi'
  scope: rg
  params: {
    name: 'appi-${prefix}-001'
    location: location
    tags: tags
    kind: appiKind
    Application_Type: appiType
  }
}

module kv 'modules/kv.bicep' = {
  name: 'kv'
  scope: rg
  params: {
    name: 'kv-${prefix}-001'
    location: location
    tags: tags
    tenantId: tenantId
    sku: kvSku
    accessPolicies: [
      {
        tenantId: tenantId
        objectId: kvObjectId
        permissions: kvPermissions
      }
    ]
    secrets: [
      {
        name: 'appi-connectionString'
        value: appi.outputs.connectionString
      }
    ]
  }
}

module pdnsz 'modules/pdnsz.bicep' = {
  name: 'pdnsz'
  scope: rg
  params: {
    name: pdnszName
    tags: tags
    vnetName: empty(vnetAddressPrefix) ? 'null' : vnet.outputs.name
    vnetId: empty(vnetAddressPrefix) ? '' : vnet.outputs.id
    registrationEnabled: pdnszRegistration
    ttl: pdnszTtl
    cnameRecords: [for (pipLabel, i) in pipLabels: {
      name: pipLabel
      cname: pip[i].outputs.fqdn
    }]
  }
}

module pip 'modules/pip.bicep' = [for (pipLabel, i) in pipLabels: {
  name: 'pip${i}'
  scope: rg
  params: {
    name: 'pip-${prefix}-${padLeft(i + 1, 3, '0')}'
    location: location
    tags: tags
    sku: pipSku
    publicIPAllocationMethod: pipAllocation
    domainNameLabel: '${pipLabel}-${prefix}'
  }
}]

module st 'modules/st.bicep' = [for i in range(0, stCount): {
  name: 'st${i}'
  scope: rg
  params: {
    name: 'st${prefixStripped}${padLeft(i + 1, 3, '0')}'
    location: location
    tags: tags
    kind: stKind
    sku: stSku
    allowBlobPublicAccess: stPublicAccess
    supportsHttpsTrafficOnly: stHttpsOnly
    minimumTlsVersion: stTlsVersion
    containerName: 'container${prefixStripped}001'
  }
}]

module vnet 'modules/vnet.bicep' = if (!empty(vnetAddressPrefix)) {
  name: 'vnet'
  scope: rg
  params: {
    name: 'vnet-${prefix}-001'
    location: location
    tags: tags
    addressPrefixes: [
      vnetAddressPrefix
    ]
    snetName: 'snet-${prefix}-001'
    snetAddressPrefix: vnetAddressPrefix
  }
}

output kvUrl string = kv.outputs.vaultUri

output pdnszUrl array = pdnsz.outputs.fqdn

output pipUrl array = [for (pipLabel, i) in pipLabels: 'https://${pip[i].outputs.fqdn}/']

output stUrl array = [for i in range(0, stCount): st[i].outputs.primaryEndpoints]
