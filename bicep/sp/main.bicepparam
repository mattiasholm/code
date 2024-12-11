using 'main.bicep'

param name = 'sp-holm-04'

param subjects = {
  main: 'repo:mattiasholm/code:ref:refs/heads/main'
  pull_request: 'repo:mattiasholm/code:pull_request'
  dev: 'repo:mattiasholm/code:environment:dev'
}

param permission = 'User.Read.All'
