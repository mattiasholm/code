terraform {
  required_version = "~> 1.14.0"

  cloud {
    hostname     = "app.terraform.io"
    organization = "mattiasholm"

    workspaces {
      name = "azure"
    }
  }

  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3.8.0"
    }

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.69.0"
    }
  }
}

provider "azuread" {
  tenant_id = var.tenant_id
}

provider "azurerm" {
  subscription_id = var.subscription_id

  features {}
}
