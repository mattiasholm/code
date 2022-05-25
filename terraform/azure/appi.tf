resource "azurerm_application_insights" "appi" {
  name                = "appi-${local.prefix}-001"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  tags                = var.tags
  application_type    = var.appiType
}
