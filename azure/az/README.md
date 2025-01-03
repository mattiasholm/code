# Cheat Sheet - Azure CLI

<br>

## Show version:
```shell
az version
az --version
az -v
```

## Upgrade Azure CLI and extensions:
```shell
az upgrade
```

## Contextual help:
```shell
az [<subcommand>] --help
az [<subcommand>] -h
```

## Show examples of a specific subcommand:
```shell
az find "az [<subcommand>]"
```

<br><br>

## Show currently signed-in account:
```shell
az ad signed-in-user show --query userPrincipalName
```

## Log in to Azure:
```shell
az login
```

## Log out from Azure:
```shell
az logout
```

<br><br>

## List current subscription:
```shell
az account show
```

## List all available subscriptions:
```shell
az account list --output table
```

## Switch context to a different subscription:
```shell
az account set --subscription <subscription-id>
```

## Obtain a JWT token for Azure:
```shell
az account get-access-token --query accessToken --output tsv
```

## Obtain a JWT token for Microsoft Graph:
```shell
az account get-access-token --scope https://graph.microsoft.com/.default --query accessToken --output tsv
```

<br><br>

## List all required endpoints for Azure Cloud:
```shell
az cloud show --query endpoints
```

## List available extensions:
```shell
az extension list-available
```

## Show only a specific property when listing:
```shell
az <subcommand> list --query [].<property>
```

## Make a custom REST API call to Azure Resource Manager (ARM):
```shell
az rest --method <method> --uri <uri> --body <body>
az rest -m <method> -u <uri> -b <body>
```

## Get AKS credentials (in order to run kubectl):
```shell
az aks get-credentials --name <cluster-name> --resource-group <rg-name>
az aks get-credentials -n <cluster-name> -g <rg-name>
```

## Create Azure AD service principal:
```shell
az ad sp create-for-rbac --name <name> --years <years> --role <role> --scopes <scope>
```

## Reset secret for an existing Azure AD service principal:
```shell
az ad sp create-for-rbac --name <name>
```