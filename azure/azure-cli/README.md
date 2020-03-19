# Cheat Sheet - Azure CLI

<br>

## List all required endpoints for Azure Cloud:
```shell
az cloud show --query endpoints
```

## Show version of Azure CLI:
```shell
az version
```

## Watch current ARM deployments in a specific resource group:
```shell
az group deployment watch --resource-group <rg-name>
```

## List available extensions:
```shell
az extension list-available
```

## Show only a specific property when listing:
```shell
az <subcommand> list --query [].<property>
```

## Show only a specific property when listing:
```shell
az rest --method <method> --uri <uri> --body <body>

az rest -m <method> -u <uri> -b <body>
```

<br><br>

## Get AKS credentials (in order to run kubectl):
```shell
az aks get-credentials --name <cluster-name> --resource-group <rg-name>

az aks get-credentials -n <cluster-name> -g <rg-name>
```

<!-- 
## FYLL PÅ! Kolla igenom om fler vettiga extensions! az aks användbara! Även allt som rör deploy!
-->