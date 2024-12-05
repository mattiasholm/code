import { resources, operationalinsights, keyvault, network, storage } from '@pulumi/azure-native';
import { name, strip, cidrSubnet } from './functions.js';
import * as config from './config.js';

const rg = new resources.ResourceGroup('rg', {
    resourceGroupName: name('rg'),
    tags: config.tags,
});

let log;

if (config.logRetention) {
    log = new operationalinsights.Workspace('log', {
        workspaceName: name('log'),
        resourceGroupName: rg.name,
        tags: config.tags,
        retentionInDays: config.logRetention,
    });
}

const kv = new keyvault.Vault('kv', {
    vaultName: name('kv'),
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
        publicIpAddressName: name('pip', i + 1),
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
        ttl: 3600,
        recordType: 'CNAME',
        cnameRecord: {
            cname: pip.dnsSettings.fqdn
        },
    });

    cnames.push(cname);
});

const sts = [];

for (let i = 0; i < config.stCount; i++) {
    const st = new storage.StorageAccount(`st${i}`, {
        accountName: strip(name('st', i + 1)),
        resourceGroupName: rg.name,
        tags: config.tags,
        kind: 'StorageV2',
        sku: {
            name: config.stSku
        },
        networkRuleSet: {
            bypass: 'AzureServices',
            defaultAction: 'Allow',
            ipRules: [],
            virtualNetworkRules: []
        },
    });

    sts.push(st);

    new storage.BlobContainer(`container${i}`, {
        containerName: name('container'),
        accountName: st.name,
        resourceGroupName: rg.name,
    });
}

const subnets = [];

for (let i = 0; i < config.vnetSubnetCount; i++) {
    subnets.push({
        name: name('snet', i + 1),
        addressPrefix: cidrSubnet(config.vnetAddressPrefix, config.vnetSubnetSize, i),
    });
}

const vnet = new network.VirtualNetwork('vnet', {
    virtualNetworkName: name('vnet'),
    resourceGroupName: rg.name,
    tags: config.tags,
    addressSpace: {
        addressPrefixes: [
            config.vnetAddressPrefix,
        ],
    },
    subnets: subnets,
});

new network.VirtualNetworkLink('link', {
    virtualNetworkLinkName: vnet.name,
    privateZoneName: pdnsz.name,
    resourceGroupName: rg.name,
    location: 'global',
    tags: config.tags,
    virtualNetwork: {
        id: vnet.id,
    },
    registrationEnabled: false,
});

export const kvUrl = kv.properties.vaultUri;

export const pdnszUrl = cnames.map(cname => cname.fqdn.apply(fqdn => `https://${fqdn.replace(/\.$/, '')}/`));

export const pipUrl = pips.map(pip => pip.dnsSettings.fqdn.apply(fqdn => `https://${fqdn}/`));

export const stUrl = sts.map(st => st.primaryEndpoints);
