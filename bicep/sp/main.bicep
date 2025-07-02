targetScope = 'subscription'

extension 'br:mcr.microsoft.com/bicep/extensions/microsoftgraph/v1.0:0.1.8-preview'

param name string
param subjects {
  *: string
}
param permission string

var wellKnown {
  *: {
    appId: string
    id: string
  }
} = {
  MicrosoftGraph: {
    appId: '00000003-0000-0000-c000-000000000000'
    id: '9bf89b3c-c23d-438c-ac11-4db91749b4b9'
  }
}

var roles {
  *: string
} = {
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
          id: roles[permission]
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
      'https://api.b3cloud.onmicrosoft.com/.auth/login/aad/callback'
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
  appRoleId: roles[permission]
}
