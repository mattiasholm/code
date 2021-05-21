data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv" {
  name                = "kv-${var.prefix}-001"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  tags                = var.tags
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = var.kvSku
}

resource "azurerm_key_vault_access_policy" "accesspolicy" {
  for_each            = toset(var.appDockerImageTags)
  key_vault_id = azurerm_key_vault.kv.id
  # tenant_id          = data.azurerm_client_config.current.tenant_id # OBS: Går det hämta ut samma i ARM/Bicep??? Isåfall borde jag såklart ändra och göra på samma sätt där!
  tenant_id          = azurerm_app_service.app[each.key].identity.0.tenant_id
  object_id          = azurerm_app_service.app[each.key].identity.0.principal_id
  secret_permissions = var.kvPermissionsSecrets
}