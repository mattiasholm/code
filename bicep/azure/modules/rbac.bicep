param objectId string
param roleId string

resource role 'Microsoft.Authorization/roleDefinitions@2022-04-01' existing = {
  name: roleId
  scope: subscription()
}

resource rbac 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(resourceGroup().id, objectId, role.id)
  properties: {
    principalId: objectId
    roleDefinitionId: role.id
  }
}
