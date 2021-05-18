# locals {
#   prefixStripped = lower(replace(var.prefix, "-",""))
# }

# locals {
#   storageCount        = 3
#   storageName         = lower(replace("${local.prefix}-Storage0", "-", ""))
#   storageTier         = "Standard"
#   storageReplication  = "GRS"
#   storageKind         = "StorageV2"
#   storagePublicAccess = false
#   storageHttpsOnly    = true
#   storageTls          = "TLS1_2"
# }

# resource "azurerm_storage_account" "storage" {
#   count                     = local.storageCount
#   name                      = "${local.storageName}${count.index + 1}"
#   resource_group_name       = var.rgName
#   location                  = var.location
#   tags                      = var.tags
#   account_tier              = local.storageTier
#   account_replication_type  = local.storageReplication
#   account_kind              = local.storageKind
#   allow_blob_public_access  = local.storagePublicAccess
#   enable_https_traffic_only = local.storageHttpsOnly
#   min_tls_version           = local.storageTls
# }

# output "storageBlobEndpoint" {
#   value = azurerm_storage_account.storage[*].primary_blob_endpoint
# }

# output "storageQueueEndpoint" {
#   value = azurerm_storage_account.storage[*].primary_queue_endpoint
# }

# output "storageTableEndpoint" {
#   value = azurerm_storage_account.storage[*].primary_table_endpoint
# }

# output "storageFileEndpoint" {
#   value = azurerm_storage_account.storage[*].primary_file_endpoint
# }



# locals {
#   containerName = lower("Container01")
# }

# resource "azurerm_storage_container" "container" {
#   count                = local.storageCount
#   name                 = local.containerName
#   storage_account_name = azurerm_storage_account.storage[count.index].name
# }
