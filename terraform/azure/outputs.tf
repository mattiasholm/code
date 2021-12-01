output "appUrl" {
  value = [for app in azurerm_app_service.app : "https://${app.default_site_hostname}/"]
}

output "kvUrl" {
  value = azurerm_key_vault.kv.vault_uri
}

output "stUrl" {
  value = concat(azurerm_storage_account.st[*].primary_blob_endpoint, azurerm_storage_account.st[*].primary_file_endpoint, azurerm_storage_account.st[*].primary_queue_endpoint, azurerm_storage_account.st[*].primary_table_endpoint)
}
