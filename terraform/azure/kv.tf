locals {
  tenantId = data.azurerm_client_config.current.tenant_id
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv" {
  name                = "kv-${var.prefix}-001"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  tags                = var.tags
  tenant_id           = local.tenantId
  sku_name            = var.kvSku
}

resource "azurerm_key_vault_access_policy" "accesspolicy_app" {
  for_each           = azurerm_app_service.app
  key_vault_id       = azurerm_key_vault.kv.id
  tenant_id          = local.tenantId
  object_id          = azurerm_app_service.app[each.key].identity.0.principal_id
  secret_permissions = var.kvAppSecretPermissions
}

resource "azurerm_key_vault_access_policy" "accesspolicy_group" {
  key_vault_id            = azurerm_key_vault.kv.id
  tenant_id               = local.tenantId
  object_id               = azuread_group.group.id
  key_permissions         = var.kvGroupKeyPermissions
  secret_permissions      = var.kvGroupSecretPermissions
  certificate_permissions = var.kvGroupCertificatePermissions
}

resource "azurerm_key_vault_secret" "secret" {
  name         = var.kvSecretName
  tags         = var.tags
  value        = azurerm_application_insights.appi.connection_string
  key_vault_id = azurerm_key_vault.kv.id
}



# 

# data "azuread_service_principal" "sp" {
#   # application_id = "${var.sp_id}"
# }

resource "azurerm_key_vault_access_policy" "accesspolicy_sp" {
  key_vault_id = azurerm_key_vault.kv.id
  tenant_id    = local.tenantId
  object_id    = "43cac245-ccb6-43bf-be52-5e6ba58267d8"
  # object_id = data.azuread_service_principal.sp.id
  secret_permissions = [
    "Get",
    "List",
    "Set",
    "Delete",
    "Recover",
    "Backup",
    "Restore"
  ]
}

resource "azurerm_key_vault_access_policy" "accesspolicy_sp2" {
  key_vault_id = azurerm_key_vault.kv.id
  tenant_id    = local.tenantId
  object_id    = "aa855aa1-3243-4b29-b64e-ae6da5459b5f"
  secret_permissions = [
    "Get",
    "List",
    "Set",
    "Delete",
    "Recover",
    "Backup",
    "Restore"
  ]
}

# 
