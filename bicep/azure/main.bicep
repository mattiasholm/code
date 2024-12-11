targetScope = 'subscription'

param config {
  tags: {
    Application: string
    Company: string
    *: string
  }
  logRetention: int?
  pdnszName: string
  pipLabels: string[]?
  stCount: int?
  stSku: string?
  vnetCidr: string
  snetCount: int
  snetSize: int
  objectId: string
  roleId: string
}

param location string = deployment().location

func name(type string, config object, instance int) string =>
  '${type}-${toLower('${config.tags.Company}-${config.tags.Application}')}-${padLeft(instance, 2, '0')}'

func strip(name string) string => replace(name, '-', '')

resource rg 'Microsoft.Resources/resourceGroups@2024-07-01' = {
  name: name('rg', config, 1)
  location: location
  tags: config.tags
}

module log 'modules/log.bicep' = if (contains(config, 'logRetention')) {
  name: 'log'
  scope: rg
  params: {
    name: name('log', config, 1)
    location: location
    retentionInDays: config.?logRetention
    kvName: name('kv', config, 1)
  }
  dependsOn: [
    kv
  ]
}

module kv 'modules/kv.bicep' = {
  name: 'kv'
  scope: rg
  params: {
    name: name('kv', config, 1)
    location: location
  }
}

module pdnsz 'modules/pdnsz.bicep' = {
  name: 'pdnsz'
  scope: rg
  params: {
    name: config.pdnszName
    vnetName: name('vnet', config, 1)
    vnetId: vnet.outputs.id
    cnames: [
      for (label, i) in config.?pipLabels ?? []: {
        name: label
        cname: pip[i].outputs.fqdn
      }
    ]
  }
}

module pip 'modules/pip.bicep' = [
  for (label, i) in config.?pipLabels ?? []: {
    name: 'pip_${label}'
    scope: rg
    params: {
      name: name('pip', config, i + 1)
      location: location
      domainNameLabel: name('pip', config, i + 1)
    }
  }
]

module st 'modules/st.bicep' = [
  for i in range(0, config.?stCount ?? 0): {
    name: 'st_${i}'
    scope: rg
    params: {
      name: strip(name('st', config, i + 1))
      location: location
      sku: config.?stSku
      containers: [
        'data'
      ]
    }
  }
]

module vnet 'modules/vnet.bicep' = {
  name: 'vnet'
  scope: rg
  params: {
    name: name('vnet', config, 1)
    location: location
    addressPrefixes: [
      config.vnetCidr
    ]
    subnets: [
      for i in range(0, config.snetCount): {
        name: name('snet', config, i + 1)
        addressPrefix: cidrSubnet(config.vnetCidr, config.snetSize, i)
      }
    ]
  }
}

module rbac 'modules/rbac.bicep' = {
  name: 'rbac'
  scope: rg
  params: {
    objectId: config.objectId
    roleId: config.roleId
  }
}

output kvUrl string = kv.outputs.vaultUri

output cnameUrl object = toObject(
  config.?pipLabels ?? [],
  label => label,
  label =>
    'https://${substring(pdnsz.outputs.fqdn[indexOf(config.pipLabels!, label)], 0, length(pdnsz.outputs.fqdn[indexOf(config.pipLabels!, label)]) - 1)}/'
)

output stUrl object[] = [for i in range(0, config.?stCount ?? 0): st[i].outputs.primaryEndpoints]

output subnets string[] = map(vnet.outputs.subnets, snet => snet.properties.addressPrefix)
