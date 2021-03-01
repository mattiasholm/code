var prefix = resourceGroup().name
var location = resourceGroup().location
var tags = resourceGroup().tags

//
param name string
//
param sku string
param capacity int

var appName = '${prefix}-App01'
var appHttpsOnly = true

resource app 'Microsoft.Web/sites@2020-06-01' = {
  name: appName
  location: location
  tags: tags
  properties: {
    serverFarmId: plan.id
    httpsOnly: appHttpsOnly
  }
}

output appUrl string = app.properties.defaultHostName