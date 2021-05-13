param name string
param location string
param tags object
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

resource appi 'Microsoft.Insights/components@2015-05-01' = {
  name: name
  location: location
  tags: tags
  kind: kind
  properties: {
    Application_Type: Application_Type
  }
}

output connectionString string = appi.properties.ConnectionString
