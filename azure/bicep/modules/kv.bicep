@maxLength(24)
param name string
param location string
param tags object = resourceGroup().tags
param tenantId string = subscription().tenantId
param sku 'standard' | 'premium' = 'standard'
param accessPolicies { objectId: string, permissions: object }[] = []

resource kv 'Microsoft.KeyVault/vaults@2023-02-01' = {
  name: name
  location: location
  tags: tags
  properties: {
    tenantId: tenantId
    sku: {
      family: 'A'
      name: sku
    }
    accessPolicies: [for accessPolicy in accessPolicies: {
      tenantId: tenantId
      objectId: accessPolicy.objectId
      permissions: accessPolicy.permissions
    }]
  }
}

output name string = kv.name
output vaultUri string = kv.properties.vaultUri
