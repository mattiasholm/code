targetScope = 'subscription'

@maxLength(17)
param prefix string = 'holm-bicep'
param location string = deployment().location
param tags object = {
  Application: 'Bicep'
  Company: 'Holm'
  Environment: 'Dev'
  Owner: 'mattias.holm@live.com'
}

@allowed([
  'web'
  'ios'
  'other'
  'store'
  'java'
  'phone'
])
param appiKind string = 'web'
@allowed([
  'web'
  'other'
])
param appiType string = 'web'

@allowed([
  'standard'
  'premium'
])
param kvSku string = 'standard'
param kvObjectId string = 'e1d37e09-c819-457e-9b93-44b8c784f539'
param kvPermissions object = {
  keys: [
    'Get'
    'List'
    'Update'
    'Create'
    'Import'
    'Delete'
    'Recover'
    'Backup'
    'Restore'
    'Decrypt'
    'Encrypt'
    'UnwrapKey'
    'WrapKey'
    'Verify'
    'Sign'
    'Purge'
  ]
  secrets: [
    'Get'
    'List'
    'Set'
    'Delete'
    'Recover'
    'Backup'
    'Restore'
    'Purge'
  ]
  certificates: [
    'Get'
    'List'
    'Update'
    'Create'
    'Import'
    'Delete'
    'Recover'
    'Backup'
    'Restore'
    'ManageContacts'
    'ManageIssuers'
    'GetIssuers'
    'ListIssuers'
    'SetIssuers'
    'DeleteIssuers'
    'Purge'
  ]
}

param pdnszName string = 'holm.io'
param pdnszRegistration bool = false
param pdnszTtl int = 3600

param pipLabels array = [
  'foo'
  'bar'
]
@allowed([
  'Basic'
  'Standard'
])
param pipSku string = 'Basic'
@allowed([
  'Dynamic'
  'Static'
])
param pipAllocation string = 'Dynamic'

param stCount int = 2 // 1
@allowed([
  'Storage'
  'StorageV2'
  'BlobStorage'
  'FileStorage'
  'BlockBlobStorage'
])
param stKind string = 'StorageV2'
@allowed([
  'Standard_LRS'
  'Standard_ZRS'
  'Standard_GRS'
  'Standard_RAGRS'
  'Standard_GZRS'
  'Standard_RAGZRS'
  'Premium_LRS'
  'Premium_ZRS'
])
param stSku string = 'Standard_LRS'
param stPublicAccess bool = false
param stHttpsOnly bool = true
@allowed([
  'TLS1_0'
  'TLS1_1'
  'TLS1_2'
])
param stTlsVersion string = 'TLS1_2'

param vnetAddressPrefix string = '10.0.0.0/24' // ''

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
