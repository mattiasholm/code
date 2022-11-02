# Cheat Sheet - act

<br>

## GitHub repository:
https://github.com/nektos/act

## Show version:
```shell
act --version
```

## Show help:
```shell
act --help
act -h
```

<br><br>

## List all workflows:
```shell
act --list
act -l
```

## List workflows that trigger on a specific event:
```shell
act <event> --list
act <event> -l
```

## List a specific workflow:
```shell
act --workflows <path> --list
act -W <path> -l
```

## List a specific job:
```shell
act --job <id> --list
act -j <id> -l
```

<br><br>

## Run all workflows:
```shell
act
```

## Run workflows that trigger on a specific event:
```shell
act <event>
```

## Run a specific workflow:
```shell
act --workflows <path>
act -W <path>
```

## Run a specific job:
```shell
act --job <id>
act -j <id>
```

<br><br>

## Automatically detect event to trigger workflows on:
```shell
act --detect-event
```

## Dry-run workflows:
```shell
act --dryrun
act -n
```

## Run workflows with verbose output:
```shell
act --verbose
act -v
```

## Visualize workflows:
```shell
act --graph
act -g
```

<br><br>

## Configure Docker image to run workflows on:
```shell
vim ~/.actrc

--platform <platform>=<docker-image>
-P <platform>=<docker-image>
```

## Configure environment variables available in workflows:
```shell
vim .env

<key>=<value>
```

## Configure secrets available in workflows:
```shell
vim .secrets

<key>=<value>
```