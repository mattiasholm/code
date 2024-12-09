tenant_id       = "34311a99-c681-4ecd-88ce-eab1d59f443a"
subscription_id = "804fd219-0c15-45f9-ae36-0a4d3725848f"
location        = "WestEurope"
tags = {
  Application = "Terraform"
  Company     = "Holm"
  Environment = "Development"
  Owner       = "mattias.holm@b3cloud.onmicrosoft.com"
}
appi_type    = "web"
kv_sku       = "standard"
kv_user_name = "mattias.holm@b3cloud.onmicrosoft.com"
kv_user_secret_permissions = [
  "Get",
  "List",
  "Set",
  "Delete",
  "Recover",
  "Backup",
  "Restore",
  "Purge",
]
kv_sp_name = "sp-holm-01"
kv_sp_secret_permissions = [
  "Get",
  "Set",
  "Delete",
  "Recover",
  "Purge",
]
pdnsz_name         = "holm.io"
pdnsz_registration = false
pdnsz_ttl          = 3600
pip_labels = [
  "app",
  "web",
]
pip_sku             = "Basic"
pip_allocation      = "Dynamic"
st_count            = 2
st_kind             = "StorageV2"
st_sku              = "Standard"
st_replication      = "LRS"
st_public_access    = false
st_https_only       = true
st_tls_version      = "TLS1_2"
vnet_address_prefix = "10.0.0.0/24"
vnet_subnet_size    = 26
vnet_subnet_count   = 4
