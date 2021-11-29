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

web.AppServicePlan('plan',
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

pulumi.export('stUrl', [x.primary_endpoints for x in st])
