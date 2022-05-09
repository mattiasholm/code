data "azuread_client_config" "current" {}

data "azurerm_subscription" "current" {}

resource "azuread_application" "app" {
  display_name = "sp-holm-002"
  owners = [
    data.azuread_client_config.current.object_id
  ]
  required_resource_access {
    resource_app_id = "00000003-0000-0000-c000-000000000000"
    resource_access {
      id   = "df021288-bdef-4463-88db-98f22de89214"
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
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Contributor"
  principal_id         = azuread_service_principal.sp.object_id

  provisioner "local-exec" {
    command = "az account list --all"
  }
}

resource "time_rotating" "rotation" {
  rotation_hours = 8760 * 0.90
}

resource "azuread_application_password" "secret" {
  application_object_id = azuread_application.app.object_id
  display_name          = "github"
  end_date_relative     = "8760h"
  rotate_when_changed = {
    rotation = time_rotating.rotation.id
  }

}

resource "azuread_application_federated_identity_credential" "main" {
  application_object_id = azuread_application.app.object_id
  display_name          = "main"
  audiences = [
    "api://AzureADTokenExchange"
  ]
  issuer  = "https://token.actions.githubusercontent.com"
  subject = "repo:mattiasholm/code:ref:refs/heads/main"
}

resource "azuread_application_federated_identity_credential" "dev" {
  application_object_id = azuread_application.app.object_id
  display_name          = "dev"
  audiences = [
    "api://AzureADTokenExchange"
  ]
  issuer  = "https://token.actions.githubusercontent.com"
  subject = "repo:mattiasholm/code:environment:dev"
}

resource "azuread_application_federated_identity_credential" "pull_request" {
  application_object_id = azuread_application.app.object_id
  display_name          = "pull_request"
  audiences = [
    "api://AzureADTokenExchange"
  ]
  issuer  = "https://token.actions.githubusercontent.com"
  subject = "repo:mattiasholm/code:pull_request"
}

resource "null_resource" "null" {
  provisioner "local-exec" {
    command = "az ad app permission admin-consent --id ${azuread_application.app.application_id}"
  }
}
