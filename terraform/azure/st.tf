resource "azurerm_storage_account" "st" {
  count                           = var.stCount
  name                            = "st${local.prefixStripped}${format("%03d", count.index + 1)}"
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = var.location
  tags                            = var.tags
  account_kind                    = var.stKind
  account_tier                    = var.stSku
  account_replication_type        = var.stReplication
  allow_nested_items_to_be_public = var.stPublicAccess
  enable_https_traffic_only       = var.stHttpsOnly
  min_tls_version                 = var.stTlsVersion
}

resource "azurerm_storage_container" "container" {
  count                = var.stCount
  name                 = "container${local.prefixStripped}001"
  storage_account_name = azurerm_storage_account.st[count.index].name
}
