# locals {
#   vnetName   = "${local.prefix}-VNet01"
#   subnetName = "Subnet01"
# }

# resource "azurerm_virtual_network" "vnet" {
#   name                = local.vnetName
#   resource_group_name = var.rgName
#   location            = var.location
#   tags                = var.tags
#   address_space       = var.vnetAddressPrefix
#   subnet {
#     name           = local.subnetName
#     address_prefix = var.vnetAddressPrefix[0]
#   }
# }

# output "vnetId" {
#   value = azurerm_virtual_network.vnet.id
# }