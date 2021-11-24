import pulumi
from pulumi_azure_native import resources, storage

config = pulumi.Config()
prefix = config.require('prefix')
tags = config.get_object('tags')

# prefixStripped = prefix.lower().replace('-', '')

# stName = 'st{}001'.format(prefixStripped)
# stKind = 'StorageV2'
# stSku = 'Standard_LRS'
# stPublicAccess = False
# stHttpsOnly = True
# stTlsVersion = 'TLS1_2'
# stContainerName = 'container{}001'.format(prefixStripped)

# rg = resources.ResourceGroup('rg',
resources.ResourceGroup('rg',
                        resource_group_name=f'rg-{prefix}-001',
                        tags=tags
                        )

# st = storage.StorageAccount('st',
#                             account_name=stName,
#                             resource_group_name=rg.name,
#                             tags=tags,
#                             kind=stKind,
#                             sku={
#                                 'name': stSku
#                             },
#                             # # VS:
#                             # sku=storage.SkuArgs(
#                             #     name='Standard_LRS', # getattr(name, stSku)
#                             # ),
#                             allow_blob_public_access=stPublicAccess,
#                             enable_https_traffic_only=stHttpsOnly,
#                             minimum_tls_version=stTlsVersion
#                             )

# container = storage.BlobContainer('container',
#                                   container_name=stContainerName,
#                                   account_name=st.name,
#                                   resource_group_name=rg.name,
#                                   )
