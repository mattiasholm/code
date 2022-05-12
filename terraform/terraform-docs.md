# Cheat Sheet - terraform-docs

<br>

## GitHub repository:
https://github.com/terraform-docs/terraform-docs/

<br><br>

## Show version:
```shell
terraform-docs version
terraform-docs --version
terraform-docs -v
```

## Contextual help:
```shell
terraform-docs --help
terraform-docs -h
```

<br><br>

## Generate Markdown from Terraform module in working directory:
```shell
terraform-docs markdown .
```

## Generate Terraform variables from Terraform module in working directory:
```shell
terraform-docs tfvars hcl .
```