import * as pulumi from '@pulumi/pulumi';
import * as azuread from '@pulumi/azuread';

const config = new pulumi.Config();

export const tenantId = azuread.getClientConfigOutput().tenantId;
export const tags = config.requireObject('tags');
export const prefix = `${tags.Company}-${tags.Application}`.toLowerCase();

export const logRetention = config.getNumber('logRetention');

const kvUserName = config.require('kvUserName');
export const kvUserObjectId = azuread.getUserOutput({ userPrincipalName: kvUserName }).objectId;
export const kvUserSecretPermissions = config.getObject('kvUserSecretPermissions');
const kvSpName = config.require('kvSpName');
export const kvSpObjectId = azuread.getServicePrincipalOutput({ displayName: kvSpName }).objectId;
export const kvSpSecretPermissions = config.getObject('kvSpSecretPermissions');

export const pdnszName = config.require('pdnszName');

export const pipLabels = config.getObject('pipLabels') || [];

export const stCount = config.getNumber('stCount');
export const stSku = config.get('stSku') || 'Standard_LRS';

export const vnetAddressPrefix = config.require('vnetAddressPrefix');
export const vnetSubnetSize = config.requireNumber('vnetSubnetSize');
export const vnetSubnetCount = config.requireNumber('vnetSubnetCount');

if (prefix.length > 18) {
    throw new Error(`Prefix '${prefix}' is longer than 18 characters`);
}
