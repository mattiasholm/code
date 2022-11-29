[![Azure Bicep](https://github.com/mattiasholm/code/actions/workflows/azure-bicep.yml/badge.svg)](https://github.com/mattiasholm/code/actions/workflows/azure-bicep.yml)

# Cheat Sheet - Bicep CLI

<br>

## GitHub repository:
https://github.com/Azure/bicep

## Real-time online compiler (Bicep Playground):
https://bicepdemo.z22.web.core.windows.net/

<br><br>

## Install VSCode extension:
```shell
code --install-extension ms-azuretools.vscode-bicep
```

## Install Bicep CLI:
```shell
az bicep install
```

## Upgrade Bicep CLI:
```shell
az bicep upgrade
```

## Show version:
```shell
az bicep version
```

## List available versions:
```shell
az bicep list-versions
```

## Contextual help:
```shell
az bicep [<subcommand>] --help
az bicep [<subcommand>] -h
```

<br><br>

## Build a Bicep file into an ARM template:
```shell
az bicep build --file <filename>
az bicep build -f <filename>
```

## Decompile an ARM template into a Bicep file:
```shell
az bicep decompile --file <filename>
az bicep decompile -f <filename>
```

## Generate a parameter file for a Bicep file:
```shell
az bicep generate-params --file <filename>
az bicep generate-params -f <filename>
```