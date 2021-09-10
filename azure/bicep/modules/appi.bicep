param name string
param location string = resourceGroup().location
param tags object = resourceGroup().tags
@allowed([
  'web'
  'ios'
  'other'
  'store'
  'java'
  'phone'
])
param kind string = 'web'
@allowed([
  'web'
  'other'
])
param Application_Type string = 'web'

resource appi 'Microsoft.Insights/components@2020-02-02' = {
  name: name
  location: location
  tags: tags
  kind: kind
  properties: {
    Application_Type: Application_Type
  }
}

output connectionString string = appi.properties.ConnectionString
