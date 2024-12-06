terraform {
  required_version = "~> 1.10.0"

  cloud {
    hostname     = "app.terraform.io"
    organization = "mattiasholm"

    workspaces {
      name = "azure"
      # project = "azure" # Evalute, same functionality as Pulumi project/stacks???
      # name = "dev" # VS automatically configured when pointing to project???
      # https://developer.hashicorp.com/terraform/language/terraform#terraform-cloud
      # https://developer.hashicorp.com/terraform/cli/cloud/settings
    }
  }

  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3.0.0"
    }

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.6.0"
    }
  }
}

provider "azuread" {
  tenant_id = var.tenant_id
}

provider "azurerm" {
  subscription_id = var.subscription_id

  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}
