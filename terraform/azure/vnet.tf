locals {
  vnetName   = "${local.prefix}-VNet01"
  subnetName = "Subnet01"
}

resource "azurerm_virtual_network" "vnet" {
  name                = local.vnetName
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  tags                = azurerm_resource_group.rg.tags
  address_space       = var.vnetAddressPrefix
  subnet {
    name           = local.subnetName
    address_prefix = var.vnetAddressPrefix[0]
  }
}

output "vnetDNS" {
  value = azurerm_virtual_network.vnet.dns_servers
}
