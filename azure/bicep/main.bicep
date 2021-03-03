targetScope = 'subscription'

var prefix = 'holm-bicep'
var location = deployment().location
var tags = {
    Company: 'Holm'
    Environment: 'Test'
    Owner: 'mattias.holm@live.com'
}

resource rg 'Microsoft.Resources/resourceGroups@2020-06-01' = {
    name: 'rg-${prefix}-001'
    location: location
    tags: tags
}

module planModule 'plan.bicep' = {
    name: 'planModule'
    scope: rg
    params: {
        name: 'plan-${prefix}-001'
        location: location
        tags: tags
        kind: 'app'
        skuName: 'F1'
        skuCapacity: 0
    }
}

module appModule 'app.bicep' = {
    name: 'appModule'
    scope: rg
    params: {
        name: 'app-${prefix}-001'
        location: location
        tags: tags
        planId: planModule.outputs.planId
        httpsOnly: true
    }
}

module kvModule 'kv.bicep' = {
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

module stModule 'st.bicep' = {
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

module vnetModule 'vnet.bicep' = {
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

output appUrl string = appModule.outputs.appUrl
output kvUrl string = kvModule.outputs.kvUrl
output stBlobUrl string = stModule.outputs.stBlobUrl
output stFileUrl string = stModule.outputs.stFileUrl
output stTableUrl string = stModule.outputs.stTableUrl
output stQueueUrl string = stModule.outputs.stQueueUrl