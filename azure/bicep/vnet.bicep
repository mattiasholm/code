var prefix = resourceGroup().name
var location = resourceGroup().location



param vnetAddressPrefix string = '10.0.0.0/24'

var vnetName = '${prefix}-vnet01'
var subnetName = 'ServerSubnet'

resource vnet 'Microsoft.Network/virtualNetworks@2020-06-01' = {
  name: vnetName
  location: location
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

output vnetId string = vnet.id