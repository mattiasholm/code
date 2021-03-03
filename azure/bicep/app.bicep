targetScope = 'resourceGroup'

param name string
param location string
param tags object
param planId string
param httpsOnly bool

resource app 'Microsoft.Web/sites@2020-06-01' = {
  name: name
  location: location
  tags: tags
  properties: {
    serverFarmId: planId
    httpsOnly: httpsOnly
  }
}

output appUrl string = app.properties.defaultHostName