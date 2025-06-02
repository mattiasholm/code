type subnet = {
  name: string
  addressPrefix: string
}

param name string
param location string
param tags object = resourceGroup().tags
param addressPrefixes string[]
param subnets subnet[] = []

resource vnet 'Microsoft.Network/virtualNetworks@2024-07-01' = {
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
    privateEndpointVNetPolicies: 'Disabled'
  }
}

output id string = vnet.id
output subnets object[] = vnet.properties.subnets
