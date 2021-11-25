param name string
param location string = resourceGroup().location
param tags object = resourceGroup().tags
@allowed([
  'app'
  'linux'
])
param kind string = 'linux'
param sku string = 'B1'
@minValue(1)
@maxValue(10)
param capacity int = 1

var reserved = kind == 'linux' ? true : false

resource plan 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: name
  location: location
  tags: tags
  kind: kind
  sku: {
    name: sku
    capacity: capacity
  }
  properties: {
    reserved: reserved
  }
}

output id string = plan.id
