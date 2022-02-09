resource "azurerm_public_ip" "pip" {
  for_each            = { for i, pipLabel in var.pipLabels : pipLabel => i }
  name                = "pip-${var.prefix}-${format("%03d", each.value + 1)}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  tags                = var.tags
  sku                 = var.pipSku
  allocation_method   = var.pipAllocation
  domain_name_label   = "${each.key}-${var.prefix}"
}
