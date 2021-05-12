param name string
param location string
param tags object
@allowed([
  'None'
  'SystemAssigned'
])
param identityType string = 'None'
param planId string
param siteConfig object
param clientAffinityEnabled bool = false
param httpsOnly bool = true

resource app 'Microsoft.Web/sites@2020-12-01' = {
  name: name
  location: location
  tags: tags
  identity: {
    type: identityType
  }
  properties: {
    serverFarmId: planId
    siteConfig: siteConfig
    clientAffinityEnabled: clientAffinityEnabled
    httpsOnly: httpsOnly
  }
}

output url string = app.properties.defaultHostName
output identity string = app.identity.principalId
