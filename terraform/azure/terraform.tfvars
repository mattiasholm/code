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

# vnetAddressPrefix = ["10.1.0.0/24"]

# var VS locals! Går såklart använda flera .tfvars-filer om man vill hålla det modulärt!
# Fast å andra sidan vill jag väl bara bryta ut saker saker som faktiskt skiljer mellan Test/Prod?
# global.auto.tfvars + prod.tfvars / test.tfvars