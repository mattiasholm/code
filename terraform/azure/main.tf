terraform {
  required_version = "~> 0.13.5"

  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~> 2.35.0"
    }
  }
}

provider "azurerm" {
  features {}
}



locals {
  prefix = azurerm_resource_group.rg.name
}

resource "azurerm_resource_group" "rg" {
  name = var.rgName
  location = var.rgLocation
  tags = var.tags
}



locals {
  storageCount = 3
  storageName = lower(replace("${local.prefix}-Storage0","-",""))
  storageTier = "Standard"
  storageReplication = "GRS"
  storageKind = "StorageV2"
  storagePublicAccess = false
  storageHttpsOnly = true
  storageTls = "TLS1_2"
}

resource "azurerm_storage_account" "storage" {
  count = local.storageCount
  name = "${local.storageName}${count.index + 1}"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  tags = azurerm_resource_group.rg.tags
  account_tier = local.storageTier
  account_replication_type = local.storageReplication
  account_kind = local.storageKind
  allow_blob_public_access = local.storagePublicAccess
  enable_https_traffic_only = local.storageHttpsOnly
  min_tls_version = local.storageTls
}

output "storageId" {
  value = azurerm_storage_account.storage[*].id
}

output "storageBlobEndpoint" {
  value = azurerm_storage_account.storage[*].primary_blob_endpoint
}

output "storageQueueEndpoint" {
  value = azurerm_storage_account.storage[*].primary_queue_endpoint
}

output "storageTableEndpoint" {
  value = azurerm_storage_account.storage[*].primary_table_endpoint
}

output "storageFileEndpoint" {
  value = azurerm_storage_account.storage[*].primary_file_endpoint
}



locals {
  containerName = lower("Container01")
}

resource "azurerm_storage_container" "container" {
  count = local.storageCount
  name = local.containerName
  storage_account_name  = azurerm_storage_account.storage[count.index].name
}

output "containerId" {
  value = azurerm_storage_container.container[*].id
}



locals {
  vnetName = "${local.prefix}-VNet01"
  subnetName = "Subnet01"
}

resource "azurerm_virtual_network" "vnet" {
    name = local.vnetName
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    tags = azurerm_resource_group.rg.tags
    address_space = var.vnetAddressPrefix
    subnet {
      name = local.subnetName
      address_prefix = var.vnetAddressPrefix[0]
      }
}

output "vnetId" {
  value = azurerm_virtual_network.vnet.id
}



locals {
  keyvaultName = "${local.prefix}-KeyVault01"
  keyvaultSku = "standard"
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "keyvault" {
  name = local.keyvaultName
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  tags = azurerm_resource_group.rg.tags
  tenant_id = data.azurerm_client_config.current.tenant_id
  sku_name = local.keyvaultSku

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id
    key_permissions = [
      "get",
    ]
    secret_permissions = [
      "get",
    ]
    certificate_permissions = [
      "get",
    ]
  }
}

output "keyvautId" {
  value = azurerm_key_vault.keyvault.id
}

output "keyvautUrl" {
  value = azurerm_key_vault.keyvault.vault_uri 
}



# GÖR KLART APP, därefter fortsätt med modules!