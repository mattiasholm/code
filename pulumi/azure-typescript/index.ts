import * as pulumi from '@pulumi/pulumi'
import * as resources from '@pulumi/azure-native/resources'

const config = new pulumi.Config

const prefix = config.require('prefix')
const tags: undefined = config.getObject('tags')

const rg = new resources.ResourceGroup(
    'rg', {
    resourceGroupName: `rg-${prefix}-001`,
    tags: tags
})
