import * as pulumi from '@pulumi/pulumi';
import * as azuread from '@pulumi/azuread';
import { authorization } from '@pulumi/azure-native';

const roleId = {
    'Key Vault Administrator': '00482a5a-887f-4fb3-b363-3b7fe8e74483',
    'Key Vault Secrets Officer': 'b86a8fe4-44ce-4948-aee5-eccb2c155cd7',
}

const config = new pulumi.Config();

export const tenantId = (await azuread.getClientConfig()).tenantId;
const subscriptionId = (await authorization.getClientConfig()).subscriptionId;

export const tags = config.requireObject('tags');
export const prefix = `${tags.Company}-${tags.Application}`.toLowerCase();

export const logRetention = config.getNumber('logRetention');

const kvUserName = config.require('kvUserName');
const kvUserObjectId = (await azuread.getUser({ userPrincipalName: kvUserName })).objectId;

const kvUserRole = config.require('kvUserRole');
const kvUserRoleId = (await authorization.getRoleDefinition({ roleDefinitionId: roleId[kvUserRole], scope: `/subscriptions/${subscriptionId}` })).id;

const kvSpName = config.require('kvSpName');
const kvSpObjectId = (await azuread.getServicePrincipal({ displayName: kvSpName })).objectId;

const kvSpRole = config.require('kvSpRole');
const kvSpRoleId = (await authorization.getRoleDefinition({ roleDefinitionId: roleId[kvSpRole], scope: `/subscriptions/${subscriptionId}` })).id;

export const pdnszName = config.require('pdnszName');

export const pipLabels = config.getObject('pipLabels') || [];

export const stCount = config.getNumber('stCount');
export const stSku = config.get('stSku') || 'Standard_GRS';

export const vnetAddressPrefix = config.require('vnetAddressPrefix');
export const vnetSubnetSize = config.requireNumber('vnetSubnetSize');
export const vnetSubnetCount = config.requireNumber('vnetSubnetCount');

export const roles = {
    User: {
        principal: kvUserObjectId,
        role: kvUserRoleId,
    },
    ServicePrincipal: {
        principal: kvSpObjectId,
        role: kvSpRoleId,
    },
}

if (prefix.length > 18) {
    throw new Error(`Prefix '${prefix}' is longer than 18 characters`);
}
