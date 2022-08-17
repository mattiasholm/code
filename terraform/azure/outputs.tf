output "kv_url" {
  value = azurerm_key_vault.kv.vault_uri
}

output "pdnsz_url" {
  value = [for cname in azurerm_private_dns_cname_record.cname : cname.fqdn]
}

output "pip_url" {
  value = [for pip in azurerm_public_ip.pip : "https://${pip.fqdn}/"]
}

output "st_url" {
  value = concat(azurerm_storage_account.st[*].primary_blob_endpoint, azurerm_storage_account.st[*].primary_file_endpoint, azurerm_storage_account.st[*].primary_queue_endpoint, azurerm_storage_account.st[*].primary_table_endpoint)
}
