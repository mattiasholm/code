"""An Azure RM Python Pulumi program"""

import pulumi
from pulumi_azure_native import resources
from pulumi_azure_native import storage

prefix = 'holm-pulumi'
prefixStripped = prefix.lower().replace('-', '')

rg = resources.ResourceGroup('rg',
                             resource_group_name='rg-{}-001'.format(prefix),
                             #  tags='',
                             opts=pulumi.resource.ResourceOptions(
                                 delete_before_replace=True)
                             )


st = storage.StorageAccount('st',
                            account_name='st{}001'.format(prefixStripped),
                            resource_group_name=rg.name,
                            sku=storage.SkuArgs(
                                name=storage.SkuName.STANDARD_LRS,
                            ),
                            kind=storage.Kind.STORAGE_V2)
