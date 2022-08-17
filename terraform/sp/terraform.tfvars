tenant_id       = "9e042b3b-36c4-4b99-8236-728c73166cd9"
subscription_id = "9b184a26-7fff-49ed-9230-d11d484ad51b"

name              = "sp-holm-003"
api               = "00000003-0000-0000-c000-000000000000"
permission        = "df021288-bdef-4463-88db-98f22de89214"
role_name         = "Contributor"
secret_name       = "github"
secret_expiration = 365
audiences = [
  "api://AzureADTokenExchange"
]
issuer = "https://token.actions.githubusercontent.com"
subjects = {
  main         = "repo:mattiasholm/code:ref:refs/heads/main"
  dev          = "repo:mattiasholm/code:environment:dev"
  pull_request = "repo:mattiasholm/code:pull_request"
}
