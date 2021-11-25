import pulumi
from pulumi_azure_native import resources, storage

config = pulumi.Config()
prefix = config.require('prefix')
prefixStripped = prefix.replace('-', '').lower()
tags = config.get_object('tags')

stConfig = config.get_object('st')

rg = resources.ResourceGroup('rg',
                             resource_group_name=f'rg-{prefix}-001',
                             tags=tags
                             )

st = storage.StorageAccount('st',
                            account_name=f'st{prefixStripped}001',
                            resource_group_name=rg.name,
                            tags=tags,
                            kind=stConfig['kind'],
                            sku={
                                'name': stConfig['sku']
                            },
                            # # VS:
                            # sku=storage.SkuArgs(
                            #     name='Standard_LRS', # getattr(name, stSku)
                            # ),
                            allow_blob_public_access=stConfig['publicAccess'],
                            enable_https_traffic_only=stConfig['httpsOnly'],
                            minimum_tls_version=stConfig['tlsVersion']
                            )

storage.BlobContainer('container',
                      container_name=f'container{prefixStripped}001',
                      account_name=st.name,
                      resource_group_name=rg.name,
                      )

# Output - print() VS bättre metod? Hamnar ju som Diagnostics då, vilket känns fel...
