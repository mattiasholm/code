targetScope = 'resourceGroup'

param name string
param location string
param tags object
param addressPrefixes array
param subnetsName string
param subnetsAddressPrefix string

resource vnet 'Microsoft.Network/virtualNetworks@2020-11-01' = {
  name: name
  location: location
  tags: tags
  properties: {
    addressSpace: {
      addressPrefixes: addressPrefixes
    }
    subnets: [
      {
        name: subnetsName
        properties: {
          addressPrefix: subnetsAddressPrefix
        }
      }
    ]
  }
}
