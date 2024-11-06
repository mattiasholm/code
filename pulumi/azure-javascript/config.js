import * as pulumi from '@pulumi/pulumi';
import * as azuread from '@pulumi/azuread';

const config = new pulumi.Config();

export const tenantId = (await azuread.getClientConfig()).tenantId;
export const tags = config.requireObject('tags');
export const prefix = `${tags.Company}-${tags.Application}`.toLowerCase();

export const logRetention = config.getNumber('logRetention');

export const kvUserName = config.require('kvUserName');
export const kvUserObjectId = (await azuread.getUser({ userPrincipalName: kvUserName, })).objectId;
export const kvUserSecretPermissions = config.getObject('kvUserSecretPermissions');
export const kvSpName = config.require('kvSpName');
export const kvSpObjectId = (await azuread.getServicePrincipal({ displayName: kvSpName })).objectId;
export const kvSpSecretPermissions = config.getObject('kvSpSecretPermissions');
