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
  objectId: 'd725a3d9-3350-4f0c-b44a-345eb27b4302'
  roleId: '00482a5a-887f-4fb3-b363-3b7fe8e74483'
}
