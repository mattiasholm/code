import * as pulumi from '@pulumi/pulumi'
import * as azure from '@pulumi/azure-native'

const config = new pulumi.Config

const prefix = config.require('prefix')
const tags: undefined = config.getObject('tags')

// const planKind = config.get('planKind') || 'linux'
// const planSku = config.get('planSku') || 'B1'
// const planCapacity = config.getNumber('planCapacity') || 1
// const planReserved = planKind == 'linux' ? true : false

const rg = new azure.resources.ResourceGroup('rg', {
    resourceGroupName: `rg-${prefix}-001`,
    tags: tags
})

// const plan = new azure.web.AppServicePlan('plan', {
//     name: `plan-${prefix}-001`,
//     resourceGroupName: rg.name,
//     tags: tags,
//     kind: planKind,
//     sku: {
//         name: planSku,
//         capacity: planCapacity
//     },
//     reserved: planReserved
// })
