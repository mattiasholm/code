import { DefaultAzureCredential } from '@azure/identity';
import { AuthorizationManagementClient } from '@azure/arm-authorization';
import { authorization } from '@pulumi/azure-native';
import { prefix } from './config.js';

export async function getRoleId(roleName) {
    const credential = new DefaultAzureCredential();
    const subscriptionId = (await authorization.getClientConfig()).subscriptionId;
    const client = new AuthorizationManagementClient(credential, subscriptionId);

    for await (const role of client.roleDefinitions.list(`/subscriptions/${subscriptionId}`)) {
        if (role.roleName === roleName) {
            return role.id;
        }
    }

    throw new Error(`Role '${roleName}' not found.`);
}

export function name(type, instance = 1) {
    return `${type}-${prefix}-${String(instance).padStart(2, '0')}`;
}

export function strip(name) {
    return name.replace(/-/g, '');
}

export function cidrSubnet(network, newCidr, subnetIndex) {
    const ipToInteger = (ip) => ip.split('.').reduce((acc, octet) => (acc << 8) + +octet, 0);
    const integerToIp = (int) => `${(int >>> 24) & 255}.${(int >>> 16) & 255}.${(int >>> 8) & 255}.${int & 255}`;

    const baseInteger = ipToInteger(network.split('/')[0]);
    const subnetSize = 2 ** (32 - newCidr);
    const subnetInteger = baseInteger + subnetSize * subnetIndex;

    return `${integerToIp(subnetInteger)}/${newCidr}`;
}
