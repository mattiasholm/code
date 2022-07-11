provider "azuread" {
  tenant_id = var.tenantId
}

provider "azurerm" {
  subscription_id = var.subscriptionId
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

locals {
  prefix         = lower("${var.tags["Company"]}-${var.tags["Application"]}")
  prefixStripped = replace(local.prefix, "-", "")
}

data "azurerm_client_config" "current" {}

data "azuread_user" "user" {
  user_principal_name = var.kvUsername
}

data "azuread_service_principal" "sp" {
  display_name = var.kvSpName
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
  application_type    = var.appiType
}

resource "azurerm_key_vault" "kv" {
  name                = "kv-${local.prefix}-001"
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

resource "azurerm_private_dns_zone" "pdnsz" {
  name                = var.pdnszName
  resource_group_name = azurerm_resource_group.rg.name
  tags                = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "link" {
  count                 = var.vnetAddressPrefix != "" ? 1 : 0
  name                  = azurerm_virtual_network.vnet[0].name
  private_dns_zone_name = azurerm_private_dns_zone.pdnsz.name
  resource_group_name   = azurerm_resource_group.rg.name
  virtual_network_id    = azurerm_virtual_network.vnet[0].id
  registration_enabled  = var.pdnszRegistration
}

resource "azurerm_private_dns_cname_record" "cname" {
  for_each            = toset(var.pipLabels)
  name                = each.key
  zone_name           = azurerm_private_dns_zone.pdnsz.name
  resource_group_name = azurerm_resource_group.rg.name
  ttl                 = var.pdnszTtl
  record              = azurerm_public_ip.pip[each.key].fqdn
}

resource "azurerm_public_ip" "pip" {
  for_each            = { for i, pipLabel in var.pipLabels : pipLabel => i }
  name                = "pip-${local.prefix}-${format("%03d", each.value + 1)}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  tags                = var.tags
  sku                 = var.pipSku
  allocation_method   = var.pipAllocation
  domain_name_label   = "${each.key}-${local.prefix}"
}

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

resource "azurerm_virtual_network" "vnet" {
  count               = var.vnetAddressPrefix != "" ? 1 : 0
  name                = "vnet-${local.prefix}-001"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  tags                = var.tags
  address_space = [
    var.vnetAddressPrefix
  ]
  subnet {
    name           = "snet-${local.prefix}-001"
    address_prefix = var.vnetAddressPrefix
  }
}
