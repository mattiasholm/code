# Cheat Sheet - Infracost

<br>

## GitHub repository:
https://github.com/infracost/infracost

<br><br>

## Show version:
```shell
infracost --version
infracost -v
```

## Contextual help:
```shell
infracost help [<subcommand>]
infracost [<subcommand>] --help
infracost [<subcommand>] -h
```

<br><br>

## Get cost breakdown for Terraform module in working directory:
```shell
infracost breakdown --path .
```

## Create a baseline based on current cost:
```shell
infracost breakdown --path . --format json --out-file infracost-base.json
```

## Compare current cost to an existing baseline:
```shell
infracost diff --path . --compare-to infracost-base.json
```

## Get cost breakdown for an existing baseline:
```shell
infracost output --path infracost-base.json
```

<br><br>

## Acquire an API key:
```shell
infracost register
```

## Show API key:
```shell
infracost configure get api_key
```

## Show API endpoint:
```shell
infracost configure get pricing_api_endpoint
```

## Set preferred currency to SEK:
```shell
infracost configure set currency SEK
```