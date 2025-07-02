@maxLength(24)
param name string
param location string
param tags {
  *: string
} = resourceGroup().tags

resource kv 'Microsoft.KeyVault/vaults@2024-11-01' = {
  name: name
  location: location
  tags: tags
  properties: {
    tenantId: tenant().tenantId
    sku: {
      family: 'A'
      name: 'standard'
    }
    enableRbacAuthorization: true
  }
}

output vaultUri string = kv.properties.vaultUri
