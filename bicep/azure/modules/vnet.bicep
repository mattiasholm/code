param name string
param location string
param tags object = resourceGroup().tags
param addressPrefixes string[]
param subnets { name: string, addressPrefix: string }[] = []

resource vnet 'Microsoft.Network/virtualNetworks@2024-01-01' = {
  name: name
  location: location
  tags: tags
  properties: {
    addressSpace: {
      addressPrefixes: addressPrefixes
    }
    subnets: [
      for subnet in subnets: {
        name: subnet.name
        properties: {
          addressPrefix: subnet.addressPrefix
        }
      }
    ]
  }
}

output name string = vnet.name
output id string = vnet.id
