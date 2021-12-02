import pulumi
from pulumi_azure_native import resources, web, storage, insights

config = pulumi.Config()

prefix = config.require('prefix')
prefixStripped = prefix.replace('-', '').lower()
tags = config.get_object('tags')

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

stCount = config.get_int('stCount') or 1
stKind = config.get('stKind') or 'StorageV2'
stSku = config.get('stSku') or 'Standard_LRS'
stPublicAccess = config.get_bool('stPublicAccess') or False
stHttpsOnly = config.get_bool('stHttpsOnly') or True
stTlsVersion = config.get('stTlsVersion') or 'TLS1_2'

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

app = []
for i, appDockerImage in enumerate(appDockerImages):
    app.append(web.WebApp(
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
            # min_tls_version=appTlsVersion,
            min_tls_version=web.SupportedTlsVersions(appTlsVersion),
            # ftps_state=appFtpsState,
            ftps_state=web.FtpsState(appFtpsState),
            app_settings=[
                web.NameValuePairArgs(
                    name="APPLICATIONINSIGHTS_CONNECTION_STRING", value='placeholder'),
                web.NameValuePairArgs(
                    name="KEYVAULT_URL", value='placeholder')
            ],
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
    # application_type=appiType
    application_type=insights.ApplicationType(appiType)
)

st = []
for i in range(0, stCount):
    st.append(storage.StorageAccount(
        f'st{i}',
        account_name=f'st{prefixStripped}{str(i + 1).zfill(3)}',
        resource_group_name=rg.name,
        tags=tags,
        # kind=stKind,
        kind=storage.Kind(stKind),
        sku=storage.SkuArgs(
            # name=stSku
            name=storage.SkuName(stSku)
        ),
        allow_blob_public_access=stPublicAccess,
        enable_https_traffic_only=stHttpsOnly,
        # minimum_tls_version=stTlsVersion
        minimum_tls_version=storage.MinimumTlsVersion(stTlsVersion)
    ))

    storage.BlobContainer(
        f'container{i}',
        container_name=f'container{prefixStripped}001',
        account_name=st[i].name,
        resource_group_name=rg.name
    )

pulumi.export('appUrl', [pulumi.Output.concat(
    'https://', app.default_host_name, '/') for app in app])

pulumi.export('stUrl', [st.primary_endpoints for st in st])
