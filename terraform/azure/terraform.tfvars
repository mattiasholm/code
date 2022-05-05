prefix   = "holm-terraform"
location = "WestEurope"
tags = {
  Application = "Terraform"
  Company     = "Holm"
  Environment = "Development"
  Owner       = "mattias.holm@live.com"
}

appiType = "web"

kvSku      = "standard"
kvUsername = "mattias.holm@azronnieb3it.onmicrosoft.com"
kvKeyPermissions = [
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
kvSecretPermissions = [
  "Get",
  "List",
  "Set",
  "Delete",
  "Recover",
  "Backup",
  "Restore",
  "Purge"
]
kvCertificatePermissions = [
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
kvSpName = "sp-holm-001"
kvSpSecretPermissions = [
  "Get",
  "Set",
  "Delete",
  "Recover",
  "Purge"
]

pdnszName         = "holm.io"
pdnszRegistration = false
pdnszTtl          = 3600

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

vnetAddressPrefix = "10.0.0.0/24"
