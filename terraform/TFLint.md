# Cheat Sheet - TFLint

<br>

## GitHub repository:
https://github.com/terraform-linters/tflint

<br><br>

## Show version:
```shell
tflint --version
tflint -v
```

## Contextual help:
```shell
tflint --help
tflint -h
```

<br><br>

## Initialize TFLint:
```shell
tflint --init
```

<br><br>

## Run TFLint:
```shell
tflint
```

## Run TFLint and output in compact format:
```shell
tflint --format compact
tflint -f compact
```

## Run TFLint and output in JSON format:
```shell
tflint --format json
tflint -f json
```

## Run TFLint with a different config file than `.tflint.hcl`:
```shell
tflint --config <filename>
tflint -c <filename>
```