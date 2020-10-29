param globalReplication bool = true

var prefix = resourceGroup().name
var location = resourceGroup().location



var storageName = toLower('${prefix}storage01')
var storageSku = globalReplication ? 'Standard_GRS' : 'Standard_LRS'
var storageKind = 'StorageV2'
var storageTls = 'TLS1_2'

resource storage 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: storageName
  location: location
  kind: storageKind
  sku: {
    name: storageSku
  }
  properties: {
    minimumTlsVersion: storageTls
  }
}

output storageId string = storage.id
output storageBlobEndpoint string = storage.properties.primaryEndpoints.blob
output storageObject object = storage



var containerName = 'logs'

resource container 'Microsoft.Storage/storageAccounts/blobServices/containers@2019-06-01' = {
  name: '${storage.name}/default/${containerName}'
}

output containerId string = container.id