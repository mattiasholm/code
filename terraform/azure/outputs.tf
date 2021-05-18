output "appUrl" {
  value = azurerm_app_service.app[*].default_site_hostname
}