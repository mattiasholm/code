param name string
param location string
param tags { *: string } = resourceGroup().tags
param retentionInDays int = 30
param kvName string

resource log 'Microsoft.OperationalInsights/workspaces@2023-09-01' = {
  name: name
  location: location
  tags: tags
  properties: {
    sku: {
      name: 'PerGB2018'
    }
    retentionInDays: retentionInDays
  }
}

resource kv 'Microsoft.KeyVault/vaults@2023-07-01' existing = {
  name: kvName

  resource secret 'secrets' = {
    name: 'log-workspace-id'
    tags: tags
    properties: {
      value: log.properties.customerId
    }
  }
}
