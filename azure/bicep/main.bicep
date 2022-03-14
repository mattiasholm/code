targetScope = 'subscription'

@maxLength(17)
param prefix string
param location string = deployment().location
param tags object = {}
param config object

var prefixStripped = toLower(replace(prefix, '-', ''))
var tenantId = subscription().tenantId

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'rg-${prefix}-001'
  location: location
  tags: tags
}

// module appi 'modules/appi.bicep' = {
// module appi 'br:crholmbicep001.azurecr.io/appi:v1' = {
module appi 'br/modules:appi:v1' = {
  name: 'appi'
  scope: rg
  params: {
    name: 'appi-${prefix}-001'
    location: location
    tags: tags
    kind: config.appiKind
    Application_Type: config.appiType
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
    sku: config.kvSku
    accessPolicies: [
      {
        tenantId: tenantId
        objectId: config.kvObjectId
        permissions: config.kvPermissions
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
    name: config.pdnszName
    tags: tags
    vnetName: vnet.outputs.name
    vnetId: contains(config, 'vnetAddressPrefix') ? vnet.outputs.id : ''
    registrationEnabled: config.pdnszRegistration
    ttl: config.pdnszTtl
    cnameRecords: [for (pipLabel, i) in config.pipLabels: {
      name: pipLabel
      cname: pip[i].outputs.fqdn
    }]
  }
}

module pip 'modules/pip.bicep' = [for (pipLabel, i) in config.pipLabels: {
  name: 'pip${i}'
  scope: rg
  params: {
    name: 'pip-${prefix}-${padLeft(i + 1, 3, '0')}'
    location: location
    tags: tags
    sku: config.pipSku
    publicIPAllocationMethod: config.pipAllocation
    domainNameLabel: '${pipLabel}-${prefix}'
  }
}]

module st 'modules/st.bicep' = [for i in range(0, config.stCount): {
  name: 'st${i}'
  scope: rg
  params: {
    name: 'st${prefixStripped}${padLeft(i + 1, 3, '0')}'
    location: location
    tags: tags
    kind: config.stKind
    sku: config.stSku
    allowBlobPublicAccess: config.stPublicAccess
    supportsHttpsTrafficOnly: config.stHttpsOnly
    minimumTlsVersion: config.stTlsVersion
    containerName: 'container${prefixStripped}001'
  }
}]

module vnet 'modules/vnet.bicep' = if (contains(config, 'vnetAddressPrefix')) {
  name: 'vnet'
  scope: rg
  params: {
    name: 'vnet-${prefix}-001'
    location: location
    tags: tags
    addressPrefixes: [
      config.vnetAddressPrefix
    ]
    snetName: 'snet-${prefix}-001'
    snetAddressPrefix: config.vnetAddressPrefix
  }
}

output kvUrl string = kv.outputs.vaultUri
output pdnszUrl array = pdnsz.outputs.fqdn
output pipUrl array = [for (pipLabel, i) in config.pipLabels: 'https://${pip[i].outputs.fqdn}/']
output stUrl array = [for i in range(0, config.stCount): st[i].outputs.primaryEndpoints]
