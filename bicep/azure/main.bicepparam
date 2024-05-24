using 'main.bicep'

param config = {
  tags: {
    Application: 'Bicep'
    Company: 'Holm'
    Environment: 'Development'
    Owner: 'mattias.holm@b3cloud.onmicrosoft.com'
  }
  appi: {
    kind: 'web'
  }
  kv: {
    sku: 'standard'
    objectId: 'd725a3d9-3350-4f0c-b44a-345eb27b4302'
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
      'app'
      'web'
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
    subnetSize: 26
    subnetCount: 4
  }
}
