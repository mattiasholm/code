targetScope = 'resourceGroup'

param name string
param location string
param tags object
@allowed([
  'app'
  'linux'
])
param kind string = 'linux'
param skuName string = 'B1'
@minValue(1)
@maxValue(10)
param skuCapacity int = 1

resource plan 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: name
  location: location
  tags: tags
  kind: kind
  sku: {
    name: skuName
    capacity: skuCapacity
  }
  properties: {
    reserved: kind == 'linux' ? true : false
  }
}

output planId string = plan.id
