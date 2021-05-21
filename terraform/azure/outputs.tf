output "appUrl" {
  value = [for app in azurerm_app_service.app : app.default_site_hostname]
}