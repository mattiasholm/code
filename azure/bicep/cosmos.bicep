var prefix = resourceGroup().name
var location = resourceGroup().location



var cosmosName = toLower('${prefix}-Cosmos01')
var cosmosConsistency = 'Session'
var cosmosOffer = 'Standard'

resource cosmos 'Microsoft.DocumentDB/databaseAccounts@2020-04-01' = {
  name: cosmosName
  location: location
  properties: {
    databaseAccountOfferType: cosmosOffer
    consistencyPolicy: {
      defaultConsistencyLevel: cosmosConsistency
    }
  }
}

output cosmosId string = cosmos.id