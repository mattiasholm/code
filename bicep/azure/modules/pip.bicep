param name string
param location string
param tags {
  *: string
} = resourceGroup().tags
param domainNameLabel string

resource pip 'Microsoft.Network/publicIPAddresses@2024-07-01' = {
  name: name
  location: location
  tags: tags
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
    dnsSettings: {
      domainNameLabel: domainNameLabel
    }
    ddosSettings: {
      protectionMode: 'VirtualNetworkInherited'
    }
  }
}

output fqdn string = pip.properties.dnsSettings.fqdn
