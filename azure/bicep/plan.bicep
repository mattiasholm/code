targetScope = 'resourceGroup'

param name string
param location string
param tags object
param kind string {
  allowed: [
    'app'
    'linux'
  ]
  default: 'app'
}
param skuName string {
  allowed: [
    'F1'
    'B1'
    'S1'
  ]
  default: 'F1'
}
param skuCapacity int {
  minValue: 0
  maxValue: 10
  default: 0
}

resource plan 'Microsoft.Web/serverfarms@2020-06-01' = {
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