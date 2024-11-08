
// import * as pulumi from '@pulumi/pulumi'; // VS endast pulumi.Output ???
import { resources, operationalinsights, keyvault, network } from '@pulumi/azure-native';
import * as config from './config.js';

// function strip(prefix) {
//     return prefix.replace(/-/g, '');
// }

const rg = new resources.ResourceGroup('rg', {
    resourceGroupName: `rg-${config.prefix}-01`,
    tags: config.tags,
});

let log;

if (config.logRetention) {
    log = new operationalinsights.Workspace('log', {
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
            name: 'standard',
        },
        accessPolicies: [
            {
                tenantId: config.tenantId,
                objectId: config.kvUserObjectId,
                permissions: {
                    secrets: config.kvUserSecretPermissions,
                },
            },
            {
                tenantId: config.tenantId,
                objectId: config.kvSpObjectId,
                permissions: {
                    secrets: config.kvSpSecretPermissions
                },
            },
        ],
    },
});

if (config.logRetention) {
    new keyvault.Secret('secret', {
        secretName: 'log-workspace-id',
        vaultName: kv.name,
        resourceGroupName: rg.name,
        tags: config.tags,
        properties: {
            value: log.customerId
        },
    });
}

const pdnsz = new network.PrivateZone('pdnsz', {
    privateZoneName: config.pdnszName,
    resourceGroupName: rg.name,
    location: 'global',
    tags: config.tags,
});

const pips = [];
const cnames = [];

config.pipLabels.forEach((pipLabel, i) => {
    const pip = new network.PublicIPAddress(`pip${i}`, {
        publicIpAddressName: `pip-${config.prefix}-${(i + 1).toString().padStart(2, '0')}`,
        resourceGroupName: rg.name,
        tags: config.tags,
        dnsSettings: {
            domainNameLabel: `${pipLabel}-${config.prefix}`
        },
    });

    pips.push(pip);

    const cname = new network.PrivateRecordSet(`cname${i}`, {
        relativeRecordSetName: pipLabel,
        privateZoneName: pdnsz.name,
        resourceGroupName: rg.name,
        ttl: config.pdnszTtl,
        recordType: 'CNAME',
        cnameRecord: {
            cname: pip.dnsSettings.fqdn
        },
    });

    cnames.push(cname);
});

export const rgName = rg.name;
