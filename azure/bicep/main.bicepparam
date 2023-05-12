using 'main.bicep'

param config = {
  location: 'westeurope'
  tags: {
    Application: 'Bicep'
    Company: 'Holm'
    Environment: 'Development'
    Owner: 'mattias.holm@live.com'
  }
  appi: {
    kind: 'web'
  }
  kv: {
    sku: 'standard'
    objectId: 'e1d37e09-c819-457e-9b93-44b8c784f539'
    permissions: {
      keys: [
        'Get'
        'List'
        'Update'
        'Create'
        'Import'
        'Delete'
        'Recover'
        'Backup'
        'Restore'
        'Decrypt'
        'Encrypt'
        'UnwrapKey'
        'WrapKey'
        'Verify'
        'Sign'
        'Purge'
      ]
      secrets: [
        'Get'
        'List'
        'Set'
        'Delete'
        'Recover'
        'Backup'
        'Restore'
        'Purge'
      ]
      certificates: [
        'Get'
        'List'
        'Update'
        'Create'
        'Import'
        'Delete'
        'Recover'
        'Backup'
        'Restore'
        'ManageContacts'
        'ManageIssuers'
        'GetIssuers'
        'ListIssuers'
        'SetIssuers'
        'DeleteIssuers'
        'Purge'
      ]
    }
  }
  pdnsz: {
    name: 'holm.io'
    registration: false
    ttl: 3600
  }
  pip: {
    labels: [
      'foo'
      'bar'
    ]
    sku: 'Basic'
    allocation: 'Dynamic'
  }
  st: {
    count: 2
    kind: 'StorageV2'
    sku: 'Standard_LRS'
    publicAccess: false
    httpsOnly: true
    tlsVersion: 'TLS1_2'
  }
  vnet: {
    addressPrefix: '10.0.0.0/24'
  }
}
