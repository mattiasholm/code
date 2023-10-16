param name string
param tags object = resourceGroup().tags
param vnetName string
param vnetId string
param registrationEnabled bool = false
param ttl int = 3600
param cnameRecords { name: string, cname: string }[] = []

var location = 'global'

resource pdnsz 'Microsoft.Network/privateDnsZones@2020-06-01' = {
  name: name
  location: location
  tags: tags

  resource link 'virtualNetworkLinks' = {
    name: vnetName
    location: location
    properties: {
      virtualNetwork: {
        id: vnetId
      }
      registrationEnabled: registrationEnabled
    }
  }

  resource cname 'CNAME' = [for cnameRecord in cnameRecords: {
    name: cnameRecord.name
    properties: {
      ttl: ttl
      cnameRecord: {
        cname: cnameRecord.cname
      }
    }
  }]
}

output fqdn array = [for (cnameRecord, i) in cnameRecords: pdnsz::cname[i].properties.fqdn]
