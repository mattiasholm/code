param name string
param location string = resourceGroup().location
param tags object = resourceGroup().tags
@allowed([
  'Basic'
  'Standard'
])
param sku string = 'Basic'
param domainNameLabel string
@allowed([
  'Dynamic'
  'Static'
])
param publicIPAllocationMethod string = 'Dynamic'

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
    publicIPAllocationMethod: publicIPAllocationMethod
  }
}

output fqdn string = pip.properties.dnsSettings.fqdn
