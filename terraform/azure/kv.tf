data "azurerm_client_config" "current" {}

data "azuread_user" "user" {
  user_principal_name = var.kvUsername
}

data "azuread_service_principal" "sp" {
  display_name = var.kvSpName
}

resource "azurerm_key_vault" "kv" {
  name                = "kv-${var.prefix}-001"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  tags                = var.tags
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = var.kvSku
}

resource "azurerm_key_vault_access_policy" "accesspolicy_user" {
  key_vault_id            = azurerm_key_vault.kv.id
  tenant_id               = data.azurerm_client_config.current.tenant_id
  object_id               = data.azuread_user.user.object_id
  key_permissions         = var.kvUserKeyPermissions
  secret_permissions      = var.kvUserSecretPermissions
  certificate_permissions = var.kvUserCertPermissions
}

resource "azurerm_key_vault_access_policy" "accesspolicy_sp" {
  key_vault_id       = azurerm_key_vault.kv.id
  tenant_id          = data.azurerm_client_config.current.tenant_id
  object_id          = data.azuread_service_principal.sp.object_id
  secret_permissions = var.kvSpSecretPermissions
}

resource "azurerm_key_vault_secret" "secret" {
  name         = "appi-connectionString"
  tags         = var.tags
  value        = azurerm_application_insights.appi.connection_string
  key_vault_id = azurerm_key_vault.kv.id
  depends_on = [
    azurerm_key_vault_access_policy.accesspolicy_user,
    azurerm_key_vault_access_policy.accesspolicy_sp
  ]
}
