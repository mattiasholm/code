# Cheat Sheet - Pulumi

<br>

## Official docs:
https://www.pulumi.com/docs/reference/cli/

<br><br>

## Contextual syntax help:
```shell
pulumi [<subcommand>] --help
pulumi [<subcommand>] -h
```

## Show version:
```shell
pulumi version
```

<br><br>

## Log in to managed Pulumi service backend:
```shell
pulumi login
```

## Log in to self-managed backend locally:
```shell
pulumi login --local
pulumi login -l
```

## Log in to self-managed backend in cloud storage:
```shell
pulumi login --cloud-url
pulumi login --c
```

## Display currently logged in user:
```shell
pulumi whoami
```

## Log out:
```shell
pulumi logout
```

<br><br>

## Create new Pulumi project in working directory based on a specific template, accepting default values:
```shell
pulumi new <template> --yes
pulumi new <template> -y
```

<br><br>

## Previw changes before deploying:
```shell
pulumi preview
```

## Deploy current stack:
```shell
pulumi up
```

## Deploy current stack, skip confirmation prompt:
```shell
pulumi up --yes
pulumi up --y
```

## Destroy current stack:
```shell
pulumi destroy
```

## Destroy current stack, skip confirmation prompt:
```shell
pulumi destroy --yes
pulumi destroy -y
```

<br><br>

## List current stack:
```shell
pulumi stack
```

## List all stacks:
```shell
pulumi stack ls
```

## Show all outputs from current stack:
```shell
pulumi stack output
```

## Show a specific output from current stack:
```shell
pulumi stack output <name>
```

## Create a new stack:
```shell
pulumi stack init <name>
```

## Switch the current workspace to a specific stack:
```shell
pulumi stack select <name>
```

## Rename the current stack:
```shell
pulumi stack rename <new-name>
```

## Remove the current stack:
```shell
pulumi stack rm
```

## Remove the current stack, skip confirmation prompt:
```shell
pulumi stack rm --yes
pulumi stack rm -y
```

## Remove a specific stack:
```shell
pulumi stack rm <name>
```

<br><br>

## List configuration values for a specific stack:
```shell
pulumi config
```

## List value of a specific configuration key for a specific stack:
```shell
pulumi config get <key-name>
```

## Set value of a specific configuration key:
```shell
pulumi config set <key-name> <value>
```

## Set value of a specific configuration key and mark it as secret (as opposed to being stored as plain text):
```shell
pulumi config set <key-name> <value> --secret
```

## Remove a specific configuration key:
```shell
pulumi config rm <key-name>
```

<br><br>

## Refresh the current stack's state, based on the actual state in the cloud:
```shell
pulumi refresh
```

## Refresh the current stack's state, based on the actual state in the cloud, skip confirmation prompt:
```shell
pulumi refresh --yes
pulumi refresh -y
```

<br><br>

## Show history of updates to current stack:
```shell
pulumi stack history
```