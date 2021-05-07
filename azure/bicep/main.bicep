targetScope = 'subscription'

var prefix = 'holm-bicep'
var prefixStripped = toLower(replace(prefix, '-', ''))
var location = deployment().location
var tags = {
    Company: 'Holm'
    Environment: 'Test'
    Application: 'Bicep'
    Owner: 'mattias.holm@live.com'
}
var stCount = 3
var toggleVnet = true

resource rg 'Microsoft.Resources/resourceGroups@2021-01-01' = {
    name: 'rg-${prefix}-001'
    location: location
    tags: tags
}

module planModule 'modules/plan.bicep' = {
    name: 'planModule'
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

var apps = [
    {
        name: 'app-${prefix}-001'
        dockerImageTag: 'latest'
    }
    {
        name: 'app-${prefix}-002'
        dockerImageTag: 'plain-text'
    }
]

module appModule 'modules/app.bicep' = [for (app, i) in apps: {
    name: 'appModule${i}'
    scope: rg
    params: {
        name: app.name
        location: location
        tags: tags
        identityType: 'SystemAssigned'
        planId: planModule.outputs.planId
        siteConfig: {
            linuxFxVersion: 'DOCKER|nginxdemos/hello:${app.dockerImageTag}'
            http20Enabled: true
            minTlsVersion: '1.2'
            ftpsState: 'FtpsOnly'
        }
        clientAffinityEnabled: false
        httpsOnly: true
    }
}]

module kvModule 'modules/kv.bicep' = {
    name: 'kvModule'
    scope: rg
    params: {
        name: 'kv-${prefix}-001'
        location: location
        tags: tags
        tenantId: subscription().tenantId
        skuFamily: 'A'
        skuName: 'standard'
        accessPolicies: []
    }
}

module stModule 'modules/st.bicep' = [for i in range(0, stCount): {
    name: 'stModule${i}'
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

module vnetModule 'modules/vnet.bicep' = if (toggleVnet) {
    name: 'vnetModule'
    scope: rg
    params: {
        name: 'vnet-${prefix}-001'
        location: location
        tags: tags
        addressPrefixes: [
            '10.0.0.0/24'
        ]
        snetName: 'snet-${prefix}-001'
        snetAddressPrefix: '10.0.0.0/24'
    }
}

output appUrl array = [for (app, i) in apps: {
    name: app.name
    appUrl: appModule[i].outputs.appUrl
}]
output kvUrl string = kvModule.outputs.kvUrl
output stBlobUrl array = [for i in range(0, stCount): {
    name: 'st${prefixStripped}00${i + 1}'
    stBlobUrl: stModule[i].outputs.stBlobUrl
}]
output stFileUrl array = [for i in range(0, stCount): {
    name: 'st${prefixStripped}00${i + 1}'
    stFileUrl: stModule[i].outputs.stFileUrl
}]
output stTableUrl array = [for i in range(0, stCount): {
    name: 'st${prefixStripped}00${i + 1}'
    stTableUrl: stModule[i].outputs.stTableUrl
}]
output stQueueUrl array = [for i in range(0, stCount): {
    name: 'st${prefixStripped}00${i + 1}'
    stQueueUrl: stModule[i].outputs.stQueueUrl
}]
