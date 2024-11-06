import { resources } from '@pulumi/azure-native'
import * as config from './config';

const rg = new resources.ResourceGroup('rg', {
    resourceGroupName: `rg-${config.prefix}-01`,
    tags: config.tags,
});

export const rgName = rg.name
