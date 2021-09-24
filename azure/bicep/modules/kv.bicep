@minLength(3)
@maxLength(24)
param name string
param location string = resourceGroup().location
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
param objectId string
param permissions object
param secretName string
param secretValue string

resource kv 'Microsoft.KeyVault/vaults@2021-06-01-preview' = {
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

  resource secret 'secrets' = {
    name: secretName
    tags: tags
    properties: {
      value: secretValue
    }
  }
}

output name string = kv.name
output vaultUri string = kv.properties.vaultUri
