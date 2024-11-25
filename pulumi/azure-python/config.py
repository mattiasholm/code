import pulumi
import pulumi_azuread as azuread
import ipaddress

config = pulumi.Config()

tenant_id = azuread.get_client_config().tenant_id
tags = config.require_object('tags')
prefix = '{Company}-{Application}'.format_map(tags).lower()

appi_kind = config.get('appi_kind')

kv_sku = config.get('kv_sku') or 'standard'
kv_user_name = config.require('kv_user_name')
kv_user_object_id = azuread.get_user(user_principal_name=kv_user_name).object_id
kv_user_key_permissions = config.get_object('kv_user_key_permissions')
kv_user_secret_permissions = config.get_object('kv_user_secret_permissions')
kv_user_certificate_permissions = config.get_object('kv_user_certificate_permissions')
kv_sp_name = config.require('kv_sp_name')
kv_sp_object_id = azuread.get_service_principal(display_name=kv_sp_name).object_id
kv_sp_secret_permissions = config.get_object('kv_sp_secret_permissions')

pdnsz_name = config.require('pdnsz_name')
pdnsz_registration = config.get_bool('pdnsz_registration') or False
pdnsz_ttl = config.get_int('pdnsz_ttl') or 3600

pip_labels = config.get_object('pip_labels') or []
pip_sku = config.get('pip_sku') or 'Basic'
pip_allocation = config.get('pip_allocation') or 'Dynamic'

st_count = config.get_int('st_count') or 0
st_kind = config.get('st_kind') or 'StorageV2'
st_sku = config.get('st_sku') or 'Standard_LRS'
st_public_access = config.get_bool('st_public_access') or False
st_https_only = config.get_bool('st_https_only') or True
st_tls_version = config.get('st_tls_version') or 'TLS1_2'

vnet_address_prefix = config.require('vnet_address_prefix')
vnet_subnet_size = config.require_int('vnet_subnet_size')
vnet_subnet_count = config.require_int('vnet_subnet_count')
network = ipaddress.ip_network(vnet_address_prefix)
subnets = list(network.subnets(new_prefix=vnet_subnet_size))

if len(prefix) > 18:
    raise ValueError(f"Prefix '{prefix}' is longer than 18 characters")
