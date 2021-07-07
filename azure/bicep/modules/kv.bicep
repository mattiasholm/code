@minLength(3)
@maxLength(24)
param name string
param location string
param tags object = resourceGroup().tags
param tenantId string = subscription().tenantId
@allowed([
  'A'
])
param skuFamily string = 'A'
@allowed([
  'standard'
  'premium'
])
param skuName string = 'standard'
param accessPolicies array = []

resource kv 'Microsoft.KeyVault/vaults@2021-04-01-preview' = {
  name: name
  location: location
  tags: tags
  properties: {
    tenantId: tenantId
    sku: {
      family: skuFamily
      name: skuName
    }
    accessPolicies: accessPolicies
  }
}

output vaultUri string = kv.properties.vaultUri
