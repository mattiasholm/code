output "appUrl" {
  value = [for app in azurerm_app_service.app : app.default_site_hostname]
}

output "kvUrl" {
  value = azurerm_key_vault.kv.vault_uri
}

output "stBlobUrl" {
  value = azurerm_storage_account.st[*].primary_blob_endpoint
}
output "stFileUrl" {
  value = azurerm_storage_account.st[*].primary_file_endpoint
}
output "stTableUrl" {
  value = azurerm_storage_account.st[*].primary_table_endpoint
}
output "stQueueUrl" {
  value = azurerm_storage_account.st[*].primary_queue_endpoint
}
