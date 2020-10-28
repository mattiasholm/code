param prefix string = 'holmLekstuga'
param location string = 'WestEurope'

var storageName = '${prefix}storage01'
var storageSku = 'Standard_GRS'

resource storage 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: '${storageName}'
  location: '${location}'
  kind: 'Storage'
  sku: {
    name: '${storageSku}'
  }
}

output storageId string = storage.id