import * as pulumi from '@pulumi/pulumi'
import * as azure from '@pulumi/azure-native'

const config = new pulumi.Config

const prefix = config.require('prefix')
const tags: undefined = config.getObject('tags')

const appiKind = config.get('appiKind') || 'web'
const appiType = config.get('appiType') || 'web'

const rg = new azure.resources.ResourceGroup('rg', {
    resourceGroupName: `rg-${prefix}-001`,
    tags: tags
})

const appi = new azure.insights.Component('appi', {
    resourceName: `appi-${prefix}-001`,
    resourceGroupName: rg.name,
    tags: tags,
    kind: appiKind,
    applicationType: appiType
});
