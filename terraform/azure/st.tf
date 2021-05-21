# If your instances are almost identical, count is appropriate. If some of their arguments need distinct values that can't be directly derived from an integer, it's safer to use for_each.

# Before for_each was available, it was common to derive count from the length of a list and use count.index to look up the original list value:

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






# resource "azurerm_app_service" "app" {
#   count               = length(var.appDockerImageTags)
#   name                = "app-${var.prefix}-00${count.index + 1}"
#   resource_group_name = azurerm_resource_group.rg.name
#   location            = var.location
#   tags                = var.tags
#   identity {
#     type = var.appIdentity
#   }
#   app_service_plan_id = azurerm_app_service_plan.plan.id
#   site_config {
#     linux_fx_version = "DOCKER|nginxdemos/hello:${var.appDockerImageTags[count.index]}"
#     always_on        = var.appAlwaysOn
#     http2_enabled    = var.appHttp20Enabled
#     min_tls_version  = var.appMinTlsVersion
#     ftps_state       = var.appFtpsState
#   }
#   client_affinity_enabled = var.appClientAffinityEnabled
#   https_only              = var.appHttpsOnly
# }