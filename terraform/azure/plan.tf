locals {
  reserved = var.planKind == "linux" ? true : false
}

resource "azurerm_app_service_plan" "plan" {
  name                = "plan-${var.prefix}-001"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  tags                = var.tags
  kind                = var.planKind
  reserved            = local.reserved
  sku {
    tier     = var.planTier
    size     = var.planSize
    capacity = var.planCapacity
  }
}