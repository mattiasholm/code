var prefix = resourceGroup().name
var location = resourceGroup().location
var tags = resourceGroup().tags

param vnetAddressPrefix string

var vnetName = '${prefix}-VNet01'
var subnetName = 'Subnet01'

resource vnet 'Microsoft.Network/virtualNetworks@2020-06-01' = {
  name: vnetName
  location: location
  tags: tags
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetAddressPrefix
      ]
    }
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: vnetAddressPrefix
        }
      }
    ]
  }
}