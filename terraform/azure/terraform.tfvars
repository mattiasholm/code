prefix   = "holm-tf"
location = "WestEurope"
tags = {
  Application = "Terraform"
  Company     = "Holm"
  Environment = "Dev"
  Owner       = "mattias.holm@live.com"
}

planKind     = "linux"
planTier     = "Basic"
planSize     = "B1"
planCapacity = 1

appDockerImageTags = [
  "latest",
  "plain-text"
]
appIdentity              = "SystemAssigned"
appAlwaysOn              = true
appHttp20Enabled         = true
appMinTlsVersion         = "1.2"
appFtpsState             = "FtpsOnly"
appClientAffinityEnabled = false
appHttpsOnly             = true

appiType = "web"

kvSku = "standard"
kvAppSecretPermissions = [
  "Get",
  "List",
]
kvGroupName  = "AzureRBAC-KeyVault"
kvGroupOwner = "mattias.holm@azronnieb3it.onmicrosoft.com"
kvGroupMembers = [
  "mattias.holm@azronnieb3it.onmicrosoft.com"
]
kvGroupKeyPermissions = [
  "Get",
  "List",
  "Update",
  "Create",
  "Import",
  "Delete",
  "Recover",
  "Backup",
  "Restore"
]
kvGroupSecretPermissions = [
  "Get",
  "List",
  "Set",
  "Delete",
  "Recover",
  "Backup",
  "Restore"
]
kvGroupCertificatePermissions = [
  "Get",
  "List",
  "Update",
  "Create",
  "Import",
  "Delete",
  "Recover",
  "Backup",
  "Restore",
  "ManageContacts",
  "ManageIssuers",
  "GetIssuers",
  "ListIssuers",
  "SetIssuers",
  "DeleteIssuers"
]

stCount        = 3
stKind         = "StorageV2"
stSku          = "Standard"
stReplication  = "LRS"
stPublicAccess = false
stHttpsOnly    = true
stTlsVersion   = "TLS1_2"

vnetToggle        = true
vnetAddressPrefix = "10.0.0.0/24"
