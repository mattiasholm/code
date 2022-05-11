param name string
param location string = resourceGroup().location
param tags object = resourceGroup().tags
@allowed([
  'Basic'
  'Standard'
])
param sku string = 'Basic'
@allowed([
  'Dynamic'
  'Static'
])
param publicIPAllocationMethod string = 'Dynamic'
param domainNameLabel string

resource pip 'Microsoft.Network/publicIPAddresses@2021-05-01' = {
  name: name
  location: location
  tags: tags
  sku: {
    name: sku
  }
  properties: {
    publicIPAllocationMethod: publicIPAllocationMethod
    dnsSettings: {
      domainNameLabel: domainNameLabel
    }
  }
}

output fqdn string = pip.properties.dnsSettings.fqdn
