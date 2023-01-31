## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.3.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | ~> 2.32.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.39.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | ~> 3.2.0 |
| <a name="requirement_time"></a> [time](#requirement\_time) | ~> 0.9.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | 2.32.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.39.1 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.2.1 |
| <a name="provider_time"></a> [time](#provider\_time) | 0.9.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azuread_application.app](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application) | resource |
| [azuread_application_federated_identity_credential.credential](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application_federated_identity_credential) | resource |
| [azuread_application_password.secret](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application_password) | resource |
| [azuread_service_principal.sp](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal) | resource |
| [azurerm_role_assignment.role](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [null_resource.command](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [time_rotating.rotation](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/rotating) | resource |
| [azuread_client_config.user](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/client_config) | data source |
| [azurerm_subscription.sub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api"></a> [api](#input\_api) | n/a | `string` | n/a | yes |
| <a name="input_audiences"></a> [audiences](#input\_audiences) | n/a | `list(string)` | n/a | yes |
| <a name="input_issuer"></a> [issuer](#input\_issuer) | n/a | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | n/a | yes |
| <a name="input_permissions"></a> [permissions](#input\_permissions) | n/a | `map(string)` | n/a | yes |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | n/a | `string` | n/a | yes |
| <a name="input_secret_expiration"></a> [secret\_expiration](#input\_secret\_expiration) | n/a | `number` | `365` | no |
| <a name="input_secret_name"></a> [secret\_name](#input\_secret\_name) | n/a | `string` | n/a | yes |
| <a name="input_subjects"></a> [subjects](#input\_subjects) | n/a | `map(string)` | n/a | yes |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | n/a | `string` | n/a | yes |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_client_id"></a> [client\_id](#output\_client\_id) | n/a |
| <a name="output_client_secret"></a> [client\_secret](#output\_client\_secret) | n/a |
| <a name="output_tenant_id"></a> [tenant\_id](#output\_tenant\_id) | n/a |
