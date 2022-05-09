name       = "sp-holm-002"
api        = "00000003-0000-0000-c000-000000000000"
permission = "df021288-bdef-4463-88db-98f22de89214"
role       = "Contributor"
secret     = "github"
days       = 365
audiences = [
  "api://AzureADTokenExchange"
]
issuer = "https://token.actions.githubusercontent.com"
subjects = [
  "repo:mattiasholm/code:ref:refs/heads/main",
  "repo:mattiasholm/code:environment:dev",
  "repo:mattiasholm/code:pull_request"
]
