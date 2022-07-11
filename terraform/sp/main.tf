provider "azuread" {
  tenant_id = var.tenantId
}

provider "azurerm" {
  subscription_id = var.subscriptionId
  features {}
}

data "azuread_client_config" "current" {}

data "azurerm_subscription" "current" {}

resource "azuread_application" "app" {
  display_name = var.name
  owners = [
    data.azuread_client_config.current.object_id
  ]
  required_resource_access {
    resource_app_id = var.api
    resource_access {
      id   = var.permission
      type = "Role"
    }
  }
  web {
    implicit_grant {
      id_token_issuance_enabled = true
    }
  }
}

resource "azuread_service_principal" "sp" {
  application_id = azuread_application.app.application_id
}

resource "azurerm_role_assignment" "role" {
  principal_id         = azuread_service_principal.sp.object_id
  role_definition_name = var.role
  scope                = data.azurerm_subscription.current.id
}

resource "time_rotating" "rotation" {
  rotation_days = floor(var.days * 0.90)
}

resource "azuread_application_password" "secret" {
  display_name          = var.secret
  application_object_id = azuread_application.app.object_id
  end_date_relative     = "${var.days * 24}h"
  rotate_when_changed = {
    rotation = time_rotating.rotation.id
  }
}

resource "azuread_application_federated_identity_credential" "oidc" {
  for_each              = toset(var.subjects)
  display_name          = replace(replace(each.key, "/^.*:/", ""), "refs/heads/", "")
  application_object_id = azuread_application.app.object_id
  audiences             = var.audiences
  issuer                = var.issuer
  subject               = each.key
}

resource "null_resource" "null" {
  provisioner "local-exec" {
    command = "az ad app permission admin-consent --id ${azuread_application.app.application_id}"
  }
}
