@minLength(3)
@maxLength(24)
param name string
param location string
param tags object
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

resource kv 'Microsoft.KeyVault/vaults@2019-09-01' = {
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

output url string = kv.properties.vaultUri
