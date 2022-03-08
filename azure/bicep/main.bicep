targetScope = 'subscription'

@maxLength(17)
param prefix string
param location string = deployment().location
param tags object = {}

param appiConfig object
param kvConfig object
param pdnszConfig object
param pipConfig object
param stConfig object
param vnetConfig object = {}

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
    kind: appiConfig.kind
    Application_Type: appiConfig.type
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
    sku: kvConfig.sku
    accessPolicies: [
      {
        tenantId: tenantId
        objectId: kvConfig.objectId
        permissions: kvConfig.permissions
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
    name: pdnszConfig.name
    tags: tags
    vnetName: empty(vnetConfig) ? 'null' : vnet.outputs.name
    vnetId: empty(vnetConfig) ? '' : vnet.outputs.id
    registrationEnabled: pdnszConfig.registration
    ttl: pdnszConfig.ttl
    cnameRecords: [for (label, i) in pipConfig.labels: {
      name: label
      cname: pip[i].outputs.fqdn
    }]
  }
}

module pip 'modules/pip.bicep' = [for (label, i) in pipConfig.labels: {
  name: 'pip${i}'
  scope: rg
  params: {
    name: 'pip-${prefix}-${padLeft(i + 1, 3, '0')}'
    location: location
    tags: tags
    sku: pipConfig.sku
    publicIPAllocationMethod: pipConfig.allocation
    domainNameLabel: '${label}-${prefix}'
  }
}]

module st 'modules/st.bicep' = [for i in range(0, stConfig.count): {
  name: 'st${i}'
  scope: rg
  params: {
    name: 'st${prefixStripped}${padLeft(i + 1, 3, '0')}'
    location: location
    tags: tags
    kind: stConfig.kind
    sku: stConfig.sku
    allowBlobPublicAccess: stConfig.publicAccess
    supportsHttpsTrafficOnly: stConfig.httpsOnly
    minimumTlsVersion: stConfig.tlsVersion
    containerName: 'container${prefixStripped}001'
  }
}]

module vnet 'modules/vnet.bicep' = if (!empty(vnetConfig)) {
  name: 'vnet'
  scope: rg
  params: {
    name: 'vnet-${prefix}-001'
    location: location
    tags: tags
    addressPrefixes: [
      vnetConfig.addressPrefix
    ]
    snetName: 'snet-${prefix}-001'
    snetAddressPrefix: vnetConfig.addressPrefix
  }
}

output kvUrl string = kv.outputs.vaultUri

output pdnszUrl array = pdnsz.outputs.fqdn

output pipUrl array = [for (label, i) in pipConfig.labels: 'https://${pip[i].outputs.fqdn}/']

output stUrl array = [for i in range(0, stConfig.count): st[i].outputs.primaryEndpoints]
