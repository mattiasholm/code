targetScope = 'subscription'

var prefix = 'holm-bicep'
var location = deployment().location
var tags = {
    Company: 'Holm'
    Environment: 'Test'
    Application: 'Bicep'
    Owner: 'mattias.holm@live.com'
}
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
        skuName: 'F1'
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

module stModule 'modules/st.bicep' = {
    name: 'stModule'
    scope: rg
    params: {
        name: 'st${replace(prefix, '-', '')}001'
        location: location
        tags: tags
        kind: 'StorageV2'
        skuName: 'Standard_LRS'
        allowBlobPublicAccess: false
        supportsHttpsTrafficOnly: true
        minimumTlsVersion: 'TLS1_2'
    }
}

module vnetModule 'modules/vnet.bicep' = if (toggleVnet) {
    name: 'vnetModule'
    scope: rg
    params: {
        name: 'vnet-${prefix}-001'
        location: location
        tags: tags
        addressPrefixes: [
            '10.0.0.0/16'
        ]
        subnetsName: 'snet-${prefix}-001'
        subnetsAddressPrefix: '10.0.0.0/24'
    }
}

output appUrl array = [for (app, i) in apps: {
    name: app.name
    appUrl: appModule[i].outputs.appUrl
}]
output kvUrl string = kvModule.outputs.kvUrl
output stBlobUrl string = stModule.outputs.stBlobUrl
output stFileUrl string = stModule.outputs.stFileUrl
output stTableUrl string = stModule.outputs.stTableUrl
output stQueueUrl string = stModule.outputs.stQueueUrl
