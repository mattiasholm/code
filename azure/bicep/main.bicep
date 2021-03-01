//https://github.com/alex-frankel/ignite-spring-21 // CopyLoop exempel!

// Ändra namnstandard till MS CAF! rg-holm-bicep + app-holm-001 + vnet-holm-01 VS fullName: app-holm-prod-we-001 - borde isåfall såklart även göras för ARM och Terraform så att de följer samma standard!
// Bryt isär appPlan och site i separata modules + ändra namn på .bicep + modules + resurser enligt MS CAF!
//     dockerImage: 'nginxdemos/hello' - enligt exempel från Alex Frankel - mycket snyggare än default standardsidan från MS ju!

targetScope = 'subscription'

var prefix = 'holm-bicep'
var location = deployment().location
var tags = {
    Company: 'Holm'
    Environment: 'Test'
    Owner: 'mattias.holm@live.com'
    IaC: 'Bicep'
}

var rgName = 'rg-${prefix}' // Snyggast att använda variabel som i resource rg eller tydligare i rg2 när syntaxen ändå är såpass snygg?

// var planName = 'plan-${prefix}-001' // Snyggare???
var planKind = 'app'
var planSku = 'F1' // Hårdkoda vs variabelsätta???
var planCapacity = 0
// var globalReplication = true
// var vnetAddressPrefix = '10.0.0.0/16'

// resource rg 'Microsoft.Resources/resourceGroups@2020-06-01' = {
//     name: rgName
//     location: location
//     tags: tags
// }

// MODULE FÖR RG OCKSÅ ELLER BLIR DET OVERKILL??? Isåfall behöver väl scope inte anges eftersom den defaultar till subscription???
resource rg 'Microsoft.Resources/resourceGroups@2020-06-01' = {
    name: 'rg-${prefix}-001'
    location: location
    tags: tags
}

module planDeploy 'plan.bicep' = {
    name: 'planDeploy'
    scope: resourceGroup(rg.name) //rg
    params: {
        name: 'plan-${prefix}-001'
        location: location
        tags: tags
        kind: planKind
        sku: planSku
        capacity: planCapacity
    }
}

// module kvDeploy 'kv.bicep' = {
//     name: 'kvDeploy'
//     scope: resourceGroup(rg.name) //rg
// }

// module storageDeploy 'storage.bicep' = {
//     name: 'storageDeploy'
//     scope: resourceGroup(rg.name) //rg
//     params: {
//         globalReplication: globalReplication
//     }
// }

// module vnetDeploy 'vnet.bicep' = {
//     name: 'vnetDeploy'
//     scope: resourceGroup(rg.name) //rg
//     params: {
//         vnetAddressPrefix: vnetAddressPrefix
//     }
// }

// output appUrl string = appDeploy.outputs.appUrl
// output keyvaultUrl string = kvDeploy.outputs.keyvaultUrl
// output storageBlobEndpoint string = storageDeploy.outputs.storageBlobEndpoint
// output storageFileEndpoint string = storageDeploy.outputs.storageFileEndpoint
// output storageTableEndpoint string = storageDeploy.outputs.storageTableEndpoint
// output storageQueueEndpoint string = storageDeploy.outputs.storageQueueEndpoint