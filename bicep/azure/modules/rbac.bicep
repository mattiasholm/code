param userName string
param userRole string

var users = {
  'mattias.holm@b3cloud.onmicrosoft.com': 'd725a3d9-3350-4f0c-b44a-345eb27b4302'
}

var roles = {
  'Key Vault Administrator': '00482a5a-887f-4fb3-b363-3b7fe8e74483'
}

resource role 'Microsoft.Authorization/roleDefinitions@2022-04-01' existing = {
  name: roles[userRole]
  scope: subscription()
}

resource rbac 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(resourceGroup().id, users[userName], role.id)
  properties: {
    principalId: users[userName]
    roleDefinitionId: role.id
  }
}
