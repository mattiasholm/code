terraform {
  required_version = "~> 1.2.0"

  backend "remote" {
    organization = "mattiasholm"

    workspaces {
      name = "sp"
    }
  }

  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.20.0"
    }

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.2.0"
    }
  }
}

provider "azuread" {
  tenant_id = "9e042b3b-36c4-4b99-8236-728c73166cd9"
}

provider "azurerm" {
  subscription_id = "9b184a26-7fff-49ed-9230-d11d484ad51b"
  features {}
}
