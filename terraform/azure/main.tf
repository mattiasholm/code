data "azurerm_subscription" "sub" {}

data "azuread_user" "user" {
  user_principal_name = var.user_name
}

data "azuread_service_principal" "sp" {
  display_name = var.sp_name
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-${local.prefix}-01"
  location = var.location
  tags     = var.tags
}

resource "azurerm_log_analytics_workspace" "log" {
  count               = var.log_retention != null ? 1 : 0
  name                = "log-${local.prefix}-01"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  tags                = var.tags
  retention_in_days   = var.log_retention
}

resource "azurerm_key_vault" "kv" {
  name                      = "kv-${local.prefix}-01"
  resource_group_name       = azurerm_resource_group.rg.name
  location                  = var.location
  tags                      = var.tags
  tenant_id                 = data.azurerm_subscription.sub.tenant_id
  sku_name                  = "standard"
  enable_rbac_authorization = true
}

resource "azurerm_key_vault_secret" "secret" {
  depends_on = [
    azurerm_role_assignment.rbac
  ]
  count        = var.log_retention != null ? 1 : 0
  name         = "log-workspace-id"
  tags         = var.tags
  value        = azurerm_log_analytics_workspace.log[0].workspace_id
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
}

resource "azurerm_private_dns_cname_record" "cname" {
  for_each            = var.pip_labels
  name                = each.value
  zone_name           = azurerm_private_dns_zone.pdnsz.name
  resource_group_name = azurerm_resource_group.rg.name
  ttl                 = 3600
  record              = azurerm_public_ip.pip[each.value].fqdn
}

resource "azurerm_public_ip" "pip" {
  for_each            = var.pip_labels
  name                = "pip-${local.prefix}-${format("%02d", index(tolist(var.pip_labels), each.value) + 1)}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  tags                = var.tags
  sku                 = "Standard"
  allocation_method   = "Static"
  domain_name_label   = "pip-${local.prefix}-${format("%02d", index(tolist(var.pip_labels), each.value) + 1)}"
}

resource "azurerm_storage_account" "st" {
  count                    = var.st_count
  name                     = "st${local.prefix_stripped}${format("%02d", count.index + 1)}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = var.location
  tags                     = var.tags
  account_tier             = var.st_sku
  account_replication_type = var.st_replication
}

resource "azurerm_storage_container" "container" {
  count              = var.st_count
  name               = "data"
  storage_account_id = azurerm_storage_account.st[count.index].id
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${local.prefix}-01"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  tags                = var.tags
  address_space = [
    var.vnet_cidr
  ]

  dynamic "subnet" {
    for_each = range(var.snet_count)

    content {
      name = "snet-${local.prefix}-${format("%02d", subnet.value + 1)}"
      address_prefixes = [
        cidrsubnet(var.vnet_cidr, var.snet_size - local.vnet_size, subnet.value)
      ]
    }
  }
}

resource "azurerm_role_assignment" "rbac" {
  for_each             = local.roles
  principal_id         = each.value.principal
  role_definition_name = each.value.role
  scope                = azurerm_resource_group.rg.id
}
