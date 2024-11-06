import { resources, operationalinsights, keyvault } from '@pulumi/azure-native';
import * as config from './config.js';

const rg = new resources.ResourceGroup('rg', {
    resourceGroupName: `rg-${config.prefix}-01`,
    tags: config.tags,
});

if (config.logRetention) {
    new operationalinsights.Workspace('log', {
        workspaceName: `log-${config.prefix}-01`,
        resourceGroupName: rg.name,
        tags: config.tags,
        retentionInDays: config.logRetention,
    });
}

const kv = new keyvault.Vault('kv', {
    vaultName: `kv-${config.prefix}-01`,
    resourceGroupName: rg.name,
    tags: config.tags,
    properties: {
        tenantId: config.tenantId,
        sku: {
            family: 'A',
            name: 'standard'
        },
        accessPolicies: [
            {
                tenantId: config.tenantId,
                objectId: config.kvUserObjectId,
                permissions: {
                    secrets: config.kvUserSecretPermissions,
                }
            },
            {
                tenantId: config.tenantId,
                objectId: config.kvSpObjectId,
                permissions: {
                    secrets: config.kvSpSecretPermissions
                }
            }
        ]
    }
});
