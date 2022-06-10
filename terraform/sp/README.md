## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.1.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | ~> 2.20.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | 2.20.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.2.0 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.1.1 |
| <a name="provider_time"></a> [time](#provider\_time) | 0.7.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azuread_application.app](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application) | resource |
| [azuread_application_federated_identity_credential.oidc](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application_federated_identity_credential) | resource |
| [azuread_application_password.secret](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application_password) | resource |
| [azuread_service_principal.sp](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal) | resource |
| [azurerm_role_assignment.role](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [null_resource.null](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [time_rotating.rotation](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/rotating) | resource |
| [azuread_client_config.current](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/client_config) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api"></a> [api](#input\_api) | n/a | `string` | n/a | yes |
| <a name="input_audiences"></a> [audiences](#input\_audiences) | n/a | `list(string)` | n/a | yes |
| <a name="input_days"></a> [days](#input\_days) | n/a | `number` | `365` | no |
| <a name="input_issuer"></a> [issuer](#input\_issuer) | n/a | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | n/a | yes |
| <a name="input_permission"></a> [permission](#input\_permission) | n/a | `string` | n/a | yes |
| <a name="input_role"></a> [role](#input\_role) | n/a | `string` | n/a | yes |
| <a name="input_secret"></a> [secret](#input\_secret) | n/a | `string` | n/a | yes |
| <a name="input_subjects"></a> [subjects](#input\_subjects) | n/a | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_clientId"></a> [clientId](#output\_clientId) | n/a |
| <a name="output_clientSecret"></a> [clientSecret](#output\_clientSecret) | n/a |
| <a name="output_tenantId"></a> [tenantId](#output\_tenantId) | n/a |