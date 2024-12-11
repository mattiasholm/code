tenant_id       = "34311a99-c681-4ecd-88ce-eab1d59f443a"
subscription_id = "804fd219-0c15-45f9-ae36-0a4d3725848f"
name            = "sp-holm-03"
api             = "MicrosoftGraph"
permissions = {
  roles = [
    "User.Read.All"
  ]
}
role_name       = "Owner"
secret_name     = "github"
secret_rotation = 365
audiences = [
  "api://AzureADTokenExchange"
]
issuer = "https://token.actions.githubusercontent.com"
subjects = {
  main         = "repo:mattiasholm/code:ref:refs/heads/main"
  pull_request = "repo:mattiasholm/code:pull_request"
  dev          = "repo:mattiasholm/code:environment:dev"
}
