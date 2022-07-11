tenantId       = "9e042b3b-36c4-4b99-8236-728c73166cd9"
subscriptionId = "9b184a26-7fff-49ed-9230-d11d484ad51b"

name       = "sp-holm-003"
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
