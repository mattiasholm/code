var prefix = resourceGroup().name
var location = resourceGroup().location

param vnetAddressPrefix string

var vnetName = '${prefix}-VNet01'
var subnetName = 'Subnet01'

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

output vnetDdosProtection bool = vnet.properties.enableDdosProtection
output vnetVmProtection bool = vnet.properties.enableVmProtection