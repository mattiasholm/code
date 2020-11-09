# Cheat Sheet - Terraform

## Official docs:
https://learn.hashicorp.com/collections/terraform/azure-get-started

## Show version:
```shell
terraform --version
terraform -v
```

## Contextual help:
```shell
terraform [<subcommand>] --help
terraform [<subcommand>] -h
```

## Enable tab completion:
```shell
terraform -install-autocomplete
```

<br><br>

## Authenticate to Azure (using Azure CLI):
```shell
az login
```

## Select Azure context (using Azure CLI):
```shell
az account set --subscription <subscription-id>
```

<br><br>

## Initialize a Terraform directory
```shell
terraform init
```

## Plan a Terraform configuration:
```shell
terraform plan
```

## Apply a Terraform configuration:
```shell
terraform apply
```

## Inspect Terraform state:
```shell
terraform show
```