param name string
param location string = resourceGroup().location
param tags object = resourceGroup().tags
@allowed([
  'None'
  'SystemAssigned'
])
param identityType string = 'None'
param serverFarmId string
param siteConfig object = {}
param clientAffinityEnabled bool = false
param httpsOnly bool = true

resource app 'Microsoft.Web/sites@2021-02-01' = {
  name: name
  location: location
  tags: tags
  identity: {
    type: identityType
  }
  properties: {
    serverFarmId: serverFarmId
    siteConfig: siteConfig
    clientAffinityEnabled: clientAffinityEnabled
    httpsOnly: httpsOnly
  }
}

output defaultHostName string = app.properties.defaultHostName
output identity object = app.identity
