import * as pulumi from '@pulumi/pulumi'
import { authorization, resources, insights, keyvault } from '@pulumi/azure-native'
import * as azuread from '@pulumi/azuread'

const config = new pulumi.Config()

const prefix = config.require('prefix')
const prefixStripped = prefix.replace('-', '').toLowerCase()
const tags: undefined = config.getObject('tags') // {[key: string]: string}
const tenantId = pulumi.output(authorization.getClientConfig()).tenantId

const appiKind = config.get('appiKind') || 'web'
const appiType = config.get('appiType') || 'web'

const kvSku: keyvault.SkuName = config.get('kvSku') || 'standard'
const kvGroupName = config.require('kvGroupName')
const kvObjectId = pulumi.output(azuread.getGroup({ displayName: kvGroupName })).objectId
const kvGroupKeyPermissions: undefined = config.getObject('kvGroupKeyPermissions') // string[]
const kvGroupSecretPermissions: undefined = config.getObject('kvGroupSecretPermissions') // string[]
const kvGroupCertPermissions: undefined = config.getObject('kvGroupCertPermissions') // string[]

const rg = new resources.ResourceGroup('rg', {
    resourceGroupName: `rg-${prefix}-001`,
    tags: tags
})

const appi = new insights.Component('appi', {
    resourceName: `appi-${prefix}-001`,
    resourceGroupName: rg.name,
    tags: tags,
    kind: appiKind,
    applicationType: appiType
})

const kv = new keyvault.Vault('kv', {
    vaultName: `kv-${prefix}-001`,
    resourceGroupName: rg.name,
    tags: tags,
    properties: {
        tenantId: tenantId,
        sku: {
            family: 'A',
            name: kvSku
        },
        accessPolicies: [
            {
                tenantId: tenantId,
                objectId: kvObjectId,
                permissions: {
                    keys: kvGroupKeyPermissions,
                    secrets: kvGroupSecretPermissions,
                    certificates: kvGroupCertPermissions
                }
            }
        ]
    }
})

new keyvault.Secret('secret', {
    secretName: 'appi-connectionString',
    vaultName: kv.name,
    resourceGroupName: rg.name,
    tags: tags,
    properties: {
        value: appi.connectionString
    }
})

export const tmp = prefixStripped
