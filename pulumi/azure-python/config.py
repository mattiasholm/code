import pulumi
import pulumi_azuread as azuread
import ipaddress

config = pulumi.Config()

tenantId = azuread.get_client_config().tenant_id
tags = config.get_object('tags')
prefix = '{Company}-{Application}'.format_map(tags).lower()
prefixStripped = prefix.replace('-', '')

appiKind = config.get('appiKind') or 'web'
appiType = config.get('appiType') or 'web'

kvSku = config.get('kvSku') or 'standard'
kvUsername = config.require('kvUsername')
kvUserObjectId = azuread.get_user(user_principal_name=kvUsername).object_id
kvUserKeyPermissions = config.get_object('kvUserKeyPermissions')
kvUserSecretPermissions = config.get_object('kvUserSecretPermissions')
kvUserCertPermissions = config.get_object('kvUserCertPermissions')
kvSpName = config.require('kvSpName')
kvSpObjectId = azuread.get_service_principal(display_name=kvSpName).object_id
kvSpSecretPermissions = config.get_object('kvSpSecretPermissions')

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

vnetAddressPrefix = config.get('vnetAddressPrefix')

if len(prefix) > 17:
    raise ValueError(f"'{prefix}' is longer than 17 characters")

if vnetAddressPrefix:
    network = ipaddress.ip_network(vnetAddressPrefix)

    if not network.is_private:
        raise ValueError(f"'{vnetAddressPrefix}' is not a private network")

    if network.prefixlen > 24:
        raise ValueError(f"'{vnetAddressPrefix}' is smaller than /24")
