targetScope = 'subscription'

var prefix = 'holm-bicep'
var prefixStripped = toLower(replace(prefix, '-', ''))
var location = deployment().location
var tags = {
  Application: 'Bicep'
  Company: 'Holm'
  Environment: 'Dev'
  Owner: 'mattias.holm@live.com'
}
var tenantId = subscription().tenantId

var appDockerImageTags = [
  'latest'
  'plain-text'
]

var kvPermissions = {
  secrets: [
    'Get'
    'List'
  ]
}

var stCount = 3

var vnetToggle = true
var vnetAddressPrefix = '10.0.0.0/24'

resource rg 'Microsoft.Resources/resourceGroups@2021-01-01' = {
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
    kind: 'linux'
    skuName: 'B1'
    skuCapacity: 1
  }
}

module app 'modules/app.bicep' = [for (appDockerImageTag, i) in appDockerImageTags: {
  name: 'app${i}'
  scope: rg
  params: {
    name: 'app-${prefix}-${padLeft(i + 1, 3, '0')}'
    location: location
    tags: tags
    identityType: 'SystemAssigned'
    serverFarmId: plan.outputs.id
    siteConfig: {
      linuxFxVersion: 'DOCKER|nginxdemos/hello:${appDockerImageTag}'
      alwaysOn: true
      http20Enabled: true
      minTlsVersion: '1.2'
      ftpsState: 'FtpsOnly'
    }
    clientAffinityEnabled: false
    httpsOnly: true
  }
}]

module appsettings 'modules/appsettings.bicep' = [for (appDockerImageTag, i) in appDockerImageTags: {
  name: 'appsettings${i}'
  scope: rg
  params: {
    name: 'app-${prefix}-${padLeft(i + 1, 3, '0')}'
    properties: {
      KEYVAULT_URL: kv.outputs.vaultUri
      APPLICATIONINSIGHTS_CONNECTION_STRING: appi.outputs.connectionString
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
    kind: 'web'
    Application_Type: 'web'
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
    skuFamily: 'A'
    skuName: 'standard'
    accessPolicies: [for (appDockerImageTag, i) in appDockerImageTags: {
      tenantId: tenantId
      objectId: app[i].outputs.identity.principalId
      permissions: kvPermissions
    }]
  }
}

module st 'modules/st.bicep' = [for i in range(0, stCount): {
  name: 'st${i}'
  scope: rg
  params: {
    name: 'st${prefixStripped}${padLeft(i + 1, 3, '0')}'
    location: location
    tags: tags
    kind: 'StorageV2'
    skuName: 'Standard_LRS'
    allowBlobPublicAccess: false
    supportsHttpsTrafficOnly: true
    minimumTlsVersion: 'TLS1_2'
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

output appUrl array = [for (appDockerImageTag, i) in appDockerImageTags: {
  name: 'app-${prefix}-${padLeft(i + 1, 3, '0')}'
  url: app[i].outputs.defaultHostName
}]

output kvUrl string = kv.outputs.vaultUri

output stBlobUrl array = [for i in range(0, stCount): {
  name: 'st${prefixStripped}${padLeft(i + 1, 3, '0')}'
  blobUrl: st[i].outputs.primaryEndpoints.blob
}]
output stFileUrl array = [for i in range(0, stCount): {
  name: 'st${prefixStripped}${padLeft(i + 1, 3, '0')}'
  fileUrl: st[i].outputs.primaryEndpoints.file
}]
output stQueueUrl array = [for i in range(0, stCount): {
  name: 'st${prefixStripped}${padLeft(i + 1, 3, '0')}'
  queueUrl: st[i].outputs.primaryEndpoints.queue
}]
output stTableUrl array = [for i in range(0, stCount): {
  name: 'st${prefixStripped}${padLeft(i + 1, 3, '0')}'
  tableUrl: st[i].outputs.primaryEndpoints.table
}]
