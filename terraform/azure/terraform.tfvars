tenantId       = "9e042b3b-36c4-4b99-8236-728c73166cd9"
subscriptionId = "9b184a26-7fff-49ed-9230-d11d484ad51b"

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
kvUserKeyPermissions = [
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
kvUserSecretPermissions = [
  "Get",
  "List",
  "Set",
  "Delete",
  "Recover",
  "Backup",
  "Restore",
  "Purge"
]
kvUserCertPermissions = [
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
