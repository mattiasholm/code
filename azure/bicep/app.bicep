var prefix = resourceGroup().name
var location = resourceGroup().location



var planName = '${prefix}-AppPlan01'
var planKind = 'app'
var planSku = 'F1'
var planCapacity = 0


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

resource site 'Microsoft.Web/sites@2020-06-01' = {
  name: siteName
  location: location
  properties: {
    serverFarmId: planName
  }
}

output siteId string = site.id