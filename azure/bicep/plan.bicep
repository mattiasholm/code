param name string
param location string
param tags object
param kind string
param sku string
param capacity int

resource plan 'Microsoft.Web/serverfarms@2020-06-01' = {
  name: name
  location: location
  tags: tags
  kind: kind
  sku: {
    name: sku
    capacity: capacity
  }
}

// output planId??? Nödvändigt???