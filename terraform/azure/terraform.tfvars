prefix   = "holm-terraform"
location = "WestEurope"
tags = {
  Application = "Terraform"
  Company     = "Holm"
  Environment = "Dev"
  Owner       = "mattias.holm@live.com"
}

appiType = "web"

kvSku        = "standard"
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
  "Purge"
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
  "Set"
]

pipLabels = [
  "foo",
  "bar"
]
pipSku        = "Basic"
pipAllocation = "Dynamic"

stCount        = 2
stKind         = "StorageV2"
stSku          = "Standard"
stReplication  = "LRS"
stPublicAccess = false
stHttpsOnly    = true
stTlsVersion   = "TLS1_2"

vnetToggle        = true
vnetAddressPrefix = "10.0.0.0/24"
