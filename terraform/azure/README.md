## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.2.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | ~> 2.20.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | 2.20.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_application_insights.appi](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights) | resource |
| [azurerm_key_vault.kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault) | resource |
| [azurerm_key_vault_access_policy.accesspolicy_sp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.accesspolicy_user](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
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
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_appiType"></a> [appiType](#input\_appiType) | n/a | `string` | `"web"` | no |
| <a name="input_kvSku"></a> [kvSku](#input\_kvSku) | n/a | `string` | `"standard"` | no |
| <a name="input_kvSpName"></a> [kvSpName](#input\_kvSpName) | n/a | `string` | n/a | yes |
| <a name="input_kvSpSecretPermissions"></a> [kvSpSecretPermissions](#input\_kvSpSecretPermissions) | n/a | `list(string)` | n/a | yes |
| <a name="input_kvUserCertPermissions"></a> [kvUserCertPermissions](#input\_kvUserCertPermissions) | n/a | `list(string)` | n/a | yes |
| <a name="input_kvUserKeyPermissions"></a> [kvUserKeyPermissions](#input\_kvUserKeyPermissions) | n/a | `list(string)` | n/a | yes |
| <a name="input_kvUserSecretPermissions"></a> [kvUserSecretPermissions](#input\_kvUserSecretPermissions) | n/a | `list(string)` | n/a | yes |
| <a name="input_kvUsername"></a> [kvUsername](#input\_kvUsername) | n/a | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | n/a | yes |
| <a name="input_pdnszName"></a> [pdnszName](#input\_pdnszName) | n/a | `string` | n/a | yes |
| <a name="input_pdnszRegistration"></a> [pdnszRegistration](#input\_pdnszRegistration) | n/a | `bool` | `false` | no |
| <a name="input_pdnszTtl"></a> [pdnszTtl](#input\_pdnszTtl) | n/a | `number` | `3600` | no |
| <a name="input_pipAllocation"></a> [pipAllocation](#input\_pipAllocation) | n/a | `string` | `"Dynamic"` | no |
| <a name="input_pipLabels"></a> [pipLabels](#input\_pipLabels) | n/a | `list(string)` | n/a | yes |
| <a name="input_pipSku"></a> [pipSku](#input\_pipSku) | n/a | `string` | `"Basic"` | no |
| <a name="input_stCount"></a> [stCount](#input\_stCount) | n/a | `number` | `1` | no |
| <a name="input_stHttpsOnly"></a> [stHttpsOnly](#input\_stHttpsOnly) | n/a | `bool` | `true` | no |
| <a name="input_stKind"></a> [stKind](#input\_stKind) | n/a | `string` | `"StorageV2"` | no |
| <a name="input_stPublicAccess"></a> [stPublicAccess](#input\_stPublicAccess) | n/a | `bool` | `false` | no |
| <a name="input_stReplication"></a> [stReplication](#input\_stReplication) | n/a | `string` | `"LRS"` | no |
| <a name="input_stSku"></a> [stSku](#input\_stSku) | n/a | `string` | `"Standard"` | no |
| <a name="input_stTlsVersion"></a> [stTlsVersion](#input\_stTlsVersion) | n/a | `string` | `"TLS1_2"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | `{}` | no |
| <a name="input_vnetAddressPrefix"></a> [vnetAddressPrefix](#input\_vnetAddressPrefix) | n/a | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_kvUrl"></a> [kvUrl](#output\_kvUrl) | n/a |
| <a name="output_pdnszUrl"></a> [pdnszUrl](#output\_pdnszUrl) | n/a |
| <a name="output_pipUrl"></a> [pipUrl](#output\_pipUrl) | n/a |
| <a name="output_stUrl"></a> [stUrl](#output\_stUrl) | n/a |
