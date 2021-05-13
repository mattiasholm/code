param name string
param properties object = {}

resource app 'Microsoft.Web/sites@2020-12-01' existing = {
  name: name

  resource config 'config' = {
    name: 'appsettings'
    properties: properties
  }
}
