variables {
  tags = {
    Application = "App"
    Company     = "Com"
  }
  appi_type = "web"
  pip_labels = [
    "label"
  ]
  st_count            = 1
  vnet_address_prefix = "10.0.0.0/8"
  vnet_subnet_size    = 24
  vnet_subnet_count   = 1
}

run "validate_naming" {
  command = plan

  assert {
    condition     = azurerm_resource_group.rg.name == "rg-com-app-01"
    error_message = "Resource group name did not match expected"
  }

  assert {
    condition     = azurerm_application_insights.appi[0].name == "appi-com-app-01"
    error_message = "Application Insights name did not match expected"
  }

  assert {
    condition     = azurerm_key_vault.kv.name == "kv-com-app-01"
    error_message = "Key Vault name did not match expected"
  }

  assert {
    condition     = azurerm_public_ip.pip["label"].name == "pip-com-app-01"
    error_message = "Public IP name did not match expected"
  }

  assert {
    condition     = azurerm_storage_account.st[0].name == "stcomapp01"
    error_message = "Storage account name did not match expected"
  }

  assert {
    condition     = azurerm_virtual_network.vnet.name == "vnet-com-app-01"
    error_message = "Virtual network name did not match expected"
  }

  assert {
    condition     = tolist(azurerm_virtual_network.vnet.subnet)[0].name == "snet-01"
    error_message = "Subnet name did not match expected"
  }
}

run "validate_subnetting" {
  command = plan

  assert {
    condition     = tolist(azurerm_virtual_network.vnet.subnet)[0].address_prefixes[0] == "10.0.0.0/24"
    error_message = "Subnet address prefix did not match expected"
  }
}
