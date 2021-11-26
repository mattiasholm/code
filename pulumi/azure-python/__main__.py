import pulumi
from pulumi_azure_native import resources, storage
from pulumi_azure_native.storage.blob_container import BlobContainer

config = pulumi.Config()

prefix = config.require('prefix')
prefixStripped = prefix.replace('-', '').lower()
tags = config.get_object('tags')

stCount = config.get_int('stCount') or 1
# for i in range(0, stCount):
#     print(i)
stKind = config.get('stKind') or 'StorageV2'
stSku = config.get('stSku') or 'Standard_LRS'
stPublicAccess = config.get_bool('stPublicAccess') or False
stHttpsOnly = config.get_bool('stHttpsOnly') or True
stTlsVersion = config.get('stTlsVersion') or 'TLS1_2'

rg = resources.ResourceGroup('rg',
                             resource_group_name=f'rg-{prefix}-001',
                             tags=tags
                             )

st = storage.StorageAccount('st',
                            account_name=f'st{prefixStripped}001',
                            resource_group_name=rg.name,
                            tags=tags,
                            kind=stKind,
                            sku=storage.SkuArgs(
                                name=stSku,
                            ),
                            allow_blob_public_access=stPublicAccess,
                            enable_https_traffic_only=stHttpsOnly,
                            minimum_tls_version=stTlsVersion
                            )

storage.BlobContainer('container',
                      container_name=f'container{prefixStripped}001',
                      account_name=st.name,
                      resource_group_name=rg.name,
                      )

pulumi.export('stUrl', st.primary_endpoints)
