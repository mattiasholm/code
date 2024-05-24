targetScope = 'subscription'

provider microsoftGraph

param range int = 5
output result array = sys.range(1, range)

var prefix = 'mattias-testar'

resource group 'Microsoft.Graph/groups@v1.0' = {
  uniqueName: 'group-${prefix}-001'
  displayName: 'group-${prefix}-001'
  mailNickname: 'group-${prefix}-001'
  securityEnabled: true
  mailEnabled: false
  owners: [
    sp.id
  ]
  members: [
    'd725a3d9-3350-4f0c-b44a-345eb27b4302'
  ]
}

resource app 'Microsoft.Graph/applications@v1.0' = {
  displayName: 'sp-${prefix}-001'
  uniqueName: 'sp-${prefix}-001'
  requiredResourceAccess: [
    {
      resourceAppId: '00000003-0000-0000-c000-000000000000'
      resourceAccess: [
        {
          id: 'df021288-bdef-4463-88db-98f22de89214'
          type: 'Role'
        }
      ]
    }
  ]
  identifierUris: [
    'https://api.b3cloud.onmicrosoft.com'
  ]
  web: {
    redirectUris: [
      'https://portal-api.dustin.com/.auth/login/aad/callback'
    ]
    implicitGrantSettings: {
      enableAccessTokenIssuance: false
      enableIdTokenIssuance: true
    }
  }

  // resource credential 'federatedIdentityCredentials' = {
  //   name: 'github'
  //   audiences: [
  //     'api://AzureADTokenExchange'
  //   ]
  //   issuer: 'https://token.actions.githubusercontent.com'
  //   subject: 'repo:mattiasholm/code:ref:refs/heads/main'
  // }
}

resource sp 'Microsoft.Graph/servicePrincipals@v1.0' = {
  appId: app.appId
}

resource role 'Microsoft.Graph/appRoleAssignedTo@v1.0' = {
  principalId: sp.id
  resourceId: '9bf89b3c-c23d-438c-ac11-4db91749b4b9'
  appRoleId: 'df021288-bdef-4463-88db-98f22de89214'
}
