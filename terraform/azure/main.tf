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

  dynamic "access_policy" {
    for_each = local.access_policies

    content {
      tenant_id          = data.azurerm_subscription.sub.tenant_id
      object_id          = access_policy.key
      secret_permissions = access_policy.value
    }
  }
}

resource "azurerm_key_vault_secret" "secret" {
  count        = var.appi_type != "" ? 1 : 0
  name         = "APPLICATIONINSIGHTS-CONNECTION-STRING"
  tags         = var.tags
  value        = azurerm_application_insights.appi[0].connection_string
  key_vault_id = azurerm_key_vault.kv.id
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
  tags                  = var.tags
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
  https_traffic_only_enabled      = var.st_https_only
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
      name = "snet-${format("%02d", subnet.value + 1)}"
      address_prefixes = [
        cidrsubnet(var.vnet_address_prefix, var.vnet_subnet_size - local.vnet_size, subnet.value)
      ]
    }
  }
}
