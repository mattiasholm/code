[![Azure ARM](https://github.com/mattiasholm/code/actions/workflows/azure-arm.yml/badge.svg)](https://github.com/mattiasholm/code/actions/workflows/azure-arm.yml)

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fmattiasholm%2Fcode%2Fmain%2Fazure%2Farm%2Fmain.json)

# Cheat Sheet - ARM

<br>

## Validate a specific ARM template:
```shell
az deployment group validate --resource-group <rg-name> --template-file <filename>
```

## Run a what-if operation that compares a specific ARM template to the actual current state in Azure:
```shell
az deployment group what-if --resource-group <rg-name> --template-file <filename>
```

## Deploy a specific ARM template to Azure:
```shell
az deployment group create --resource-group <rg-name> --template-file <filename>
```

<br><br>

## Watch current ARM deployments in a specific resource group:
```shell
az group deployment watch --resource-group <rg-name>
```

## Display inner errors occuring during ARM template validation procedure (PreflightValidationCheckFailed):
```shell
az monitor activity-log list --correlation-id <tracking-id>
```

<br><br>
