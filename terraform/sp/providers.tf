terraform {
  required_version = "~> 1.5.0"

  cloud {
    organization = "mattiasholm"

    workspaces {
      name = "sp"
    }
  }

  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.40.0"
    }

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.66.0"
    }

    time = {
      source  = "hashicorp/time"
      version = "~> 0.9.0"
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
