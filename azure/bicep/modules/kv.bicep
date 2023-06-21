@maxLength(24)
param name string
param location string
param tags object = resourceGroup().tags
param tenantId string = subscription().tenantId
@allowed([// Replace with UDT once supported
  'standard'
  'premium'
])
param sku string = 'standard'
param accessPolicies array = []

resource kv 'Microsoft.KeyVault/vaults@2022-07-01' = {
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
