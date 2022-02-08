param name string
param location string = resourceGroup().location
param tags object = resourceGroup().tags
param sku string = 'Basic'
param domainNameLabel string

resource pip 'Microsoft.Network/publicIPAddresses@2021-05-01' = {
  name: name
  location: location
  tags: tags
  sku: {
    name: sku
  }
  properties: {
    dnsSettings: {
      domainNameLabel: domainNameLabel
    }
  }
}

output fqdn string = pip.properties.dnsSettings.fqdn
