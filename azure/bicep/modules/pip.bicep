param name string
param location string
param tags object = resourceGroup().tags
param sku 'Basic' | 'Standard' = 'Basic'
param publicIPAllocationMethod 'Dynamic' | 'Static' = 'Dynamic'
param domainNameLabel string

resource pip 'Microsoft.Network/publicIPAddresses@2022-01-01' = {
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
