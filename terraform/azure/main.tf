terraform {
  required_version = "~> 0.15.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.58.0"
    }
  }
}

provider "azurerm" {
  features {}
}










# Remote state - Storage Account, hantera utanför Terraform, t.ex. Azure CLI!



# https://learn.hashicorp.com/tutorials/terraform/github-actions



# var VS locals! Inte tänkt på att man såklart kan använda flera .tfvars-filer istället - måste väl vara tydligare?! Fast å andra sidan vill jag väl precis som i ARM bara bryta ut saker saker som skiljer mellan Test/Prod??
# global.tfvars (auto???) + prod.tfvars (manuell) / test.tfvars (manuell)



# locals {
#   prefixStripped = lower(replace(var.prefix, "-",""))
# }