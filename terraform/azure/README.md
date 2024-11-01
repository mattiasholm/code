## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.9.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | ~> 3.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.6.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | 3.0.2 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.6.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_application_insights.appi](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights) | resource |
| [azurerm_key_vault.kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault) | resource |
| [azurerm_key_vault_access_policy.policy_sp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.policy_user](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_secret.secret](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_private_dns_cname_record.cname](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_cname_record) | resource |
| [azurerm_private_dns_zone.pdnsz](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.link](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_public_ip.pip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_storage_account.st](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_container.container](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [azuread_service_principal.sp](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/service_principal) | data source |
| [azuread_user.user](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/user) | data source |
| [azurerm_subscription.sub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_appi_type"></a> [appi\_type](#input\_appi\_type) | n/a | `string` | `""` | no |
| <a name="input_kv_sku"></a> [kv\_sku](#input\_kv\_sku) | n/a | `string` | `"standard"` | no |
| <a name="input_kv_sp_name"></a> [kv\_sp\_name](#input\_kv\_sp\_name) | n/a | `string` | n/a | yes |
| <a name="input_kv_sp_secret_permissions"></a> [kv\_sp\_secret\_permissions](#input\_kv\_sp\_secret\_permissions) | n/a | `list(string)` | n/a | yes |
| <a name="input_kv_user_certificate_permissions"></a> [kv\_user\_certificate\_permissions](#input\_kv\_user\_certificate\_permissions) | n/a | `list(string)` | n/a | yes |
| <a name="input_kv_user_key_permissions"></a> [kv\_user\_key\_permissions](#input\_kv\_user\_key\_permissions) | n/a | `list(string)` | n/a | yes |
| <a name="input_kv_user_name"></a> [kv\_user\_name](#input\_kv\_user\_name) | n/a | `string` | n/a | yes |
| <a name="input_kv_user_secret_permissions"></a> [kv\_user\_secret\_permissions](#input\_kv\_user\_secret\_permissions) | n/a | `list(string)` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | n/a | yes |
| <a name="input_pdnsz_name"></a> [pdnsz\_name](#input\_pdnsz\_name) | n/a | `string` | n/a | yes |
| <a name="input_pdnsz_registration"></a> [pdnsz\_registration](#input\_pdnsz\_registration) | n/a | `bool` | `false` | no |
| <a name="input_pdnsz_ttl"></a> [pdnsz\_ttl](#input\_pdnsz\_ttl) | n/a | `number` | `3600` | no |
| <a name="input_pip_allocation"></a> [pip\_allocation](#input\_pip\_allocation) | n/a | `string` | `"Dynamic"` | no |
| <a name="input_pip_labels"></a> [pip\_labels](#input\_pip\_labels) | n/a | `set(string)` | `[]` | no |
| <a name="input_pip_sku"></a> [pip\_sku](#input\_pip\_sku) | n/a | `string` | `"Basic"` | no |
| <a name="input_st_count"></a> [st\_count](#input\_st\_count) | n/a | `number` | `0` | no |
| <a name="input_st_https_only"></a> [st\_https\_only](#input\_st\_https\_only) | n/a | `bool` | `true` | no |
| <a name="input_st_kind"></a> [st\_kind](#input\_st\_kind) | n/a | `string` | `"StorageV2"` | no |
| <a name="input_st_public_access"></a> [st\_public\_access](#input\_st\_public\_access) | n/a | `bool` | `false` | no |
| <a name="input_st_replication"></a> [st\_replication](#input\_st\_replication) | n/a | `string` | `"LRS"` | no |
| <a name="input_st_sku"></a> [st\_sku](#input\_st\_sku) | n/a | `string` | `"Standard"` | no |
| <a name="input_st_tls_version"></a> [st\_tls\_version](#input\_st\_tls\_version) | n/a | `string` | `"TLS1_2"` | no |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | n/a | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | n/a | yes |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | n/a | `string` | n/a | yes |
| <a name="input_vnet_address_prefix"></a> [vnet\_address\_prefix](#input\_vnet\_address\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_vnet_subnet_count"></a> [vnet\_subnet\_count](#input\_vnet\_subnet\_count) | n/a | `number` | n/a | yes |
| <a name="input_vnet_subnet_size"></a> [vnet\_subnet\_size](#input\_vnet\_subnet\_size) | n/a | `number` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_kv_url"></a> [kv\_url](#output\_kv\_url) | n/a |
| <a name="output_pdnsz_url"></a> [pdnsz\_url](#output\_pdnsz\_url) | n/a |
| <a name="output_pip_url"></a> [pip\_url](#output\_pip\_url) | n/a |
| <a name="output_st_url"></a> [st\_url](#output\_st\_url) | n/a |
