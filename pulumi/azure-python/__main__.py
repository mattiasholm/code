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
    sku=web.SkuDescriptionArgs(
        name=config.planSku,
        capacity=config.planCapacity
    ),
    reserved=config.planReserved
)

apps = []
for i, appDockerImage in enumerate(config.appDockerImages):
    apps.append(web.WebApp(
        f'app{i}',
        name=f'app-{config.prefix}-{str(i + 1).zfill(3)}',
        resource_group_name=rg.name,
        tags=config.tags,
        server_farm_id=plan.name,
        identity=web.ManagedServiceIdentityArgs(
            type=config.appIdentity
        ),
        site_config=web.SiteConfigArgs(
            linux_fx_version=f'DOCKER|{appDockerImage}',
            always_on=config.appAlwaysOn,
            http20_enabled=config.appHttp2,
            min_tls_version=config.appTlsVersion,
            scm_min_tls_version=config.appTlsVersion,
            ftps_state=config.appFtpsState,
            app_settings=[
                # web.NameValuePairArgs(
                #     name='APPLICATIONINSIGHTS_CONNECTION_STRING', value=f'@Microsoft.KeyVault(VaultName={kv.name};SecretName={config.kvSecretName})'),
                # web.NameValuePairArgs(
                #     name='KEYVAULT_URL', value=kv.properties.vault_uri)
            ]
        ),
        client_affinity_enabled=config.appClientAffinity,
        https_only=config.appHttpsOnly
    ))

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
    properties=keyvault.VaultPropertiesArgs(
        tenant_id=config.tenantId,
        sku=keyvault.SkuArgs(
            family=config.kvFamily,
            name=config.kvSku
        ),
        access_policies=[
            keyvault.AccessPolicyEntryArgs(
                tenant_id=config.tenantId,
                object_id=app.identity.principal_id,
                permissions=keyvault.PermissionsArgs(
                    secrets=config.kvAppSecretPermissions
                )
            )
            for app in apps
        ] + [
            keyvault.AccessPolicyEntryArgs(
                tenant_id=config.tenantId,
                object_id=config.kvGroupId,
                permissions=keyvault.PermissionsArgs(
                    keys=config.kvGroupKeyPermissions,
                    secrets=config.kvGroupSecretPermissions,
                    certificates=config.kvGroupCertPermissions
                )
            )
        ]
    )
)

keyvault.Secret(
    'secret',
    secret_name=config.kvSecretName,
    vault_name=kv.name,
    resource_group_name=rg.name,
    tags=config.tags,
    properties=keyvault.SecretPropertiesArgs(
        value=appi.connection_string
    )
)

sts = []
for i in range(0, config.stCount):
    sts.append(storage.StorageAccount(
        f'st{i}',
        account_name=f'st{config.prefixStripped}{str(i + 1).zfill(3)}',
        resource_group_name=rg.name,
        tags=config.tags,
        kind=config.stKind,
        sku=storage.SkuArgs(
            name=config.stSku
        ),
        allow_blob_public_access=config.stPublicAccess,
        enable_https_traffic_only=config.stHttpsOnly,
        minimum_tls_version=config.stTlsVersion
    ))

    storage.BlobContainer(
        f'container{i}',
        container_name=f'container{config.prefixStripped}001',
        account_name=sts[i].name,
        resource_group_name=rg.name
    )

if config.vnetToggle:
    network.VirtualNetwork(
        'vnet',
        virtual_network_name=f'vnet-{config.prefix}-001',
        resource_group_name=rg.name,
        tags=config.tags,
        address_space=network.AddressSpaceArgs(
            address_prefixes=[
                config.vnetAddressPrefix
            ]
        ),
        subnets=[
            network.SubnetArgs(
                name=f'snet-{config.prefix}-001',
                address_prefix=config.vnetAddressPrefix
            )
        ]
    )

pulumi.export('appUrl', [pulumi.Output.concat(
    'https://', app.default_host_name, '/') for app in apps])

pulumi.export('kvUrl', kv.properties.vault_uri)

pulumi.export('stUrl', [st.primary_endpoints for st in sts])

# pulumi.export('APPLICATIONINSIGHTS_CONNECTION_STRING', pulumi.Output.concat(
#     '@Microsoft.KeyVault(VaultName=', kv.name, ';SecretName=', config.kvSecretName, ')'))

# pulumi.export('KEYVAULT_URL', kv.properties.vault_uri)
