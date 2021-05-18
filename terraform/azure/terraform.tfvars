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

appIdentity = "SystemAssigned"
appLinuxFxVersion = "DOCKER|nginxdemos/hello:latest"
appAlwaysOn = true
appHttp20Enabled = true
appMinTlsVersion = "1.2"
appFtpsState = "FtpsOnly"
appClientAffinityEnabled = false
appHttpsOnly = true

# vnetAddressPrefix = ["10.1.0.0/24"]