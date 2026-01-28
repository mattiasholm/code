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

## Decompile a JSON parameter file into a Bicep parameter file:
```shell
az bicep decompile-params --file main.parameters.json
az bicep decompile-params -f main.parameters.json
```

<br><br>

## Formats a Bicep file:
```shell
az bicep format --file main.bicep
az bicep format -f main.bicep
```

## Lints a Bicep file:
```shell
az bicep lint --file main.bicep
az bicep lint -f main.bicep
```

<br><br>

## Open an interactive Bicep console for evaluating expressions:
```shell
bicep console
```

## Generate a list of predicted resources for comparing changes:
```shell
bicep snapshot main.bicepparam
```