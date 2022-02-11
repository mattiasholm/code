import pulumi
from pulumi_azure_native import resources, insights, keyvault, network, storage
import config

rg = resources.ResourceGroup(
    'rg',
    resource_group_name=f'rg-{config.prefix}-001',
    tags=config.tags
)

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
            family='A',
            name=config.kvSku
        ),
        access_policies=[
            keyvault.AccessPolicyEntryArgs(
                tenant_id=config.tenantId,
                object_id=config.kvObjectId,
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
    secret_name='appi-connectionString',
    vault_name=kv.name,
    resource_group_name=rg.name,
    tags=config.tags,
    properties=keyvault.SecretPropertiesArgs(
        value=appi.connection_string
    )
)

pips = []
for i, pipLabel in enumerate(config.pipLabels):
    pip = network.PublicIPAddress(
        f'pip{i}',
        public_ip_address_name=f'pip-{config.prefix}-{str(i + 1).zfill(3)}',
        resource_group_name=rg.name,
        tags=config.tags,
        sku=network.PublicIPAddressSkuArgs(
            name=config.pipSku
        ),
        public_ip_allocation_method=config.pipAllocation,
        dns_settings=network.PublicIPAddressDnsSettingsArgs(
            domain_name_label=f'{pipLabel}-{config.prefix}'
        )
    )
    pips.append(pip)

sts = []
for i in range(0, config.stCount):
    st = storage.StorageAccount(
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

pulumi.export('kvUrl', kv.properties.vault_uri)

pulumi.export('pipUrl', [pulumi.Output.concat(
    'https://', pip.dns_settings.fqdn, '/') for pip in pips])

pulumi.export('stUrl', [st.primary_endpoints for st in sts])
