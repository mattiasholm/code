# Cheat Sheet

<br>

## Official docs:
https://www.pulumi.com/docs/reference/cli/

<br><br>

## Contextual syntax help:
```bash
pulumi [subcommand] --help
pulumi [subcommand] -h
```

<br><br>

## Log in to managed Pulumi service backend:
```bash
pulumi login
```

## Log in to self-managed backend locally:
```bash
pulumi login --local
pulumi login -l
```

## Log in to self-managed backend in cloud storage:
```bash
pulumi login --cloud-url
pulumi login --c
```

## Log out:
```bash
pulumi logout
```

<br><br>

## Create new Pulumi project in working directory, accept default values:
```bash
pulumi new [template] --yes
pulumi new [template] -y
```

<br><br>

## Deploy current stack:
```bash
pulumi up
```

## Deploy current stack, skip confirmation prompt:
```bash
pulumi up --yes
pulumi up --y
```

## Previw deploy and list any changes:
```bash
pulumi preview
```

## Destroy current stack:
```bash
pulumi destroy
```

<br><br>

## List stacks:
```bash
pulumi stack ls
```

## Switch the current workspace to a specific stack:
```bash
pulumi stack select [stack-name]
```

## Create an empty stack:
```bash
pulumi stack init [stack-name]
```

## Rename an existing stack:
```bash
pulumi stack rename [new-name]
```

## Remove an existing stack:
```bash
pulumi stack rm [stack-name]
```

<br><br>

## List configuration values for a specific stack:
```bash
pulumi config
```

## List value of a specific configuration key for a specific stack:
```bash
pulumi config get [key-name]
```

## Set value of a specific configuration key:
```bash
pulumi config set [key-name] [value]
```

## Remove a specific configuration key:
```bash
pulumi config rm [key-name]
```

## Update the local configuration based on the most recent deployment of the stack:
```bash
pulumi config refresh
```

<br><br>

## Compares the current stack's resource state with the state known to exist in the actual cloud provider and modifies the stack's state accordingly:
```bash
pulumi refresh
```

<br><br>

## List history of all updates to a stack:
```bash
pulumi history
```

<br><br>

## TESTKÖR SAMTLIGA OVANSTÅENDE + FYLL PÅ MED FLER FRÅN DOCS!