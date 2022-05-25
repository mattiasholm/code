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
