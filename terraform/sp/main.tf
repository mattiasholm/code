data "azuread_client_config" "user" {}

data "azurerm_subscription" "sub" {}

resource "azuread_application" "app" {
  display_name = var.name
  owners = [
    data.azuread_client_config.user.object_id
  ]

  required_resource_access {
    resource_app_id = var.api

    dynamic "resource_access" {
      for_each = var.permissions

      content {
        id   = resource_access.key
        type = resource_access.value
      }
    }
  }
}

resource "azuread_service_principal" "sp" {
  application_id = azuread_application.app.application_id
  owners = [
    data.azuread_client_config.user.object_id
  ]
}

resource "azurerm_role_assignment" "role" {
  principal_id         = azuread_service_principal.sp.object_id
  role_definition_name = var.role_name
  scope                = data.azurerm_subscription.sub.id
}

resource "time_rotating" "rotation" {
  rotation_days = var.secret_expiration
}

resource "azuread_application_password" "secret" {
  display_name          = var.secret_name
  application_object_id = azuread_application.app.object_id
  end_date_relative     = "${var.secret_expiration * 24}h"
  rotate_when_changed = {
    rotation = time_rotating.rotation.id
  }
}

resource "azuread_application_federated_identity_credential" "credential" {
  for_each              = var.subjects
  display_name          = each.key
  application_object_id = azuread_application.app.object_id
  audiences             = var.audiences
  issuer                = var.issuer
  subject               = each.value
}

resource "null_resource" "command" {
  for_each = var.permissions
  provisioner "local-exec" {
    command = <<-EOT
      resourceId=$(az ad sp show --id ${var.api} --query id --output tsv)

      method='POST'
      uri="https://graph.microsoft.com/v1.0/servicePrincipals/${azuread_service_principal.sp.object_id}/appRoleAssignments"
      body="{\"principalId\":\"${azuread_service_principal.sp.object_id}\",\"resourceId\":\"$resourceId\",\"appRoleId\":\"${each.key}\"}"

      az rest --method $method --uri $uri --body $body
    EOT
  }
}
