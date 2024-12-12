using 'main.bicep'

param config = {
  tags: {
    Application: 'Bicep'
    Company: 'Holm'
    Environment: 'Development'
    Owner: 'mattias.holm@b3cloud.onmicrosoft.com'
  }
  logRetention: 30
  pdnszName: 'holm.io'
  pipLabels: [
    'app'
    'web'
  ]
  stCount: 2
  stSku: 'Standard_LRS'
  vnetCidr: '10.0.0.0/24'
  snetCount: 4
  snetSize: 26
  userName: 'mattias.holm@b3cloud.onmicrosoft.com'
  userRole: 'Key Vault Administrator'
}
