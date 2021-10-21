param name string
param location string = resourceGroup().location
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
