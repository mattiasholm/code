# locals {
#   appName      = "${local.prefix}-App01"
#   appHttpsOnly = true
# }

# resource "azurerm_app_service" "app" {
#   name                = local.appName
#   resource_group_name = var.rgName
#   location            = var.location
#   tags                = var.tags
#   app_service_plan_id = azurerm_app_service_plan.plan.id
#   https_only          = local.appHttpsOnly
# }

# output "appUrl" {
#   value = azurerm_app_service.app.default_site_hostname
# }
