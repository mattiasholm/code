resource "azurerm_resource_group" "rg" {
  name     = "rg-${local.prefix}-001"
  location = var.location
  tags     = var.tags
}
