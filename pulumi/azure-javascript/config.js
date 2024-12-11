import * as pulumi from '@pulumi/pulumi';
import * as azuread from '@pulumi/azuread';
import { getRoleId } from './functions.js';

const config = new pulumi.Config();

export const tags = config.requireObject('tags');
export const prefix = `${tags.Company}-${tags.Application}`.toLowerCase();

export const logRetention = config.getNumber('logRetention');

export const tenantId = (await azuread.getClientConfig()).tenantId;

export const pdnszName = config.require('pdnszName');

export const pipLabels = config.getObject('pipLabels') || [];

export const stCount = config.getNumber('stCount');
export const stSku = config.get('stSku') || 'Standard_GRS';

export const vnetCidr = config.require('vnetCidr');
export const snetCount = config.requireNumber('snetCount');
export const snetSize = config.requireNumber('snetSize');

const userName = config.require('userName');
const userRole = config.require('userRole');
const spName = config.require('spName');
const spRole = config.require('spRole');

export const roles = {
    User: {
        principalId: (await azuread.getUser({ userPrincipalName: userName })).objectId,
        roleId: getRoleId(userRole),
    },
    ServicePrincipal: {
        principalId: (await azuread.getServicePrincipal({ displayName: spName })).objectId,
        roleId: getRoleId(spRole),
    },
};

if (prefix.length > 18) {
    throw new Error(`Prefix '${prefix}' is longer than 18 characters`);
}
