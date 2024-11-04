import * as resources from '@pulumi/azure-native/resources';
import * as config from './config';

const rg = new resources.ResourceGroup('rg', {
    resourceGroupName: `rg-${config.prefix}-02`,
    tags: config.tags,
});

export const rgName = rg.name
