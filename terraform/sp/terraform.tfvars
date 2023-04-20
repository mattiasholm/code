tenant_id       = "9e042b3b-36c4-4b99-8236-728c73166cd9"
subscription_id = "9b184a26-7fff-49ed-9230-d11d484ad51b"
name            = "sp-holm-003"
api             = "MicrosoftGraph"
permissions = {
  roles = [
    "User.Read.All"
  ]
}
role_name         = "Contributor"
secret_name       = "github"
secret_expiration = 365
audiences = [
  "api://AzureADTokenExchange"
]
issuer = "https://token.actions.githubusercontent.com"
subjects = {
  main         = "repo:mattiasholm/code:ref:refs/heads/main"
  pull_request = "repo:mattiasholm/code:pull_request"
  dev          = "repo:mattiasholm/code:environment:dev"
}
