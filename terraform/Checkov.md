# Cheat Sheet - Checkov

<br>

## GitHub repository:
https://github.com/bridgecrewio/checkov

<br><br>

## Show version:
```shell
checkov --version
checkov -v
```

## Contextual help:
```shell
checkov --help
checkov -h
```

<br><br>

## List all checks:
```shell
checkov --list
checkov -l
```

<br><br>

## Run Checkov in a specific directory:
```shell
checkov --directory <path>
checkov -d <path>
```

## Run Checkov on a specific file:
```shell
checkov --file <filename>
checkov -f <filename>
```

## Run only specific checks (comma-separated):
```shell
checkov <subcommand> --check <id>
checkov <subcommand> -c <id>
```

## Exclude specific checks (comma-separated):
```shell
checkov <subcommand> --skip-check <id>
```

<br><br>

## Output in compact format:
```shell
checkov <subcommand> --compact
```

## Output failed checks only:
```shell
checkov <subcommand> --quiet
```