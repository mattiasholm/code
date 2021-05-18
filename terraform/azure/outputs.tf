output "appUrl" {
  value = azurerm_app_service.app[*].default_site_hostname
}

# output "kvUrl" {
#   value = azurerm_key_vault.kv.vault_uri
# }