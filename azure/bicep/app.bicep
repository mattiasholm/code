var prefix = resourceGroup().name
var location = resourceGroup().location


param planSku string = 'F1'
param planCapacity int = 0

var planName = '${prefix}-AppPlan01'
var planKind = 'app'

resource plan 'Microsoft.Web/serverfarms@2020-06-01' = {
  name: planName
  location: location
  sku: {
    name: planSku
    capacity: planCapacity
  }
}

output planId string = plan.id



var siteName = '${prefix}-App01'
var siteHttpsOnly = true

resource site 'Microsoft.Web/sites@2020-06-01' = {
  name: siteName
  location: location
  properties: {
    serverFarmId: plan.id
    httpsOnly: siteHttpsOnly
  }
}

output siteId string = site.id
output siteUrl string = site.properties.defaultHostName
