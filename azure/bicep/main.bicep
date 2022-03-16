targetScope = 'subscription'

param config object

var prefixStripped = toLower(replace(config.prefix, '-', ''))
var tenantId = subscription().tenantId

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'rg-${config.prefix}-001'
  location: config.location
  tags: config.tags
}

module appi 'modules/appi.bicep' = {
  name: 'appi'
  scope: rg
  params: {
    name: 'appi-${config.prefix}-001'
    location: config.location
    tags: config.tags
    kind: config.appiKind
    Application_Type: config.appiType
  }
}

module kv 'modules/kv.bicep' = {
  name: 'kv'
  scope: rg
  params: {
    name: 'kv-${config.prefix}-001'
    location: config.location
    tags: config.tags
    tenantId: tenantId
    sku: config.kvSku
    accessPolicies: [
      {
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
    tags: config.tags
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
    name: 'pip-${config.prefix}-${padLeft(i + 1, 3, '0')}'
    location: config.location
    tags: config.tags
    sku: config.pipSku
    publicIPAllocationMethod: config.pipAllocation
    domainNameLabel: '${pipLabel}-${config.prefix}'
  }
}]

module st 'modules/st.bicep' = [for i in range(0, config.stCount): {
  name: 'st${i}'
  scope: rg
  params: {
    name: 'st${prefixStripped}${padLeft(i + 1, 3, '0')}'
    location: config.location
    tags: config.tags
    kind: config.stKind
    sku: config.stSku
    allowBlobPublicAccess: config.stPublicAccess
    supportsHttpsTrafficOnly: config.stHttpsOnly
    minimumTlsVersion: config.stTlsVersion
    containers: [
      'container${prefixStripped}001'
    ]
  }
}]

module vnet 'modules/vnet.bicep' = if (contains(config, 'vnetAddressPrefix')) {
  name: 'vnet'
  scope: rg
  params: {
    name: 'vnet-${config.prefix}-001'
    location: config.location
    tags: config.tags
    addressPrefixes: [
      config.vnetAddressPrefix
    ]
    subnets: [
      {
        name: 'snet-${config.prefix}-001'
        addressPrefix: config.vnetAddressPrefix
      }
    ]
  }
}

output kvUrl string = kv.outputs.vaultUri
output pdnszUrl array = pdnsz.outputs.fqdn
output pipUrl array = [for (pipLabel, i) in config.pipLabels: 'https://${pip[i].outputs.fqdn}/']
output stUrl array = [for i in range(0, config.stCount): st[i].outputs.primaryEndpoints]
