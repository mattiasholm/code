terraform {
  # required_version = "~> 0.15.0"
  # required_version = "~> 1.0.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.62.0"
    }
  }

  backend "remote" {
    organization = "mattiasholm"

    workspaces {
      name = "code"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id = "9b184a26-7fff-49ed-9230-d11d484ad51b"
}
