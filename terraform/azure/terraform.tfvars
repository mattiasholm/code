prefix   = "holm-tf"
location = "WestEurope"
tags = {
  Application = "Terraform"
  Company     = "Holm"
  Environment = "Test"
  Owner       = "mattias.holm@live.com"
}

planKind     = "linux"
planTier     = "Basic"
planSize     = "B1"
planCapacity = 1

apps = [
  {
    dockerImageTag = "latest"
  },
  {
    dockerImageTag = "plain-text"
  }
]
appIdentity              = "SystemAssigned"
appAlwaysOn              = true
appHttp20Enabled         = true
appMinTlsVersion         = "1.2"
appFtpsState             = "FtpsOnly"
appClientAffinityEnabled = false
appHttpsOnly             = true