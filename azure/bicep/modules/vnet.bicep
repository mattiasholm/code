param name string
param location string
param tags object = resourceGroup().tags
param addressPrefixes array
param subnets array = []

resource vnet 'Microsoft.Network/virtualNetworks@2021-08-01' = {
  name: name
  location: location
  tags: tags
  properties: {
    addressSpace: {
      addressPrefixes: addressPrefixes
    }
    subnets: [for subnet in subnets: {
      name: subnet.name
      properties: {
        addressPrefix: subnet.addressPrefix
      }
    }]
  }
}

output name string = vnet.name
output id string = vnet.id
