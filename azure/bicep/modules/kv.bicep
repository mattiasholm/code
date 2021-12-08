@maxLength(24)
param name string
param location string = resourceGroup().location
param tags object = resourceGroup().tags
param tenantId string = subscription().tenantId
@allowed([
  'standard'
  'premium'
])
param sku string = 'standard'
param accessPolicies array = []
param objectId string
param permissions object
param secrets array

var family = 'A'

resource kv 'Microsoft.KeyVault/vaults@2021-06-01-preview' = {
  name: name
  location: location
  tags: tags
  properties: {
    tenantId: tenantId
    sku: {
      family: family
      name: sku
    }
    accessPolicies: accessPolicies
  }

  resource ap 'accessPolicies' = {
    name: 'add'
    properties: {
      accessPolicies: [
        {
          tenantId: tenantId
          objectId: objectId
          permissions: permissions
        }
      ]
    }
  }

  resource secret 'secrets' = [for secret in secrets: {
    name: secret.name
    tags: tags
    properties: {
      value: secret.value
    }
  }]
}

output name string = kv.name
output vaultUri string = kv.properties.vaultUri
