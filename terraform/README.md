# Cheat Sheet - Terraform

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

## Initialize Terraform:
```shell
terraform init
```

## Upgrade Terraform provider versions:
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

## Run Terraform tests:
```shell
terraform test
```

## Run Terraform tests with verbose output:
```shell
terraform test -verbose
```

## Create a Terraform execution plan:
```shell
terraform plan
```

## Save a Terraform execution plan to file:
```shell
terraform plan --out=<plan-name>
```

## Plan a replace of a specific resource:
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

## Apply a specific resource:
```shell
terraform apply --target <terraform-resource-type>.<symbolic-name>
```

## Replace a specific resource:
```shell
terraform apply --replace <terraform-resource-type>.<symbolic-name>
```

<br><br>

## Mark a resource as tainted:
```shell
terraform taint <terraform-resource-type>.<symbolic-name>
```

## Unmark a resource as tainted:
```shell
terraform untaint <terraform-resource-type>.<symbolic-name>
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
terraform show --json
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

## Force-unlock the Terraform state:
```shell
terraform force-unlock <lock-id>
```

<br><br>

## Plan a Terraform destroy:
```shell
terraform plan --destroy
```

## Destroy all resources:
```shell
terraform destroy 
```

## Destroy all resources without requiring interactive approval:
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
terraform graph | dot -Tpng > graph.png
```