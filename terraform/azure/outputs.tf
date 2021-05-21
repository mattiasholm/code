output "appUrl" {
  value = [for app in azurerm_app_service.app : app.default_site_hostname]
}

output "kvUrl" {
  value = azurerm_key_vault.kv.vault_uri
}