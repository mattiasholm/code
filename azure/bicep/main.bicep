targetScope = 'subscription'

var prefix = 'holm-bicep'
var prefixStripped = toLower(replace(prefix, '-', ''))
var location = deployment().location
var tags = {
    Application: 'Bicep'
    Company: 'Holm'
    Environment: 'Test'
    Owner: 'mattias.holm@live.com'
}
var tenantId = subscription().tenantId

var appObjects = [
    {
        name: 'app-${prefix}-001'
        dockerImageTag: 'latest'
    }
    {
        name: 'app-${prefix}-002'
        dockerImageTag: 'plain-text'
    }
]

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

module app 'modules/app.bicep' = [for (appObject, i) in appObjects: {
    name: 'app${i}'
    scope: rg
    params: {
        name: appObject.name
        location: location
        tags: tags
        identityType: 'SystemAssigned'
        planId: plan.outputs.id
        siteConfig: {
            linuxFxVersion: 'DOCKER|nginxdemos/hello:${appObject.dockerImageTag}'
            alwaysOn: true
            http20Enabled: true
            minTlsVersion: '1.2'
            ftpsState: 'FtpsOnly'
        }
        clientAffinityEnabled: false
        httpsOnly: true
    }
}]

module appsettings 'modules/appsettings.bicep' = [for (appObject, i) in appObjects: {
    name: 'appsettings${i}'
    scope: rg
    params: {
        name: appObject.name
        properties: {
            kvUrl: kv.outputs.url
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
        accessPolicies: [for (appObject, i) in appObjects: {
            tenantId: tenantId
            objectId: app[i].outputs.identity
            permissions: {
                secrets: [
                    'Get'
                    'List'
                ]
            }
        }]
    }
}

module st 'modules/st.bicep' = [for i in range(0, stCount): {
    name: 'st${i}'
    scope: rg
    params: {
        name: 'st${prefixStripped}00${i + 1}'
        location: location
        tags: tags
        kind: 'StorageV2'
        skuName: 'Standard_LRS'
        allowBlobPublicAccess: false
        supportsHttpsTrafficOnly: true
        minimumTlsVersion: 'TLS1_2'
        containerName: 'container${prefixStripped}00${i + 1}'
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

output appUrl array = [for (appObject, i) in appObjects: {
    name: appObject.name
    url: app[i].outputs.url
}]
output kvUrl string = kv.outputs.url
output stBlobUrl array = [for i in range(0, stCount): {
    name: 'st${prefixStripped}00${i + 1}'
    blobUrl: st[i].outputs.blobUrl
}]
output stFileUrl array = [for i in range(0, stCount): {
    name: 'st${prefixStripped}00${i + 1}'
    fileUrl: st[i].outputs.fileUrl
}]
output stTableUrl array = [for i in range(0, stCount): {
    name: 'st${prefixStripped}00${i + 1}'
    tableUrl: st[i].outputs.tableUrl
}]
output stQueueUrl array = [for i in range(0, stCount): {
    name: 'st${prefixStripped}00${i + 1}'
    queueUrl: st[i].outputs.queueUrl
}]
