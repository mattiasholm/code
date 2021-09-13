# data "azuread_client_config" "current" {}

resource "azuread_group" "group" {
  display_name = "AzureRBAC-KeyVault"
  # owners           = [data.azuread_client_config.current.object_id]
  security_enabled = true
}

# https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group