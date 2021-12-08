resource "azurerm_virtual_network" "vnet" {
  count               = var.vnetToggle ? 1 : 0
  name                = "vnet-${var.prefix}-001"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  tags                = var.tags
  address_space = [
    var.vnetAddressPrefix
  ]
  subnet {
    name           = "snet-${var.prefix}-001"
    address_prefix = var.vnetAddressPrefix
  }
}
