targetScope = 'resourceGroup'

param name string
param location string
param tags object
param planId string
param siteConfig object
param clientAffinityEnabled bool = false
param httpsOnly bool = true

resource app 'Microsoft.Web/sites@2020-06-01' = {
  name: name
  location: location
  tags: tags
  properties: {
    serverFarmId: planId
    siteConfig: siteConfig
    clientAffinityEnabled: clientAffinityEnabled
    httpsOnly: httpsOnly
  }
}

output appUrl string = app.properties.defaultHostName