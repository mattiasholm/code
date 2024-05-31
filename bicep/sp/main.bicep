targetScope = 'subscription'

provider microsoftGraph // Until implicitProviders works!

param name string
param subjects object

var wellKnown = {
  MicrosoftGraph: {
    appId: '00000003-0000-0000-c000-000000000000'
    id: '9bf89b3c-c23d-438c-ac11-4db91749b4b9'
  }
}
var roles = {
  'User.Read.All': 'df021288-bdef-4463-88db-98f22de89214'
}

resource app 'Microsoft.Graph/applications@v1.0' = {
  displayName: name
  uniqueName: name
  requiredResourceAccess: [
    {
      resourceAppId: wellKnown.MicrosoftGraph.appId
      resourceAccess: [
        {
          id: roles['User.Read.All']
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

  resource credential 'federatedIdentityCredentials' = [
    for subject in items(subjects): {
      // name: subject.key
      name: '${app.uniqueName}/${subject.key}' // Temporary workaround
      audiences: [
        'api://AzureADTokenExchange'
      ]
      issuer: 'https://token.actions.githubusercontent.com'
      subject: subject.value
    }
  ]
}

resource sp 'Microsoft.Graph/servicePrincipals@v1.0' = {
  appId: app.appId
}

resource role 'Microsoft.Graph/appRoleAssignedTo@v1.0' = {
  principalId: sp.id
  resourceId: wellKnown.MicrosoftGraph.id
  appRoleId: roles['User.Read.All']
}
