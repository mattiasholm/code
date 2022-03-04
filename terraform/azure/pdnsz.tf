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
