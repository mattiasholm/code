terraform {
  required_version = "~> 1.1.0"

  backend "remote" {
    organization = "mattiasholm"

    workspaces {
      name = "code"
    }
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.91.0"
    }

    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.14.0"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id = "9b184a26-7fff-49ed-9230-d11d484ad51b"
}

provider "azuread" {
  tenant_id = "9e042b3b-36c4-4b99-8236-728c73166cd9"
}
