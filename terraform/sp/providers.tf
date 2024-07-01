terraform {
  required_version = "~> 1.9.0"

  cloud {
    hostname     = "app.terraform.io"
    organization = "mattiasholm"

    workspaces {
      name = "sp"
    }
  }

  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.53.0"
    }

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.110.0"
    }

    time = {
      source  = "hashicorp/time"
      version = "~> 0.11.0"
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
