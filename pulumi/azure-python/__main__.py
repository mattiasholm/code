from os import access
from typing import KeysView
from unicodedata import name
import pulumi
import pulumi_azure_native as azure
import config

rg = azure.resources.ResourceGroup(
    'rg',
    resource_group_name=f'rg-{config.prefix}-001',
    tags=config.tags
)

appi = azure.insights.Component(
    'appi',
    resource_name_=f'appi-{config.prefix}-001',
    resource_group_name=rg.name,
    tags=config.tags,
    kind=config.appiKind,
    application_type=config.appiType
)

kv = azure.keyvault.Vault(
    'kv',
    vault_name=f'kv-{config.prefix}-001',
    resource_group_name=rg.name,
    tags=config.tags,
    properties=azure.keyvault.VaultPropertiesArgs(
        tenant_id=config.tenantId,
        sku=azure.keyvault.SkuArgs(
            family='A',
            name=config.kvSku
        ),
        access_policies=[
            azure.keyvault.AccessPolicyEntryArgs(
                tenant_id=config.tenantId,
                object_id=config.kvObjectId,
                permissions=azure.keyvault.PermissionsArgs(
                    keys=config.kvGroupKeyPermissions,
                    secrets=config.kvGroupSecretPermissions,
                    certificates=config.kvGroupCertPermissions
                )
            )
        ]
    )
)

azure.keyvault.Secret(
    'secret',
    secret_name='appi-connectionString',
    vault_name=kv.name,
    resource_group_name=rg.name,
    tags=config.tags,
    properties=azure.keyvault.SecretPropertiesArgs(
        value=appi.connection_string
    )
)

pips = []
for i, pipLabel in enumerate(config.pipLabels):
    pip = azure.network.PublicIPAddress(
        f'pip{i}',
        public_ip_address_name=f'pip-{config.prefix}-{str(i + 1).zfill(3)}',
        resource_group_name=rg.name,
        tags=config.tags,
        sku=azure.network.PublicIPAddressSkuArgs(
            name=config.pipSku
        ),
        public_ip_allocation_method=config.pipAllocation,
        dns_settings=azure.network.PublicIPAddressDnsSettingsArgs(
            domain_name_label=f'{pipLabel}-{config.prefix}'
        )
    )
    pips.append(pip)

sts = []
for i in range(0, config.stCount):
    st = azure.storage.StorageAccount(
        f'st{i}',
        account_name=f'st{config.prefixStripped}{str(i + 1).zfill(3)}',
        resource_group_name=rg.name,
        tags=config.tags,
        kind=config.stKind,
        sku=azure.storage.SkuArgs(
            name=config.stSku
        ),
        allow_blob_public_access=config.stPublicAccess,
        enable_https_traffic_only=config.stHttpsOnly,
        minimum_tls_version=config.stTlsVersion
    )
    sts.append(st)

    azure.storage.BlobContainer(
        f'container{i}',
        container_name=f'container{config.prefixStripped}001',
        account_name=st.name,
        resource_group_name=rg.name
    )

if config.vnetToggle:
    azure.network.VirtualNetwork(
        'vnet',
        virtual_network_name=f'vnet-{config.prefix}-001',
        resource_group_name=rg.name,
        tags=config.tags,
        address_space=azure.network.AddressSpaceArgs(
            address_prefixes=[
                config.vnetAddressPrefix
            ]
        ),
        subnets=[
            azure.network.SubnetArgs(
                name=f'snet-{config.prefix}-001',
                address_prefix=config.vnetAddressPrefix
            )
        ]
    )

pulumi.export('kvUrl', kv.properties.vault_uri)

pulumi.export('pipUrl', [pulumi.Output.concat(
    'https://', pip.dns_settings.fqdn, '/') for pip in pips])

pulumi.export('stUrl', [st.primary_endpoints for st in sts])
