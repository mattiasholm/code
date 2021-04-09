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

## Build a Bicep file and output it to the working directory:
```shell
az bicep build --files <file-name>
az bicep build -f <file-name>
```

## Build a Bicep file and output it to standard output:
```shell
az bicep build --files <file-name> --stdout
az bicep build -f <file-name> --stdout
```

## Decompile an ARM template and output it to the working directory:
```shell
az bicep decompile --files <file-name>
az bicep decompile -f <file-name>
```