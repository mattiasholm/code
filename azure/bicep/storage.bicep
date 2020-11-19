param globalReplication bool = true

var prefix = resourceGroup().name
var location = resourceGroup().location



var storageName = toLower(replace('${prefix}-Storage01','-',''))
var storageSku = globalReplication ? 'Standard_GRS' : 'Standard_LRS'
var storageKind = 'StorageV2'
var storagePublicAccess = false
var storageHttpsOnly = true
var storageTls = 'TLS1_2'

resource storage 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: storageName
  location: location
  kind: storageKind
  sku: {
    name: storageSku
  }
  properties: {
    allowBlobPublicAccess: storagePublicAccess
    supportsHttpsTrafficOnly: storageHttpsOnly
    minimumTlsVersion: storageTls
  }
}

output storageBlobEndpoint string = storage.properties.primaryEndpoints.blob
output storageFileEndpoint string = storage.properties.primaryEndpoints.file
output storageTableEndpoint string = storage.properties.primaryEndpoints.table
output storageQueueEndpoint string = storage.properties.primaryEndpoints.queue



var containerName = toLower('Container01')

resource container 'Microsoft.Storage/storageAccounts/blobServices/containers@2019-06-01' = {
  name: '${storage.name}/default/${containerName}'
}
