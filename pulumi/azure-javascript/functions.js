import { prefix } from './config.js';

export function name(type, instance = 1) {
    return `${type}-${prefix}-${String(instance).padStart(2, '0')}`;
}

export function strip(prefix) {
    return prefix.replace(/-/g, '');
}

export function cidrSubnet(network, newCidr, subnetIndex) {
    const ipToInteger = (ip) => ip.split('.').reduce((acc, octet) => (acc << 8) + +octet, 0);
    const integerToIp = (int) => `${(int >>> 24) & 255}.${(int >>> 16) & 255}.${(int >>> 8) & 255}.${int & 255}`;

    const baseInteger = ipToInteger(network.split('/')[0]);
    const subnetSize = 2 ** (32 - newCidr);
    const subnetInteger = baseInteger + subnetSize * subnetIndex;

    return `${integerToIp(subnetInteger)}/${newCidr}`;
}
