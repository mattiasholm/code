output "kv_url" {
  value = azurerm_key_vault.kv.vault_uri
}

output "pdnsz_url" {
  value = { for key, value in azurerm_private_dns_cname_record.cname : key => value.fqdn }
}

output "pip_url" {
  value = { for key, value in azurerm_public_ip.pip : key => "https://${value.fqdn}/" }
}

output "st_url" {
  value = [for st in azurerm_storage_account.st : {
    blob  = st.primary_blob_endpoint
    dfs   = st.primary_dfs_endpoint
    file  = st.primary_file_endpoint
    queue = st.primary_queue_endpoint
    table = st.primary_table_endpoint
    web   = st.primary_web_endpoint
  }]
}
