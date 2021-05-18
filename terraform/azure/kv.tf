# data "azurerm_client_config" "current" {}

# resource "azurerm_key_vault" "kv" {
#   name                = "kv-${var.prefix}-001"
#   resource_group_name = azurerm_resource_group.rg.name
#   location            = var.location
#   tags                = var.tags
#   tenant_id           = data.azurerm_client_config.current.tenant_id
#   sku_name            = "standard"

#   access_policy {
#     tenant_id = data.azurerm_client_config.current.tenant_id
#     object_id = data.azurerm_client_config.current.object_id
#     secret_permissions = [
#       "Get",
#       "List",
#     ]
#   }
# }







# output "kvUrl" {
#   value = azurerm_key_vault.kv.vault_uri
# }