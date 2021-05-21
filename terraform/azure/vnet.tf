resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${var.prefix}-001"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  tags                = var.tags
  address_space       = [var.vnetAddressPrefix]
  subnet {
    name           = "snet-${var.prefix}-001"
    address_prefix = var.vnetAddressPrefix
  }
}