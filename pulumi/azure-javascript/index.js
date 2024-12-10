import { resources, operationalinsights, keyvault, network, storage, authorization } from '@pulumi/azure-native';
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
        enableRbacAuthorization: true,
    },
});

if (config.logRetention) {
    new keyvault.Secret('secret', {
        secretName: 'log-workspace-id',
        vaultName: kv.name,
        resourceGroupName: rg.name,
        tags: config.tags,
        properties: {
            value: log.customerId,
        },
    });
}

const pdnsz = new network.PrivateZone('pdnsz', {
    privateZoneName: config.pdnszName,
    resourceGroupName: rg.name,
    location: 'global',
    tags: config.tags,
});

const pips = {};
const cnames = {};

config.pipLabels.forEach((label, i) => {
    const pip = new network.PublicIPAddress(`pip_${label}`, {
        publicIpAddressName: name('pip', i + 1),
        resourceGroupName: rg.name,
        tags: config.tags,
        sku: {
            name: 'Standard',
        },
        publicIPAllocationMethod: 'Static',
        dnsSettings: {
            domainNameLabel: name('pip', i + 1),
        },
    });

    pips[label] = pip;

    const cname = new network.PrivateRecordSet(`cname_${label}`, {
        relativeRecordSetName: label,
        privateZoneName: pdnsz.name,
        resourceGroupName: rg.name,
        ttl: 3600,
        recordType: 'CNAME',
        cnameRecord: {
            cname: pip.dnsSettings.fqdn,
        },
    });

    cnames[label] = cname;
});

const sts = [];

for (let i = 0; i < config.stCount; i++) {
    const st = new storage.StorageAccount(`st_${i}`, {
        accountName: strip(name('st', i + 1)),
        resourceGroupName: rg.name,
        tags: config.tags,
        kind: 'StorageV2',
        sku: {
            name: config.stSku,
        },
        networkRuleSet: {
            bypass: 'AzureServices',
            defaultAction: 'Allow',
            ipRules: [],
            virtualNetworkRules: [],
        },
    });

    sts.push(st);

    new storage.BlobContainer(`container_${i}`, {
        containerName: 'data',
        accountName: st.name,
        resourceGroupName: rg.name,
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
    subnets: Array.from({ length: config.vnetSubnetCount }, (_, i) => ({
        name: name('snet', i + 1),
        addressPrefix: cidrSubnet(config.vnetAddressPrefix, config.vnetSubnetSize, i),
    })),
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

Object.entries(config.roles).forEach(([key, value]) => {
    new authorization.RoleAssignment(`rbac_${key}`, {
        principalId: value.principalId,
        principalType: key,
        roleDefinitionId: value.roleId,
        scope: rg.id,
    });
});

export const kvUrl = kv.properties.vaultUri;

export const cnameUrl = Object.fromEntries(
    Object.entries(cnames).map(([key, value]) => [
        key,
        value.fqdn.apply(fqdn => `https://${fqdn.replace(/\.$/, '')}/`),
    ])
);

export const stUrl = sts.map(st => st.primaryEndpoints);

export const subnets = vnet.subnets.apply(subnets =>
    Object.fromEntries(subnets.map(({ name, addressPrefix }) => [name, addressPrefix]))
);
