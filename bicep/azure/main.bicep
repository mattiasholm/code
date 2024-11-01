targetScope = 'subscription'

param config object
param location string = deployment().location

var prefix = toLower('${config.tags.Company}-${config.tags.Application}')
var tenantId = tenant().tenantId

func strip(prefix string) string => replace(prefix, '-', '')

resource rg 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: 'rg-${prefix}-01'
  location: location
  tags: config.tags
}

module appi 'modules/appi.bicep' = if (contains(config, 'appi')) {
  name: 'appi'
  scope: rg
  params: {
    name: 'appi-${prefix}-01'
    location: location
    kind: config.appi.kind
    kvName: kv.outputs.name
  }
}

module kv 'modules/kv.bicep' = {
  name: 'kv'
  scope: rg
  params: {
    name: 'kv-${prefix}-01'
    location: location
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
    vnetId: vnet.outputs.id
    registrationEnabled: config.pdnsz.registration
    ttl: config.pdnsz.ttl
    cnameRecords: [
      for (label, i) in contains(config, 'pip') ? config.pip.labels : []: {
        name: label
        cname: pip[i].outputs.fqdn
      }
    ]
  }
}

module pip 'modules/pip.bicep' = [
  for (label, i) in contains(config, 'pip') ? config.pip.labels : []: {
    name: 'pip${i}'
    scope: rg
    params: {
      name: 'pip-${prefix}-${padLeft(i + 1, 2, '0')}'
      location: location
      sku: config.pip.sku
      publicIPAllocationMethod: config.pip.allocation
      domainNameLabel: '${label}-${prefix}'
    }
  }
]

module st 'modules/st.bicep' = [
  for i in range(0, contains(config, 'st') ? config.st.count : 0): {
    name: 'st${i}'
    scope: rg
    params: {
      name: 'st${strip(prefix)}${padLeft(i + 1, 2, '0')}'
      location: location
      kind: config.st.kind
      sku: config.st.sku
      allowBlobPublicAccess: config.st.publicAccess
      supportsHttpsTrafficOnly: config.st.httpsOnly
      minimumTlsVersion: config.st.tlsVersion
      containers: [
        'container-01'
      ]
    }
  }
]

module vnet 'modules/vnet.bicep' = {
  name: 'vnet'
  scope: rg
  params: {
    name: 'vnet-${prefix}-01'
    location: location
    addressPrefixes: [
      config.vnet.addressPrefix
    ]
    subnets: [
      for i in range(0, config.vnet.subnetCount): {
        name: 'snet-${padLeft(i + 1, 2, '0')}'
        addressPrefix: cidrSubnet(config.vnet.addressPrefix, config.vnet.subnetSize, i)
      }
    ]
  }
}

output kvUrl string = kv.outputs.vaultUri
output pdnszUrl array = pdnsz.outputs.fqdn
output pipUrl array = [
  for (label, i) in contains(config, 'pip') ? config.pip.labels : []: 'https://${pip[i].outputs.fqdn}/'
]
output stUrl array = [for i in range(0, contains(config, 'st') ? config.st.count : 0): st[i].outputs.primaryEndpoints]
