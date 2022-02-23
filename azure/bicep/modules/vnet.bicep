param name string
param location string
param tags object = resourceGroup().tags
param addressPrefixes array
param snetName string
param snetAddressPrefix string

resource vnet 'Microsoft.Network/virtualNetworks@2021-03-01' = {
  name: name
  location: location
  tags: tags
  properties: {
    addressSpace: {
      addressPrefixes: addressPrefixes
    }
    subnets: [
      {
        name: snetName
        properties: {
          addressPrefix: snetAddressPrefix
        }
      }
    ]
  }
}

output id string = vnet.id
output name string = vnet.name
