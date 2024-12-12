tenant_id       = "34311a99-c681-4ecd-88ce-eab1d59f443a"
subscription_id = "804fd219-0c15-45f9-ae36-0a4d3725848f"
location        = "WestEurope"
tags = {
  Application = "Terraform"
  Company     = "Holm"
  Environment = "Development"
  Owner       = "mattias.holm@b3cloud.onmicrosoft.com"
}
log_retention = 30
pdnsz_name    = "holm.io"
pip_labels = [
  "app",
  "web",
]
st_count   = 2
st_sku     = "Standard_LRS"
vnet_cidr  = "10.0.0.0/24"
snet_count = 4
snet_size  = 26
user_name  = "mattias.holm@b3cloud.onmicrosoft.com"
user_role  = "Key Vault Administrator"
sp_name    = "sp-holm-01"
sp_role    = "Key Vault Secrets Officer"
