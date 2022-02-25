param name string
param pdnszName string
param vnetId string
param registrationEnabled bool = false

var location = 'global'

resource pdnsz 'Microsoft.Network/privateDnsZones@2020-06-01' existing = {
  name: pdnszName

  resource link 'virtualNetworkLinks' = {
    name: name
    location: location
    properties: {
      virtualNetwork: {
        id: vnetId
      }
      registrationEnabled: registrationEnabled
    }
  }
}
