# Cheat Sheet - Tfsec

<br>

## GitHub repository:
https://github.com/aquasecurity/tfsec

<br><br>

## Show version:
```shell
tfsec --version
tfsec -v
```

## Contextual help:
```shell
tfsec --help
tfsec -h
```

<br><br>

## Run Tfsec in working directory:
```shell
tfsec
```

## Run Tfsec in a specific directory:
```shell
tfsec <path>
```

## Run only specific checks (comma-separated):
```shell
tfsec --include <id>
tfsec -i <id>
```

## Exclude specific checks (comma-separated):
```shell
tfsec --exclude <id>
tfsec -e <id>
```

## Suppress errors even if checks fail:
```shell
tfsec --soft-fail
tfsec -s
```

<br><br>

## Output in compact format:
```shell
tfsec --concise-output
```

## Output statistics in table format:
```shell
tfsec --run-statistics
```

## Output passed checks too:
```shell
tfsec --include-passed
```