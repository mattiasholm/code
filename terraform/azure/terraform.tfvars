prefix   = "holm-terraform"
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

appDockerImages = [
  "nginxdemos/hello:latest",
  "nginxdemos/hello:plain-text"
]
appIdentity       = "SystemAssigned"
appAlwaysOn       = true
appHttp2          = true
appTlsVersion     = "1.2"
appFtpsState      = "FtpsOnly"
appClientAffinity = false
appHttpsOnly      = true

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
  "Restore",
  "Decrypt",
  "Encrypt",
  "UnwrapKey",
  "WrapKey",
  "Verify",
  "Sign",
  "Purge",
  "GetRotationPolicy",
  "Rotate",
  "SetRotationPolicy"
]
kvGroupSecretPermissions = [
  "Get",
  "List",
  "Set",
  "Delete",
  "Recover",
  "Backup",
  "Restore",
  "Purge"
]
kvGroupCertPermissions = [
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
  "DeleteIssuers",
  "Purge"
]
kvSpName = "sp-github-actions"
kvSpSecretPermissions = [
  "Get",
  "Set",
]
kvSecretName = "appiConnectionString"

stCount        = 3
stKind         = "StorageV2"
stSku          = "Standard"
stReplication  = "LRS"
stPublicAccess = false
stHttpsOnly    = true
stTlsVersion   = "TLS1_2"

vnetToggle        = true
vnetAddressPrefix = "10.0.0.0/24"
