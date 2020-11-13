var prefix = resourceGroup().name
var location = resourceGroup().location



var keyvaultName = '${prefix}-KeyVault01'
var keyvaultFamily = 'A'
var keyvaultSku = 'Standard'

resource keyvault 'Microsoft.KeyVault/vaults@2019-09-01' = {    
    name: keyvaultName       
    location: location 
    properties: {
          tenantId: subscription().tenantId
        sku: {
            family: keyvaultFamily
            name: keyvaultSku
        }
        accessPolicies: []
    }
  }

output keyvaultUrl string = keyvault.properties.vaultUri
