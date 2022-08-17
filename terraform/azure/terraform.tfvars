tenant_id       = "9e042b3b-36c4-4b99-8236-728c73166cd9"
subscription_id = "9b184a26-7fff-49ed-9230-d11d484ad51b"

location = "WestEurope"
tags = {
  Application = "Terraform"
  Company     = "Holm"
  Environment = "Development"
  Owner       = "mattias.holm@live.com"
}

appi_type = "web"

kv_sku       = "standard"
kv_user_name = "mattias.holm@azronnieb3it.onmicrosoft.com"
kv_user_key_permissions = [
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
kv_user_secret_permissions = [
  "Get",
  "List",
  "Set",
  "Delete",
  "Recover",
  "Backup",
  "Restore",
  "Purge"
]
kv_user_cert_permissions = [
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
kv_sp_name = "sp-holm-001"
kv_sp_secret_permissions = [
  "Get",
  "Set",
  "Delete",
  "Recover",
  "Purge"
]

pdnsz_name         = "holm.io"
pdnsz_registration = false
pdnsz_ttl          = 3600

pip_labels = {
  "001" = "foo"
  "002" = "bar"
}
pip_sku        = "Basic"
pip_allocation = "Dynamic"

st_count         = 2
st_kind          = "StorageV2"
st_sku           = "Standard"
st_replication   = "LRS"
st_public_access = false
st_https_only    = true
st_tls_version   = "TLS1_2"

vnet_address_prefix = "10.0.0.0/24"
