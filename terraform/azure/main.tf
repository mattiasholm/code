locals {
  prefix          = lower("${var.tags.Company}-${var.tags.Application}")
  prefix_stripped = replace(local.prefix, "-", "")
  vnet_size       = split("/", var.vnet_address_prefix)[1]
}

data "azurerm_subscription" "sub" {}

data "azuread_user" "user" {
  user_principal_name = var.kv_user_name
}

data "azuread_service_principal" "sp" {
  display_name = var.kv_sp_name
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-${local.prefix}-01"
  location = var.location
  tags     = var.tags
}

resource "azurerm_application_insights" "appi" {
  count               = var.appi_type != "" ? 1 : 0
  name                = "appi-${local.prefix}-01"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  tags                = var.tags
  application_type    = var.appi_type
}

resource "azurerm_key_vault" "kv" {
  name                = "kv-${local.prefix}-01"
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
  count        = var.appi_type != "" ? 1 : 0
  name         = "APPLICATIONINSIGHTS-CONNECTION-STRING"
  tags         = var.tags
  value        = azurerm_application_insights.appi[0].connection_string
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
  name                  = azurerm_virtual_network.vnet.name
  private_dns_zone_name = azurerm_private_dns_zone.pdnsz.name
  resource_group_name   = azurerm_resource_group.rg.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
  registration_enabled  = var.pdnsz_registration
}

resource "azurerm_private_dns_cname_record" "cname" {
  for_each            = var.pip_labels
  name                = each.value
  zone_name           = azurerm_private_dns_zone.pdnsz.name
  resource_group_name = azurerm_resource_group.rg.name
  ttl                 = var.pdnsz_ttl
  record              = azurerm_public_ip.pip[each.value].fqdn
}

resource "azurerm_public_ip" "pip" {
  for_each            = var.pip_labels
  name                = "pip-${local.prefix}-${format("%02d", index(tolist(var.pip_labels), each.value) + 1)}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  tags                = var.tags
  sku                 = var.pip_sku
  allocation_method   = var.pip_allocation
  domain_name_label   = "${each.value}-${local.prefix}"
}

resource "azurerm_storage_account" "st" {
  count                           = var.st_count
  name                            = "st${local.prefix_stripped}${format("%02d", count.index + 1)}"
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
  name                 = "container-01"
  storage_account_name = azurerm_storage_account.st[count.index].name
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${local.prefix}-01"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  tags                = var.tags
  address_space = [
    var.vnet_address_prefix
  ]

  dynamic "subnet" {
    for_each = range(var.vnet_subnet_count)

    content {
      name           = "snet-${format("%02d", subnet.value + 1)}"
      address_prefix = cidrsubnet(var.vnet_address_prefix, var.vnet_subnet_size - local.vnet_size, subnet.value)
    }
  }
}
