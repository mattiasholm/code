import pulumi
from pulumi_azure_native import resources, web, insights, keyvault, storage, network
import config

rg = resources.ResourceGroup(
    'rg',
    resource_group_name=f'rg-{config.prefix}-001',
    tags=config.tags
)

plan = web.AppServicePlan(
    'plan',
    name=f'plan-{config.prefix}-001',
    resource_group_name=rg.name,
    tags=config.tags,
    kind=config.planKind,
    sku={
        'name': config.planSku,
        'capacity': config.planCapacity
    },
    reserved=config.planReserved
)

apps = []
for i, appDockerImage in enumerate(config.appDockerImages):
    app = web.WebApp(
        f'app{i}',
        name=f'app-{config.prefix}-{str(i + 1).zfill(3)}',
        resource_group_name=rg.name,
        tags=config.tags,
        server_farm_id=plan.name,
        identity={
            'type': config.appIdentity
        },
        site_config={
            'linux_fx_version': f'DOCKER|{appDockerImage}',
            'always_on': config.appAlwaysOn,
            'http20_enabled': config.appHttp2,
            'min_tls_version': config.appTlsVersion,
            'scm_min_tls_version': config.appTlsVersion,
            'ftps_state': config.appFtpsState
        },
        client_affinity_enabled=config.appClientAffinity,
        https_only=config.appHttpsOnly
    )
    apps.append(app)

appi = insights.Component(
    'appi',
    resource_name_=f'appi-{config.prefix}-001',
    resource_group_name=rg.name,
    tags=config.tags,
    kind=config.appiKind,
    application_type=config.appiType
)

kv = keyvault.Vault(
    'kv',
    vault_name=f'kv-{config.prefix}-001',
    resource_group_name=rg.name,
    tags=config.tags,
    properties={
        'tenant_id': config.tenantId,
        'sku': {
            'family': config.kvFamily,
            'name': config.kvSku
        },
        'access_policies': [
            {
                'tenant_id': config.tenantId,
                'object_id': app.identity.principal_id,
                'permissions': {
                    'secrets': config.kvAppSecretPermissions
                }
            }
            for app in apps
        ] + [
            {
                'tenant_id': config.tenantId,
                'object_id': config.kvGroupId,
                'permissions': {
                    'keys': config.kvGroupKeyPermissions,
                    'secrets': config.kvGroupSecretPermissions,
                    'certificates': config.kvGroupCertPermissions
                }
            }
        ]
    }
)

for i, app in enumerate(apps):
    web.WebAppApplicationSettings(
        f'appsettings{i}',
        name=app.name,
        resource_group_name=rg.name,
        properties={
            'APPLICATIONINSIGHTS_CONNECTION_STRING': pulumi.Output.concat('@Microsoft.KeyVault(VaultName=', kv.name, ';SecretName=', config.kvSecretName, ')'),
            'KEYVAULT_URL': kv.properties.vault_uri
        }
    )

keyvault.Secret(
    'secret',
    secret_name=config.kvSecretName,
    vault_name=kv.name,
    resource_group_name=rg.name,
    tags=config.tags,
    properties={
        'value': appi.connection_string
    }
)

sts = []
for i in range(0, config.stCount):
    st = storage.StorageAccount(
        f'st{i}',
        account_name=f'st{config.prefixStripped}{str(i + 1).zfill(3)}',
        resource_group_name=rg.name,
        tags=config.tags,
        kind=config.stKind,
        sku={
            'name': config.stSku
        },
        allow_blob_public_access=config.stPublicAccess,
        enable_https_traffic_only=config.stHttpsOnly,
        minimum_tls_version=config.stTlsVersion
    )
    sts.append(st)

    storage.BlobContainer(
        f'container{i}',
        container_name=f'container{config.prefixStripped}001',
        account_name=st.name,
        resource_group_name=rg.name
    )

if config.vnetToggle:
    network.VirtualNetwork(
        'vnet',
        virtual_network_name=f'vnet-{config.prefix}-001',
        resource_group_name=rg.name,
        tags=config.tags,
        address_space={
            'address_prefixes': [
                config.vnetAddressPrefix
            ]
        },
        subnets=[
            {
                'name': f'snet-{config.prefix}-001',
                'address_prefix': config.vnetAddressPrefix
            }
        ]
    )

pulumi.export('appUrl', [pulumi.Output.concat(
    'https://', app.default_host_name, '/') for app in apps])

pulumi.export('kvUrl', kv.properties.vault_uri)

pulumi.export('stUrl', [st.primary_endpoints for st in sts])
