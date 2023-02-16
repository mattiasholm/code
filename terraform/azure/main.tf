provider "azuread" {
  tenant_id = var.tenant_id
}

provider "azurerm" {
  subscription_id = var.subscription_id

  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

locals {
  prefix          = lower("${var.tags.Company}-${var.tags.Application}")
  prefix_stripped = replace(local.prefix, "-", "")
}

data "azurerm_subscription" "sub" {}

data "azuread_user" "user" {
  user_principal_name = var.kv_user_name
}

data "azuread_service_principal" "sp" {
  display_name = var.kv_sp_name
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-${local.prefix}-001"
  location = var.location
  tags     = var.tags
}

resource "azurerm_application_insights" "appi" {
  name                = "appi-${local.prefix}-001"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  tags                = var.tags
  application_type    = var.appi_type
}

resource "azurerm_key_vault" "kv" {
  name                = "kv-${local.prefix}-001"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  tags                = var.tags
  tenant_id           = data.azurerm_subscription.sub.tenant_id
  sku_name            = var.kv_sku
}

resource "azurerm_key_vault_access_policy" "policy_user" {
  key_vault_id            = azurerm_key_vault.kv.id
  tenant_id               = data.azurerm_subscription.sub.tenant_id
  object_id               = data.azuread_user.user.object_id
  key_permissions         = var.kv_user_key_permissions
  secret_permissions      = var.kv_user_secret_permissions
  certificate_permissions = var.kv_user_certificate_permissions
}

resource "azurerm_key_vault_access_policy" "policy_sp" {
  key_vault_id       = azurerm_key_vault.kv.id
  tenant_id          = data.azurerm_subscription.sub.tenant_id
  object_id          = data.azuread_service_principal.sp.object_id
  secret_permissions = var.kv_sp_secret_permissions
}

resource "azurerm_key_vault_secret" "secret" {
  name         = "APPLICATIONINSIGHTS-CONNECTION-STRING"
  tags         = var.tags
  value        = azurerm_application_insights.appi.connection_string
  key_vault_id = azurerm_key_vault.kv.id
  depends_on = [
    azurerm_key_vault_access_policy.policy_user,
    azurerm_key_vault_access_policy.policy_sp
  ]
}

resource "azurerm_private_dns_zone" "pdnsz" {
  name                = var.pdnsz_name
  resource_group_name = azurerm_resource_group.rg.name
  tags                = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "link" {
  count                 = var.vnet_address_prefix != null ? 1 : 0
  name                  = azurerm_virtual_network.vnet[0].name
  private_dns_zone_name = azurerm_private_dns_zone.pdnsz.name
  resource_group_name   = azurerm_resource_group.rg.name
  virtual_network_id    = azurerm_virtual_network.vnet[0].id
  registration_enabled  = var.pdnsz_registration
}

resource "azurerm_private_dns_cname_record" "cname" {
  for_each            = var.pip_labels
  name                = each.value
  zone_name           = azurerm_private_dns_zone.pdnsz.name
  resource_group_name = azurerm_resource_group.rg.name
  ttl                 = var.pdnsz_ttl
  record              = azurerm_public_ip.pip[each.key].fqdn
}

resource "azurerm_public_ip" "pip" {
  for_each            = var.pip_labels
  name                = "pip-${local.prefix}-${each.key}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  tags                = var.tags
  sku                 = var.pip_sku
  allocation_method   = var.pip_allocation
  domain_name_label   = "${each.value}-${local.prefix}"
}

resource "azurerm_storage_account" "st" {
  count                           = var.st_count
  name                            = "st${local.prefix_stripped}${format("%03d", count.index + 1)}"
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = var.location
  tags                            = var.tags
  account_kind                    = var.st_kind
  account_tier                    = var.st_sku
  account_replication_type        = var.st_replication
  allow_nested_items_to_be_public = var.st_public_access
  enable_https_traffic_only       = var.st_https_only
  min_tls_version                 = var.st_tls_version
}

resource "azurerm_storage_container" "container" {
  count                = var.st_count
  name                 = "container${local.prefix_stripped}001"
  storage_account_name = azurerm_storage_account.st[count.index].name
}

resource "azurerm_virtual_network" "vnet" {
  count               = var.vnet_address_prefix != null ? 1 : 0
  name                = "vnet-${local.prefix}-001"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  tags                = var.tags
  address_space = [
    var.vnet_address_prefix
  ]

  subnet {
    name           = "snet-${local.prefix}-001"
    address_prefix = var.vnet_address_prefix
  }
}
