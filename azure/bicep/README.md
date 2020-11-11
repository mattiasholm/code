# Cheat Sheet - Azure Bicep

<br>

## GitHub repository:
https://github.com/Azure/bicep

## Real-time online compiler (Bicep Playground):
https://bicepdemo.z22.web.core.windows.net/

## Install Azure Bicep on macOS:
```shell
brew tap azure/bicep https://github.com/azure/bicep

brew install azure/bicep/bicep
```

## Install VSCode extension on macOS:
```shell
curl -Lo vscode-bicep.vsix https://github.com/Azure/bicep/releases/latest/download/vscode-bicep.vsix

code --install-extension vscode-bicep.vsix

rm vscode-bicep.vsix
```

<br><br>

## Show version:
```shell
bicep --version
bicep -v
```

## Contextual help:
```shell
bicep [<subcommand>] --help
bicep [<subcommand>] -h
```

<br><br>

## Build a specific template:
```shell
bicep build <file-name>
```

## Build all templates in working directory:
```shell
bicep build *.bicep
```



<!-- Komplettera med modules när släppt:

Lägg till param attributes:

 param virtualMachineAdminUsername string

  param virtualMachineAdminPassword string {
    secure: true
  }
  
  param virtualMachineSize string {
    allowed: [
      'Standard_D2s_v3'
      'Standard_D4s_v3'
      'Standard_D8s_v3'
    ]
    default: 'Standard_D8s_v3'
  }


https://github.com/Azure/bicep/blob/main/docs/spec/modules.md

Komplettera med loops när släppt:
https://github.com/Azure/bicep/blob/main/docs/spec/loops.md

??? Terraform-esque deployments ???
bicep build
bicep plan
bicep apply
bicep destroy
??? Om ej släpps officiellt, kanske värt att skapa egna alias för detta ???

Eventuellt lägga till cheat sheet för expressions etc??
 -->