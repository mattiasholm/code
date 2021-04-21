targetScope = 'resourceGroup'

@minLength(3)
@maxLength(24)
param name string
param location string
param tags object
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
  'Standard_GRS'
  'Standard_RAGRS'
  'Standard_ZRS'
  'Premium_LRS'
  'Premium_ZRS'
  'Standard_GZRS'
  'Standard_RAGZRS'
])
param skuName string = 'Standard_LRS'
param allowBlobPublicAccess bool = false
param supportsHttpsTrafficOnly bool = true
@allowed([
  'TLS1_0'
  'TLS1_1'
  'TLS1_2'
])
param minimumTlsVersion string = 'TLS1_2'

resource st 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: name
  location: location
  tags: tags
  kind: kind
  sku: {
    name: skuName
  }
  properties: {
    allowBlobPublicAccess: allowBlobPublicAccess
    supportsHttpsTrafficOnly: supportsHttpsTrafficOnly
    minimumTlsVersion: minimumTlsVersion
  }
}

output stBlobUrl string = st.properties.primaryEndpoints.blob
output stFileUrl string = st.properties.primaryEndpoints.file
output stTableUrl string = st.properties.primaryEndpoints.table
output stQueueUrl string = st.properties.primaryEndpoints.queue
