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
  for_each            = toset(var.appDockerImageTags) # ??? Bättre att deklararea variabeln som set() från början för att slippa toset() ???
  # for_each            = { for i, appDockerImageTag in var.appDockerImageTags : appDockerImageTag => i } # Bättre att använda liknande for_each som i själva appen? Behöver ju dock inte index här, så känns onödigt komplex!
  key_vault_id = azurerm_key_vault.kv.id
  # tenant_id          = data.azurerm_client_config.current.tenant_id # OBS: Går att hämta ut tenantId specifikt för managedIdentity även i ARM/Bicep! (app.identity.tenantId). Nackdel är dock att jag redan sätter tenantId dynamiskt med subscription().tenantId, vilket ändå behövs på toppnivå för KV...
  tenant_id          = azurerm_app_service.app[each.key].identity.0.tenant_id
  object_id          = azurerm_app_service.app[each.key].identity.0.principal_id
  secret_permissions = var.kvPermissionsSecrets
}