param name string
param location string = resourceGroup().location
param tags object = resourceGroup().tags
@allowed([
  'app'
  'linux'
])
param kind string = 'linux'
param skuName string = 'B1'
@minValue(1)
@maxValue(10)
param skuCapacity int = 1

var reserved = kind == 'linux' ? true : false

resource plan 'Microsoft.Web/serverfarms@2021-01-15' = {
  name: name
  location: location
  tags: tags
  kind: kind
  sku: {
    name: skuName
    capacity: skuCapacity
  }
  properties: {
    reserved: reserved
  }
}

output id string = plan.id
