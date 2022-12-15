[![Azure Terraform](https://github.com/mattiasholm/code/actions/workflows/azure-terraform.yml/badge.svg)](https://github.com/mattiasholm/code/actions/workflows/azure-terraform.yml)

# Cheat Sheet - Terraform

<br>

## Official docs:
https://www.terraform.io/docs/cli-index.html

https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs

<br><br>

## Azure tutorial:
https://learn.hashicorp.com/collections/terraform/azure-get-started

<br><br>

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
terraform --install-autocomplete
```

<br><br>

## Log in to Terraform Cloud (if using remote backend):
```shell
terraform login
```

## Log out from Terraform Cloud (if using remote backend):
```shell
terraform logout
```

<br><br>

## Initialize Terraform backend:
```shell
terraform init
```

## Upgrade Terraform backend to a newer version:
```shell
terraform init --upgrade
```

<br><br>

## Validate Terraform configuration files:
```shell
terraform validate
```

## Check formatting of Terraform configuration files:
```shell
terraform fmt --check
```

## Automatically fix formatting of Terraform configuration files:
```shell
terraform fmt
```

## Create a Terraform execution plan:
```shell
terraform plan
```

## Save a Terraform execution plan to file:
```shell
terraform plan --out=<plan-name>
```

## Plan a replace of a specific resource managed by Terraform:
```shell
terraform plan --replace <terraform-resource-type>.<symbolic-name>
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
terraform apply --input=false <plan-name>
```

## Apply a Terraform configuration and pass variables inline:
```shell
terraform apply --var '<variable-name>=<value>'
```

## Apply a Terraform configuration and pass variables from file:
```shell
terraform apply --var-file='<path>'
```

## Replace a specific resource managed by Terraform:
```shell
terraform apply --replace <terraform-resource-type>.<symbolic-name>
```

<br><br>

## Create a new Terraform workspace:
```shell
terraform workspace new <name>
```

## List available Terraform workspaces:
```shell
terraform workspace list
```

## Show currently selected Terraform workspace:
```shell
terraform workspace show
```

## Select Terraform workspace:
```shell
terraform workspace select <name>
```
## Delete a Terraform workspace:
```shell
terraform workspace delete <name>
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

## List configured Terraform providers:
```shell
terraform providers
```

## Show current Terraform state:
```shell
terraform show
```

## Show current Terraform state in `JSON` format:
```shell
terraform show --json | jq
```

## Refresh the Terraform state to match the actual resources:
```shell
terraform refresh
```

## List all resources in Terraform state:
```shell
terraform state list
```

## Show a specific resource in Terraform state:
```shell
terraform state show <terraform-resource-type>.<symbolic-name>
```

## Rename a specific resource in Terraform state:
```shell
terraform state mv <old-name> <new-name>
```

## Remove a specific resource from Terraform state:
```shell
terraform state rm <terraform-resource-type>.<symbolic-name>
```

## Remove all resources from Terraform state:
```shell
terraform state rm $(terraform state list)
```

<br><br>

## Plan a Terraform destroy:
```shell
terraform plan --destroy
```

## Destroy all resources managed by Terraform:
```shell
terraform destroy 
```

## Destroy all resources managed by Terraform without requiring interactive approval:
```shell
terraform destroy --auto-approve
```

<br><br>

## Import an existing Azure resource into Terraform:
```shell
terraform import <terraform-resource-type>.<symbolic-name> <azure-resource-id>
```

<br><br>

## Open an interactive Terraform console for evaluating expressions:
```shell
terraform console
```

<br><br>

## Generate a visualization of a Terraform configuration:
```shell
terraform graph | dot -Tsvg > graph.svg
```