param name string
param tags { *: string } = resourceGroup().tags
param vnetName string
param vnetId string
param cnames { name: string, cname: string }[] = []

var location = 'global'

resource pdnsz 'Microsoft.Network/privateDnsZones@2024-06-01' = {
  name: name
  location: location
  tags: tags

  resource link 'virtualNetworkLinks' = {
    name: vnetName
    location: location
    tags: tags
    properties: {
      virtualNetwork: {
        id: vnetId
      }
      registrationEnabled: false
    }
  }

  resource cname 'CNAME' = [
    for cname in cnames: {
      name: cname.name
      properties: {
        ttl: 3600
        cnameRecord: {
          cname: cname.cname
        }
      }
    }
  ]
}

output fqdn string[] = [for (_, i) in cnames: pdnsz::cname[i].properties.fqdn]
