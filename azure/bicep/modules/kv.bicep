@maxLength(24)
param name string
param location string
param tags object = resourceGroup().tags
param tenantId string = subscription().tenantId
@allowed([
  'standard'
  'premium'
])
param sku string = 'standard'
param accessPolicies array = []
param secrets array = []

var family = 'A'

resource kv 'Microsoft.KeyVault/vaults@2021-10-01' = {
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
