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

var toggleVnet = true

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
        planId: plan.outputs.planId
        siteConfig: {
            linuxFxVersion: 'DOCKER|nginxdemos/hello:${appObject.dockerImageTag}'
            http20Enabled: true
            minTlsVersion: '1.2'
            ftpsState: 'FtpsOnly'
            appSettings: [
                {
                    name: 'kvUrl'
                    value: kv.outputs.kvUrl
                }
            ]
        }
        clientAffinityEnabled: false
        httpsOnly: true
    }
}]

module kv 'modules/kv.bicep' = {
    name: 'kv'
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

module vnet 'modules/vnet.bicep' = if (toggleVnet) {
    name: 'vnet'
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

output appUrl array = [for (appObject, i) in appObjects: {
    name: appObject.name
    appUrl: app[i].outputs.appUrl
}]
output kvUrl string = kv.outputs.kvUrl
output stBlobUrl array = [for i in range(0, stCount): {
    name: 'st${prefixStripped}00${i + 1}'
    stBlobUrl: st[i].outputs.stBlobUrl
}]
output stFileUrl array = [for i in range(0, stCount): {
    name: 'st${prefixStripped}00${i + 1}'
    stFileUrl: st[i].outputs.stFileUrl
}]
output stTableUrl array = [for i in range(0, stCount): {
    name: 'st${prefixStripped}00${i + 1}'
    stTableUrl: st[i].outputs.stTableUrl
}]
output stQueueUrl array = [for i in range(0, stCount): {
    name: 'st${prefixStripped}00${i + 1}'
    stQueueUrl: st[i].outputs.stQueueUrl
}]
