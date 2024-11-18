import * as pulumi from '@pulumi/pulumi';
import * as azuread from '@pulumi/azuread';

const config = new pulumi.Config();

export const tenantId = (await azuread.getClientConfig()).tenantId;
export const tags = config.requireObject('tags');
export const prefix = `${tags.Company}-${tags.Application}`.toLowerCase();

export const logRetention = config.getNumber('logRetention');

export const kvUserName = config.require('kvUserName');
export const kvUserObjectId = (await azuread.getUser({ userPrincipalName: kvUserName })).objectId;
export const kvUserSecretPermissions = config.getObject('kvUserSecretPermissions');
export const kvSpName = config.require('kvSpName');
export const kvSpObjectId = (await azuread.getServicePrincipal({ displayName: kvSpName })).objectId;
export const kvSpSecretPermissions = config.getObject('kvSpSecretPermissions');

export const pdnszName = config.require('pdnszName');
export const pdnszTtl = config.getNumber('pdnszTtl') || 3600;

export const pipLabels = config.getObject('pipLabels') || [];

export const stCount = config.getNumber('stCount');
export const stSku = config.get('stSku') || 'Standard_LRS';
export const stTlsVersion = config.get('stTlsVersion') || 'TLS1_2';

export const vnetAddressPrefix = config.require('vnetAddressPrefix');
export const vnetSubnetSize = config.requireNumber('vnetSubnetSize');
export const vnetSubnetCount = config.requireNumber('vnetSubnetCount');
