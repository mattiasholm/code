# Cheat Sheet - Terraform

## Official docs:
https://www.terraform.io/docs/cli-index.html

https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs

<br>

## Azure tutorial:
https://learn.hashicorp.com/collections/terraform/azure-get-started

<br>

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

## Authenticate to Terraform Cloud (if using remote backend):
```shell
terraform login
```

## Authenticate to Azure (using Azure CLI):
```shell
az login
```

## Select Azure context (using Azure CLI):
```shell
az account set --subscription <subscription-id>
```

<br><br>

## Initialize working directory containing Terraform configuration files:
```shell
terraform init
```

<br><br>

## Validate Terraform configuration files:
```shell
terraform validate
```

## Create a Terraform execution plan:
```shell
terraform plan
```

## Save a Terraform execution plan to file:
```shell
terraform plan -out=<plan-name>
```

<br><br>

## Apply a Terraform configuration:
```shell
terraform apply
```

## Apply a Terraform configuration without requiring interactive approval:
```shell
terraform apply --auto-approve
```

## Apply a Terraform configuration from a previously saved plan:
```shell
terraform apply -input=false <plan-name>
```

## Apply a Terraform configuration and pass variables inline:
```shell
terraform apply -var '<variable-name>=<value>'
```

## Apply a Terraform configuration and pass variables from file:
```shell
terraform apply -var-file='<path>'
```

<br><br>

## Show all deployment outputs:
```shell
terraform output
```

## Show a specific deployment output:
```shell
terraform output <output-name>
```

## Show current Terraform state:
```shell
terraform show
```

## Show current Terraform state in `JSON` format:
```shell
terraform show --json | jq
```

## Reconcile the state Terraform knows about with the real-world infrastructure:
```shell
terraform refresh
```

## List all resources created with Terraform:
```shell
terraform state list
```

<br><br>

## Destroy Terraform-managed infrastructure:
```shell
terraform destroy 
```

## Destroy Terraform-managed infrastructure without requiring interactive approval::
```shell
terraform destroy --auto-approve
```

<br><br>

## Import an existing Azure resource into Terraform:
```shell
terraform import <terraform-resource-type>.<resource-label> <azure-resource-id>
```

<br><br>

## Open an interactive Terraform console for evaluating expressions:
```shell
terraform console
```

<!-- 
Komplettera med fler subcommands allt eftersom:
https://www.terraform.io/docs/commands/index.html

Eventuellt lägga till cheat sheet för expressions etc??
https://www.terraform.io/docs/configuration/expressions.html

"terraform.tfvars" or any ".auto.tfvars"
-->