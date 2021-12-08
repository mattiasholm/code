import pulumi
from pulumi_azure_native import authorization, resources, web, insights, keyvault, storage, network
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

rg = resources.ResourceGroup(
    'rg',
    resource_group_name=f'rg-{prefix}-001',
    tags=tags
)

plan = web.AppServicePlan(
    'plan',
    name=f'plan-{prefix}-001',
    resource_group_name=rg.name,
    tags=tags,
    kind=planKind,
    sku=web.SkuDescriptionArgs(
        name=planSku,
        capacity=planCapacity
    ),
    reserved=planReserved
)

apps = []
for i, appDockerImage in enumerate(appDockerImages):
    apps.append(web.WebApp(
        f'app{i}',
        name=f'app-{prefix}-{str(i + 1).zfill(3)}',
        resource_group_name=rg.name,
        tags=tags,
        server_farm_id=plan.name,
        identity=web.ManagedServiceIdentityArgs(
            type=appIdentity
        ),
        site_config=web.SiteConfigArgs(
            linux_fx_version=f'DOCKER|{appDockerImage}',
            always_on=appAlwaysOn,
            http20_enabled=appHttp2,
            min_tls_version=appTlsVersion,
            scm_min_tls_version=appTlsVersion,
            ftps_state=appFtpsState,
            app_settings=[
                web.NameValuePairArgs(
                    name='APPLICATIONINSIGHTS_CONNECTION_STRING', value='placeholder'),
                web.NameValuePairArgs(
                    name='KEYVAULT_URL', value='placeholder')
            ]
        ),
        client_affinity_enabled=appClientAffinity,
        https_only=appHttpsOnly
    ))

appi = insights.Component(
    'appi',
    resource_name_=f'appi-{prefix}-001',
    resource_group_name=rg.name,
    tags=tags,
    kind=appiKind,
    application_type=appiType
)

kv = keyvault.Vault(
    'kv',
    vault_name=f'kv-{prefix}-001',
    resource_group_name=rg.name,
    tags=tags,
    properties=keyvault.VaultPropertiesArgs(
        tenant_id=tenantId,
        sku=keyvault.SkuArgs(
            family=kvFamily,
            name=kvSku
        ),
        access_policies=[
            keyvault.AccessPolicyEntryArgs(
                tenant_id=tenantId,
                object_id=app.identity.principal_id,
                permissions=keyvault.PermissionsArgs(
                    secrets=kvAppSecretPermissions
                )
            )
            for app in apps
        ] + [
            keyvault.AccessPolicyEntryArgs(
                tenant_id=tenantId,
                object_id=kvGroupId,
                permissions=keyvault.PermissionsArgs(
                    keys=kvGroupKeyPermissions,
                    secrets=kvGroupSecretPermissions,
                    certificates=kvGroupCertPermissions
                )
            )
        ]
    )
)

keyvault.Secret(
    'secret',
    secret_name=kvSecretName,
    vault_name=kv.name,
    resource_group_name=rg.name,
    tags=tags,
    properties=keyvault.SecretPropertiesArgs(
        value=appi.connection_string
    )
)

sts = []
for i in range(0, stCount):
    sts.append(storage.StorageAccount(
        f'st{i}',
        account_name=f'st{prefixStripped}{str(i + 1).zfill(3)}',
        resource_group_name=rg.name,
        tags=tags,
        kind=stKind,
        sku=storage.SkuArgs(
            name=stSku
        ),
        allow_blob_public_access=stPublicAccess,
        enable_https_traffic_only=stHttpsOnly,
        minimum_tls_version=stTlsVersion
    ))

    storage.BlobContainer(
        f'container{i}',
        container_name=f'container{prefixStripped}001',
        account_name=sts[i].name,
        resource_group_name=rg.name
    )

if vnetToggle:
    network.VirtualNetwork(
        'vnet',
        virtual_network_name=f'vnet-{prefix}-001',
        resource_group_name=rg.name,
        tags=tags,
        address_space=network.AddressSpaceArgs(
            address_prefixes=[
                vnetAddressPrefix
            ]
        ),
        subnets=[
            network.SubnetArgs(
                name=f'snet-{prefix}-001',
                address_prefix=vnetAddressPrefix
            )
        ]
    )

pulumi.export('appUrl', [pulumi.Output.concat(
    'https://', app.default_host_name, '/') for app in apps])

pulumi.export('kvUrl', kv.properties.vault_uri)

pulumi.export('stUrl', [st.primary_endpoints for st in sts])
