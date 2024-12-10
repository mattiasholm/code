output "kv_url" {
  value = azurerm_key_vault.kv.vault_uri
}

output "cname_url" {
  value = { for key, value in azurerm_private_dns_cname_record.cname : key => "https://${replace(value.fqdn, "/\\.$/", "")}/" }
}

output "st_url" {
  value = { for st in azurerm_storage_account.st : st.name => {
    blob  = st.primary_blob_endpoint
    dfs   = st.primary_dfs_endpoint
    file  = st.primary_file_endpoint
    queue = st.primary_queue_endpoint
    table = st.primary_table_endpoint
    web   = st.primary_web_endpoint
  } }
}

output "subnets" {
  value = { for snet in azurerm_virtual_network.vnet.subnet : snet.name => snet.address_prefixes[0] }
}
