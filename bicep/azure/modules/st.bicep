@maxLength(24)
param name string
param location string
param tags { *: string } = resourceGroup().tags
param sku string = 'Standard_GRS'
param containers string[] = []

resource st 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: name
  location: location
  tags: tags
  kind: 'StorageV2'
  sku: {
    name: sku
  }

  resource blobServices 'blobServices' = {
    name: 'default'
    properties: {
      deleteRetentionPolicy: {
        allowPermanentDelete: false
        enabled: false
      }
    }

    resource container 'containers' = [
      for container in containers: {
        name: container
        properties: {
          defaultEncryptionScope: '$account-encryption-key'
          denyEncryptionScopeOverride: false
          publicAccess: 'None'
        }
      }
    ]
  }
}

output primaryEndpoints object = st.properties.primaryEndpoints
