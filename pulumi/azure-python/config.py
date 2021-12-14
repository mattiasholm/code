import pulumi
from pulumi_azure_native import authorization
import pulumi_azuread as azuread

config = pulumi.Config()

prefix = config.require('prefix')
prefixStripped = prefix.replace('-', '').lower()
tags = config.get_object('tags')
tenantId = authorization.get_client_config().tenant_id

planKind = config.get('planKind') or 'linux'
planSku = config.get('planSku') or 'B1'
planCapacity = config.get_int('planCapacity') or 1
planReserved = True if planKind == 'linux' else False

appDockerImages = config.require_object('appDockerImages')
appIdentity = config.get('appIdentity') or 'None'
appAlwaysOn = config.get_bool('appAlwaysOn') or True
appHttp2 = config.get_bool('appHttp2') or True
appTlsVersion = config.get('appTlsVersion') or '1.2'
appFtpsState = config.get('appFtpsState') or 'FtpsOnly'
appClientAffinity = config.get_bool('appClientAffinity') or False
appHttpsOnly = config.get_bool('appHttpsOnly') or True

appiKind = config.get('appiKind') or 'web'
appiType = config.get('appiType') or 'web'

kvFamily = 'A'
kvSku = config.get('kvSku') or 'standard'
kvAppSecretPermissions = config.get_object('kvAppSecretPermissions')
kvGroupName = config.require('kvGroupName')
kvGroupId = azuread.get_group(display_name=kvGroupName).object_id
kvGroupKeyPermissions = config.get_object('kvGroupKeyPermissions')
kvGroupSecretPermissions = config.get_object('kvGroupSecretPermissions')
kvGroupCertPermissions = config.get_object('kvGroupCertPermissions')
kvSecretName = 'appiConnectionString'

stCount = config.get_int('stCount') or 1
stKind = config.get('stKind') or 'StorageV2'
stSku = config.get('stSku') or 'Standard_LRS'
stPublicAccess = config.get_bool('stPublicAccess') or False
stHttpsOnly = config.get_bool('stHttpsOnly') or True
stTlsVersion = config.get('stTlsVersion') or 'TLS1_2'

vnetToggle = config.get_bool('vnetToggle') or False
vnetAddressPrefix = config.get('vnetAddressPrefix')
