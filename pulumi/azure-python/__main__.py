"""An Azure RM Python Pulumi program"""

import pulumi
from pulumi_azure_native import resources
from pulumi_azure_native import storage

# rg = resources.ResourceGroup('rg-holm-pulumi-001',
rg = resources.ResourceGroup('rg',
                             resource_group_name='rg-holm-pulumi-001',
                             # tags=[]
                             #  opts=ResourceOptions(delete_before_replace=True
                             )


st = storage.StorageAccount('st',
                            account_name='stholmpulumi001',
                            resource_group_name=rg.name,
                            sku=storage.SkuArgs(
                                name=storage.SkuName.STANDARD_LRS,
                            ),
                            kind=storage.Kind.STORAGE_V2)
