param name string
param properties object = {}

resource app 'Microsoft.Web/sites@2020-12-01' existing = {
      name: name
}

resource config 'Microsoft.Web/sites/config@2020-12-01' = {
  name: 'appsettings'
  parent: app
  properties: properties
}
