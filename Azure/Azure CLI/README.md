# Cheat Sheet

<br>

## Watch current ARM deployments in a specific resource group:
```shell
az group deployment watch --resource-group [rg-name]
```

## List available extensions:
```shell
az extension list-available
```

## Show only a specific property when listing:
```shell
az <subcommand> list --query [].<property>
```

<br>

<!-- 
## FYLL PÅ! Kolla igenom om fler vettiga extensions! az aks användbara! Även allt som rör deploy!
-->