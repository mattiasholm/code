import pulumi
from pulumi_azure_native import resources, insights, keyvault, network, storage
import config

rg = resources.ResourceGroup('rg',
    resource_group_name=f'rg-{config.prefix}-01',
    tags=config.tags
)

if config.appi_kind:
    appi = insights.Component('appi',
        resource_name_=f'appi-{config.prefix}-01',
        resource_group_name=rg.name,
        tags=config.tags,
        kind=config.appi_kind,
        ingestion_mode='ApplicationInsights'
    )

kv = keyvault.Vault('kv',
    vault_name=f'kv-{config.prefix}-01',
    resource_group_name=rg.name,
    tags=config.tags,
    properties={
        'tenant_id': config.tenant_id,
        'sku': {
            'family': 'A',
            'name': config.kv_sku
        },
        'access_policies': [
            {
                'tenant_id': config.tenant_id,
                'object_id': config.kv_user_object_id,
                'permissions': {
                    'keys': config.kv_user_key_permissions,
                    'secrets': config.kv_user_secret_permissions,
                    'certificates': config.kv_user_certificate_permissions
                }
            },
            {
                'tenant_id': config.tenant_id,
                'object_id': config.kv_sp_object_id,
                'permissions': {
                    'secrets': config.kv_sp_secret_permissions
                }
            }
        ]
    }
)

if config.appi_kind:
    keyvault.Secret('secret',
        secret_name='APPLICATIONINSIGHTS-CONNECTION-STRING',
        vault_name=kv.name,
        resource_group_name=rg.name,
        tags=config.tags,
        properties={
            'value': appi.connection_string
        }
    )

pdnsz = network.PrivateZone('pdnsz',
    private_zone_name=config.pdnsz_name,
    resource_group_name=rg.name,
    location='global',
    tags=config.tags
)

pips = []
cnames = []

for i, pip_label in enumerate(config.pip_labels):
    pip = network.PublicIPAddress(f'pip{i}',
        public_ip_address_name=f'pip-{config.prefix}-{str(i + 1).zfill(2)}',
        resource_group_name=rg.name,
        tags=config.tags,
        sku={
            'name': config.pip_sku
        },
        public_ip_allocation_method=config.pip_allocation,
        dns_settings={
            'domain_name_label': f'{pip_label}-{config.prefix}'
        }
    )
    pips.append(pip)

    cname = network.PrivateRecordSet(f'cname{i}',
        relative_record_set_name=pip_label,
        private_zone_name=pdnsz.name,
        resource_group_name=rg.name,
        ttl=config.pdnsz_ttl,
        record_type='CNAME',
        cname_record={
            'cname': pip.dns_settings.fqdn
        }
    )
    cnames.append(cname)

sts = []

for i in range(config.st_count):
    st = storage.StorageAccount(f'st{i}',
        account_name=f'st{config.prefix_stripped}{str(i + 1).zfill(2)}',
        resource_group_name=rg.name,
        tags=config.tags,
        kind=config.st_kind,
        sku={
            'name': config.st_sku
        },
        allow_blob_public_access=config.st_public_access,
        enable_https_traffic_only=config.st_https_only,
        minimum_tls_version=config.st_tls_version
    )
    sts.append(st)

    storage.BlobContainer(f'container{i}',
        container_name='container-01',
        account_name=st.name,
        resource_group_name=rg.name
    )

vnet = network.VirtualNetwork('vnet',
    virtual_network_name=f'vnet-{config.prefix}-01',
    resource_group_name=rg.name,
    tags=config.tags,
    address_space={
        'address_prefixes': [
            config.vnet_address_prefix
        ]
    },
    subnets=[
        {
            'name': f'snet-{str(i + 1).zfill(2)}',
            'address_prefix': str(config.subnets[i])
        } for i in range(config.vnet_subnet_count)
    ]
)

network.VirtualNetworkLink('link',
    virtual_network_link_name=vnet.name,
    private_zone_name=pdnsz.name,
    resource_group_name=rg.name,
    location='global',
    virtual_network={
        'id': vnet.id
    },
    registration_enabled=config.pdnsz_registration
)

pulumi.export('kv_url', kv.properties.vault_uri)

pulumi.export('pdnsz_url', [cname.fqdn for cname in cnames])

pulumi.export('pip_url', [pulumi.Output.concat(
    'https://', pip.dns_settings.fqdn, '/') for pip in pips])

pulumi.export('st_url', [st.primary_endpoints for st in sts])
