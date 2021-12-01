import pulumi
from pulumi_azure_native import resources, web, storage

config = pulumi.Config()

prefix = config.require('prefix')
prefixStripped = prefix.replace('-', '').lower()
tags = config.get_object('tags')

planKind = config.get('planKind') or 'linux'
planSku = config.get('planSku') or 'B1'
planCapacity = config.get_int('planCapacity') or 1
planReserved = True if planKind == 'linux' else False

appDockerImage = config.require('appDockerImage')
appIdentity = config.get('appIdentity') or 'None'
appAlwaysOn = config.get_bool('appAlwaysOn') or True
appHttp20Enabled = config.get_bool('appHttp20Enabled') or True
appMinTlsVersion = config.get('appMinTlsVersion') or '1.2'
appFtpsState = config.get('appFtpsState') or 'FtpsOnly'
appClientAffinityEnabled = config.get_bool('appClientAffinityEnabled') or False
appHttpsOnly = config.get_bool('appHttpsOnly') or True

stCount = config.get_int('stCount') or 1
stKind = config.get('stKind') or 'StorageV2'
stSku = config.get('stSku') or 'Standard_LRS'
stPublicAccess = config.get_bool('stPublicAccess') or False
stHttpsOnly = config.get_bool('stHttpsOnly') or True
stTlsVersion = config.get('stTlsVersion') or 'TLS1_2'

rg = resources.ResourceGroup('rg',
                             resource_group_name=f'rg-{prefix}-001',
                             tags=tags
                             )

plan = web.AppServicePlan('plan',
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

app = web.WebApp('app',
                 name=f'app-{prefix}-001',
                 resource_group_name=rg.name,
                 server_farm_id=plan.name,
                 identity=web.ManagedServiceIdentityArgs(
                     type=appIdentity
                 ),
                 site_config=web.SiteConfigArgs(
                     linux_fx_version=f'DOCKER|{appDockerImage}',
                     always_on=appAlwaysOn,
                     http20_enabled=appHttp20Enabled,
                     min_tls_version=appMinTlsVersion,
                     ftps_state=appFtpsState
                 ),
                 client_affinity_enabled=appClientAffinityEnabled,
                 https_only=appHttpsOnly
                 )

st = []
for i in range(0, stCount):
    st.append(storage.StorageAccount(f'st{i}',
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

    storage.BlobContainer(f'container{i}',
                          container_name=f'container{prefixStripped}001',
                          account_name=st[i].name,
                          resource_group_name=rg.name
                          )

pulumi.export('appUrl', pulumi.Output.concat(
    'https://', app.default_host_name, '/'))

pulumi.export('stUrl', [x.primary_endpoints for x in st])
