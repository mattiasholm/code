variables {
  tags = {
    Application = "App"
    Company     = "Com"
  }
  log_retention = 30
  pip_labels = [
    "label"
  ]
  st_count   = 1
  vnet_cidr  = "10.0.0.0/8"
  snet_size  = 24
  snet_count = 1
}

run "validate_naming" {
  command = plan

  assert {
    condition     = azurerm_resource_group.rg.name == "rg-com-app-01"
    error_message = "Resource group name did not match expected"
  }

  assert {
    condition     = azurerm_log_analytics_workspace.log[0].name == "log-com-app-01"
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
    condition     = tolist(azurerm_virtual_network.vnet.subnet)[0].name == "snet-com-app-01"
    error_message = "Subnet name did not match expected"
  }
}

run "validate_subnet" {
  command = plan

  assert {
    condition     = tolist(azurerm_virtual_network.vnet.subnet)[0].address_prefixes[0] == "10.0.0.0/24"
    error_message = "Subnet address prefix did not match expected"
  }
}

run "validate_conditionals" {
  command = plan

  variables {
    log_retention = null
    pip_labels    = []
    st_count      = 0
  }

  assert {
    condition     = length(azurerm_log_analytics_workspace.log) == 0
    error_message = "Log Analytics count did not match expected"
  }

  assert {
    condition     = length(azurerm_public_ip.pip) == 0
    error_message = "Public IP count did not match expected"
  }

  assert {
    condition     = length(azurerm_storage_account.st) == 0
    error_message = "Storage account count did not match expected"
  }
}
