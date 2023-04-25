// Test

targetScope = 'subscription'

param config object

var prefix = toLower('${config.tags.Company}-${config.tags.Application}')
var prefixStripped = replace(prefix, '-', '')
var tenantId = subscription().tenantId

resource rg 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: 'rg-${prefix}-001'
  location: config.location
  tags: config.tags
}

module appi 'modules/appi.bicep' = {
  name: 'appi'
  scope: rg
  params: {
    name: 'appi-${prefix}-001'
    location: config.location
    kind: config.appi.kind
    kvName: kv.outputs.name
  }
}

module kv 'modules/kv.bicep' = {
  name: 'kv'
  scope: rg
  params: {
    name: 'kv-${prefix}-001'
    location: config.location
    tenantId: tenantId
    sku: config.kv.sku
    accessPolicies: [
      {
        objectId: config.kv.objectId
        permissions: config.kv.permissions
      }
    ]
  }
}

module pdnsz 'modules/pdnsz.bicep' = {
  name: 'pdnsz'
  scope: rg
  params: {
    name: config.pdnsz.name
    vnetName: vnet.outputs.name
    vnetId: contains(config, 'vnetAddressPrefix') ? vnet.outputs.id : ''
    registrationEnabled: config.pdnsz.registration
    ttl: config.pdnsz.ttl
    cnameRecords: [for (label, i) in config.pip.labels: {
      name: label
      cname: pip[i].outputs.fqdn
    }]
  }
}

module pip 'modules/pip.bicep' = [for (label, i) in config.pip.labels: {
  name: 'pip${i}'
  scope: rg
  params: {
    name: 'pip-${prefix}-${padLeft(i + 1, 3, '0')}'
    location: config.location
    sku: config.pip.sku
    publicIPAllocationMethod: config.pip.allocation
    domainNameLabel: '${label}-${prefix}'
  }
}]

module st 'modules/st.bicep' = [for i in range(0, config.st.count): {
  name: 'st${i}'
  scope: rg
  params: {
    name: 'st${prefixStripped}${padLeft(i + 1, 3, '0')}'
    location: config.location
    kind: config.st.kind
    sku: config.st.sku
    allowBlobPublicAccess: config.st.publicAccess
    supportsHttpsTrafficOnly: config.st.httpsOnly
    minimumTlsVersion: config.st.tlsVersion
    containers: [
      'container${prefixStripped}001'
    ]
  }
}]

module vnet 'modules/vnet.bicep' = if (contains(config, 'vnetAddressPrefix')) {
  name: 'vnet'
  scope: rg
  params: {
    name: 'vnet-${prefix}-001'
    location: config.location
    addressPrefixes: [
      config.vnet.addressPrefix
    ]
    subnets: [
      {
        name: 'snet-${prefix}-001'
        addressPrefix: config.vnet.addressPrefix
      }
    ]
  }
}

output kvUrl string = kv.outputs.vaultUri
output pdnszUrl array = pdnsz.outputs.fqdn
output pipUrl array = [for (label, i) in config.pip.labels: 'https://${pip[i].outputs.fqdn}/']
output stUrl array = [for i in range(0, config.st.count): st[i].outputs.primaryEndpoints]
