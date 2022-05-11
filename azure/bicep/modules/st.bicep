@maxLength(24)
param name string
param location string = resourceGroup().location
param tags object = resourceGroup().tags
@allowed([
  'Storage'
  'StorageV2'
  'BlobStorage'
  'FileStorage'
  'BlockBlobStorage'
])
param kind string = 'StorageV2'
@allowed([
  'Standard_LRS'
  'Standard_ZRS'
  'Standard_GRS'
  'Standard_RAGRS'
  'Standard_GZRS'
  'Standard_RAGZRS'
  'Premium_LRS'
  'Premium_ZRS'
])
param sku string = 'Standard_LRS'
param allowBlobPublicAccess bool = false
param supportsHttpsTrafficOnly bool = true
@allowed([
  'TLS1_0'
  'TLS1_1'
  'TLS1_2'
])
param minimumTlsVersion string = 'TLS1_2'
param containers array = []

resource st 'Microsoft.Storage/storageAccounts@2021-08-01' = {
  name: name
  location: location
  tags: tags
  kind: kind
  sku: {
    name: sku
  }
  properties: {
    allowBlobPublicAccess: allowBlobPublicAccess
    supportsHttpsTrafficOnly: supportsHttpsTrafficOnly
    minimumTlsVersion: minimumTlsVersion
  }

  resource blobServices 'blobServices' = {
    name: 'default'

    resource container 'containers' = [for container in containers: {
      name: container
    }]
  }
}

output primaryEndpoints object = st.properties.primaryEndpoints
