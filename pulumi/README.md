# Cheat Sheet - Pulumi

<br>

## Official docs:
https://www.pulumi.com/docs/reference/cli/

<br><br>

## Contextual syntax help:
```shell
pulumi [subcommand] --help
pulumi [subcommand] -h
```

## Create an alias for pulumi:
```shell
alias p='pulumi'
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

## Create new Pulumi project in working directory based on the specified template, accept default values:
```shell
pulumi new [template] --yes
pulumi new [template] -y
```

## Prerequisites:

### `Python`:

#### First-time installation of virtual environment:
```shell
virtualenv -p python3 venv
source venv/bin/activate
pip3 install -r requirements.txt
```

#### Activate virtual environment after reopening shell:
```shell
source venv/bin/activate
```

<br><br>

## Deploy current stack:
```shell
pulumi up
```

## Deploy current stack, skip confirmation prompt:
```shell
pulumi up --yes
pulumi up --y
```

## Previw changes before deploying:
```shell
pulumi preview
```

## Destroy current stack:
```shell
pulumi destroy
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

## Switch the current workspace to a specific stack:
```shell
pulumi stack select [stack-name]
```

## Create an empty stack:
```shell
pulumi stack init [stack-name]
```

## Rename an existing stack:
```shell
pulumi stack rename [new-name]
```

## Remove an existing stack:
```shell
pulumi stack rm [stack-name]
```

<br><br>

## List configuration values for a specific stack:
```shell
pulumi config
```

## List value of a specific configuration key for a specific stack:
```shell
pulumi config get [key-name]
```

## Set value of a specific configuration key:
```shell
pulumi config set [key-name] [value]
```

## Set value of a specific configuration key and mark it as secret (as opposed to being stored as plain text):
```shell
pulumi config set [key-name] [value] --secret
```

## Remove a specific configuration key:
```shell
pulumi config rm [key-name]
```

## Update the local configuration based on the most recent deployment of the stack:
```shell
pulumi config refresh
```

<br><br>

## Compares the current stack's resource state with the state known to exist in the actual cloud provider and modifies the stack's state accordingly:
```shell
pulumi refresh
```

<br><br>

## List history of all updates to a stack:
```shell
pulumi history
```