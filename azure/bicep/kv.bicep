targetScope = 'resourceGroup'

param name string
param location string
param tags object
param tenantId string
param skuFamily string {
  allowed: [
    'A'
  ]
  default: 'A'
}
param skuName string {
  allowed: [
    'standard'
    'premium'
  ]
  default: 'standard'
}
param accessPolicies array

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

output kvUrl string = kv.properties.vaultUri