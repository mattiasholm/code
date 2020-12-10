var prefix = resourceGroup().name
var location = resourceGroup().location
var tags = resourceGroup().tags

var keyvaultName = '${prefix}-KeyVault01'
var keyvaultFamily = 'A'
var keyvaultSku = 'standard'

resource keyvault 'Microsoft.KeyVault/vaults@2019-09-01' = {
  name: keyvaultName
  location: location
  tags: tags
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