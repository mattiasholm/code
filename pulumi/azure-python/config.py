import pulumi
from pulumi_azure_native import authorization
import pulumi_azuread as azuread
import ipaddress

config = pulumi.Config()

prefix = config.require('prefix')
prefixStripped = prefix.replace('-', '').lower()
tags = config.get_object('tags')
tenantId = authorization.get_client_config().tenant_id

appiKind = config.get('appiKind') or 'web'
appiType = config.get('appiType') or 'web'

kvSku = config.get('kvSku') or 'standard'
kvUsername = config.require('kvUsername')
kvObjectId = azuread.get_user(user_principal_name=kvUsername).object_id
kvKeyPermissions = config.get_object('kvKeyPermissions')
kvSecretPermissions = config.get_object('kvSecretPermissions')
kvCertificatePermissions = config.get_object('kvCertificatePermissions')

pdnszName = config.require('pdnszName')
pdnszRegistration = config.get_bool('pdnszRegistration') or False
pdnszTtl = config.get_int('pdnszTtl') or 3600

pipLabels = config.require_object('pipLabels')
pipSku = config.get('pipSku') or 'Basic'
pipAllocation = config.get('pipAllocation') or 'Dynamic'

stCount = config.get_int('stCount') or 1
stKind = config.get('stKind') or 'StorageV2'
stSku = config.get('stSku') or 'Standard_LRS'
stPublicAccess = config.get_bool('stPublicAccess') or False
stHttpsOnly = config.get_bool('stHttpsOnly') or True
stTlsVersion = config.get('stTlsVersion') or 'TLS1_2'

vnetToggle = config.get_bool('vnetToggle') or False
vnetAddressPrefix = config.get('vnetAddressPrefix')

if len(prefix) > 17:
    raise ValueError(f"'{prefix}' is longer than 17")

if vnetToggle:
    network = ipaddress.ip_network(vnetAddressPrefix)

    if not network.is_private:
        raise ValueError(f"'{vnetAddressPrefix}' is not a private network")

    if network.prefixlen > 24:
        raise ValueError(f"'{vnetAddressPrefix}' is smaller than /24")
