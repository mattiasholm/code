param name string
param location string
param tags object = resourceGroup().tags
@allowed([
  'web'
  'java'
  'store'
  'ios'
  'phone'
  'other'
])
param kind string = 'web'
param kvName string

var applicationType = kind == 'web' ? 'web' : 'other'

resource appi 'Microsoft.Insights/components@2020-02-02' = {
  name: name
  location: location
  tags: tags
  kind: kind
  properties: {
    Application_Type: applicationType
  }
}

resource kv 'Microsoft.KeyVault/vaults@2022-07-01' existing = {
  name: kvName

  resource secret 'secrets' = {
    name: 'APPLICATIONINSIGHTS-CONNECTION-STRING'
    tags: tags
    properties: {
      value: appi.properties.ConnectionString
    }
  }
}
