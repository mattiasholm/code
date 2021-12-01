targetScope = 'subscription'

param prefix string = 'holm-bicep'
param tags object = {
  Application: 'Bicep'
  Company: 'Holm'
  Environment: 'Dev'
  Owner: 'mattias.holm@live.com'
}

@allowed([
  'app'
  'linux'
])
param planKind string = 'linux'
param planSku string = 'B1'
@minValue(1)
@maxValue(10)
param planCapacity int = 1

param appDockerImages array = [
  'nginxdemos/hello:latest'
  'nginxdemos/hello:plain-text'
]
@allowed([
  'None'
  'SystemAssigned'
])
param appIdentity string = 'SystemAssigned' //'None'
param appAlwaysOn bool = true
param appHttp20Enabled bool = true
@allowed([
  '1.0'
  '1.1'
  '1.2'
])
param appMinTlsVersion string = '1.2'
@allowed([
  'AllAllowed'
  'FtpsOnly'
  'Disabled'
])
param appFtpsState string = 'FtpsOnly'
param appClientAffinityEnabled bool = false
param appHttpsOnly bool = true

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
param kvAppPermissions object = {
  secrets: [
    'Get'
    'List'
  ]
}
param kvGroupId string = 'e810d50b-5f44-4e21-b1c9-eb89653cc2de'
param kvGroupPermissions object = {
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

param stCount int = 3
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

param vnetToggle bool = true
param vnetAddressPrefix string = '10.0.0.0/24'

var prefixStripped = toLower(replace(prefix, '-', ''))
var location = deployment().location
var tenantId = subscription().tenantId
var kvSecretName = 'appiConnectionString'

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'rg-${prefix}-001'
  location: location
  tags: tags
}

module plan 'modules/plan.bicep' = {
  name: 'plan'
  scope: rg
  params: {
    name: 'plan-${prefix}-001'
    location: location
    tags: tags
    kind: planKind
    sku: planSku
    capacity: planCapacity
  }
}

module app 'modules/app.bicep' = [for (appDockerImage, i) in appDockerImages: {
  name: 'app${i}'
  scope: rg
  params: {
    name: 'app-${prefix}-${padLeft(i + 1, 3, '0')}'
    location: location
    tags: tags
    identityType: appIdentity
    serverFarmId: plan.outputs.id
    siteConfig: {
      linuxFxVersion: 'DOCKER|${appDockerImage}'
      alwaysOn: appAlwaysOn
      http20Enabled: appHttp20Enabled
      minTlsVersion: appMinTlsVersion
      ftpsState: appFtpsState
    }
    clientAffinityEnabled: appClientAffinityEnabled
    httpsOnly: appHttpsOnly
  }
}]

module appsettings 'modules/appsettings.bicep' = [for (appDockerImage, i) in appDockerImages: {
  name: 'appsettings${i}'
  scope: rg
  params: {
    name: 'app-${prefix}-${padLeft(i + 1, 3, '0')}'
    properties: {
      APPLICATIONINSIGHTS_CONNECTION_STRING: '@Microsoft.KeyVault(VaultName=${kv.outputs.name};SecretName=${kvSecretName})'
      KEYVAULT_URL: kv.outputs.vaultUri
    }
  }
}]

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
    accessPolicies: [for (appDockerImage, i) in appDockerImages: {
      tenantId: tenantId
      objectId: app[i].outputs.identity.principalId
      permissions: kvAppPermissions
    }]
    objectId: kvGroupId
    permissions: kvGroupPermissions
    secrets: [
      {
        name: kvSecretName
        value: appi.outputs.connectionString
      }
    ]
  }
}

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

module vnet 'modules/vnet.bicep' = if (vnetToggle) {
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

output appUrl array = [for (appDockerImage, i) in appDockerImages: {
  name: 'app-${prefix}-${padLeft(i + 1, 3, '0')}'
  url: 'https://${app[i].outputs.defaultHostName}/'
}]

output kvUrl string = kv.outputs.vaultUri

output stUrl array = [for i in range(0, stCount): {
  name: 'st${prefixStripped}${padLeft(i + 1, 3, '0')}'
  url: st[i].outputs.primaryEndpoints
}]
