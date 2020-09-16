resource holmLekstuga 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: 'holmLekstuga'
  location: 'WestEurope'
  kind: 'Storage'
  sku: {
    name: 'Standard_LRS'
  }
}