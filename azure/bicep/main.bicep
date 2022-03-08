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

module appi 'modules/appi.bicep' = {
  name: 'appi'
  scope: rg
  params: {
    name: 'appi-${prefix}-001'
    location: location
    tags: tags
    kind: config.appi.kind
    Application_Type: config.appi.type
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
    sku: config.kv.sku
    accessPolicies: [
      {
        tenantId: tenantId
        objectId: config.kv.objectId
        permissions: config.kv.permissions
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
    name: config.pdnsz.name
    tags: tags
    vnetName: empty(config.vnet) ? 'null' : vnet.outputs.name
    vnetId: empty(config.vnet) ? '' : vnet.outputs.id
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
    location: location
    tags: tags
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
    location: location
    tags: tags
    kind: config.st.kind
    sku: config.st.sku
    allowBlobPublicAccess: config.st.publicAccess
    supportsHttpsTrafficOnly: config.st.httpsOnly
    minimumTlsVersion: config.st.tlsVersion
    containerName: 'container${prefixStripped}001'
  }
}]

module vnet 'modules/vnet.bicep' = if (!empty(config.vnet)) {
  name: 'vnet'
  scope: rg
  params: {
    name: 'vnet-${prefix}-001'
    location: location
    tags: tags
    addressPrefixes: [
      config.vnet.addressPrefix
    ]
    snetName: 'snet-${prefix}-001'
    snetAddressPrefix: config.vnet.addressPrefix
  }
}

output kvUrl string = kv.outputs.vaultUri

output pdnszUrl array = pdnsz.outputs.fqdn

output pipUrl array = [for (label, i) in config.pip.labels: 'https://${pip[i].outputs.fqdn}/']

output stUrl array = [for i in range(0, config.st.count): st[i].outputs.primaryEndpoints]
