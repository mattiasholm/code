resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.prefix}-001"
  location = var.location
  tags     = var.tags
}
