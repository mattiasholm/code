## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.10.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | ~> 3.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.13.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | 3.0.2 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.13.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault.kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault) | resource |
| [azurerm_key_vault_secret.secret](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_log_analytics_workspace.log](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace) | resource |
| [azurerm_private_dns_cname_record.cname](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_cname_record) | resource |
| [azurerm_private_dns_zone.pdnsz](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.link](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_public_ip.pip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.rbac](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_storage_account.st](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_container.container](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [azuread_service_principal.sp](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/service_principal) | data source |
| [azuread_user.user](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/user) | data source |
| [azurerm_subscription.sub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | n/a | yes |
| <a name="input_log_retention"></a> [log\_retention](#input\_log\_retention) | n/a | `number` | `null` | no |
| <a name="input_pdnsz_name"></a> [pdnsz\_name](#input\_pdnsz\_name) | n/a | `string` | n/a | yes |
| <a name="input_pip_labels"></a> [pip\_labels](#input\_pip\_labels) | n/a | `set(string)` | `[]` | no |
| <a name="input_snet_count"></a> [snet\_count](#input\_snet\_count) | n/a | `number` | n/a | yes |
| <a name="input_snet_size"></a> [snet\_size](#input\_snet\_size) | n/a | `number` | n/a | yes |
| <a name="input_sp_name"></a> [sp\_name](#input\_sp\_name) | n/a | `string` | n/a | yes |
| <a name="input_sp_role"></a> [sp\_role](#input\_sp\_role) | n/a | `string` | n/a | yes |
| <a name="input_st_count"></a> [st\_count](#input\_st\_count) | n/a | `number` | `0` | no |
| <a name="input_st_sku"></a> [st\_sku](#input\_st\_sku) | n/a | `string` | `"Standard_GRS"` | no |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | n/a | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | n/a | yes |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | n/a | `string` | n/a | yes |
| <a name="input_user_name"></a> [user\_name](#input\_user\_name) | n/a | `string` | n/a | yes |
| <a name="input_user_role"></a> [user\_role](#input\_user\_role) | n/a | `string` | n/a | yes |
| <a name="input_vnet_cidr"></a> [vnet\_cidr](#input\_vnet\_cidr) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cname_url"></a> [cname\_url](#output\_cname\_url) | n/a |
| <a name="output_kv_url"></a> [kv\_url](#output\_kv\_url) | n/a |
| <a name="output_st_url"></a> [st\_url](#output\_st\_url) | n/a |
| <a name="output_subnets"></a> [subnets](#output\_subnets) | n/a |
