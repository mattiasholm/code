@maxLength(24)
param name string
param location string
param tags object = resourceGroup().tags
param kind 'Storage' | 'StorageV2' | 'BlobStorage' | 'FileStorage' | 'BlockBlobStorage' = 'StorageV2'
param sku 'Standard_LRS' | 'Standard_ZRS' | 'Standard_GRS' | 'Standard_RAGRS' | 'Standard_GZRS' | 'Standard_RAGZRS' | 'Premium_LRS' | 'Premium_ZRS' = 'Standard_LRS'
param allowBlobPublicAccess bool = false
param supportsHttpsTrafficOnly bool = true
param minimumTlsVersion 'TLS1_0' | 'TLS1_1' | 'TLS1_2' = 'TLS1_2'
param containers string[] = []

resource st 'Microsoft.Storage/storageAccounts@2023-01-01' = {
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
