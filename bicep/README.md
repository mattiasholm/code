# Cheat Sheet - Bicep CLI

<br>

## GitHub repository:
https://github.com/Azure/bicep

## Real-time online compiler (Bicep Playground):
https://azure.github.io/bicep/

<br><br>

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

## Contextual help:
```shell
az bicep [<subcommand>] --help
az bicep [<subcommand>] -h
```

<br><br>

## Build a Bicep file into an ARM template:
```shell
az bicep build --file main.bicep
az bicep build -f main.bicep
```

## Decompile an ARM template into a Bicep file:
```shell
az bicep decompile --file main.json
az bicep decompile -f main.json
```

## Generate a parameter file for a Bicep file:
```shell
az bicep generate-params --file main.bicep
az bicep generate-params -f main.bicep
```

## Open an interactive Bicep console for evaluating expressions:
```shell
bicep console
```

## Generate a list of predicted resources for comparing changes:
```shell
bicep snapshot main.bicepparam
```