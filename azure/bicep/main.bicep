targetScope = 'subscription'



// OBS: Eventuellt snyggare att även bryta ut rg.bicep som module och kalla på denna från main?!
var rgName = 'holm-bicep'
var rgLocation = 'WestEurope'

resource rg 'Microsoft.Resources/resourceGroups@2019-05-01' = {
    name: rgName
    location: rgLocation
}

module keyvault './keyvault.bicep' = {
    // scope: rg
    // scope: resourceGroup(rg.id)
    scope: resourceGroup(rg.name)
    name: 'keyvault'
    // params: {}
}

module storage './storage.bicep' = {
    // scope: rg
    // scope: resourceGroup(rg.id)
    scope: resourceGroup(rg.name)
    name: 'storage'
    params: {
        globalReplication: true
    }
}

output keyvaultUrl string = keyvault.outputs.keyvaultUrl
output storageBlobEndpoint string = storage.outputs.storageBlobEndpoint