targetScope = 'subscription'

var rgName = 'holm-bicep'
var rgLocation = 'WestEurope'
var planSku = 'F1'
var planCapacity = 0
var globalReplication = true
var vnetAddressPrefix = '10.0.0.0/16'



resource rg 'Microsoft.Resources/resourceGroups@2019-05-01' = {
    name: rgName
    location: rgLocation
}

module app './app.bicep' = {
    scope: resourceGroup(rg.name)
    name: 'app'
    params: {
        planSku: planSku
        planCapacity: planCapacity
    }
}

module keyvault './keyvault.bicep' = {
    scope: resourceGroup(rg.name)
    name: 'keyvault'
}

module storage './storage.bicep' = {
    scope: resourceGroup(rg.name)
    name: 'storage'
    params: {
        globalReplication: globalReplication
    }
}

module vnet './vnet.bicep' = {
    scope: resourceGroup(rg.name)
    name: 'vnet'
    params: {
        vnetAddressPrefix: vnetAddressPrefix
    }
}



output appUrl string = app.outputs.appUrl
output keyvaultUrl string = keyvault.outputs.keyvaultUrl
output storageBlobEndpoint string = storage.outputs.storageBlobEndpoint
output storageFileEndpoint string = storage.outputs.storageFileEndpoint
output storageTableEndpoint string = storage.outputs.storageTableEndpoint
output storageQueueEndpoint string = storage.outputs.storageQueueEndpoint
output vnetDdosProtection bool = vnet.outputs.vnetDdosProtection
output vnetVmProtection bool = vnet.outputs.vnetVmProtection
