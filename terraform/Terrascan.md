# Cheat Sheet - Terrascan

<br>

## GitHub repository:
https://github.com/accurics/terrascan

<br><br>

## Show version:
```shell
terrascan version
```

## Contextual help:
```shell
terrascan --help
terrascan -h
```

<br><br>

## Initialize Terrascan:
```shell
terrascan init
```

<br><br>

## Run Terrascan in working directory:
```shell
terrascan scan
```

## Run Terrascan in a specific directory:
```shell
terrascan scan --iac-dir <path>
terrascan scan -d <path>
```

## Run Terrascan on a specific file:
```shell
terrascan scan --iac-file <filename>
terrascan scan -f <filename>
```

## Run only specific checks (comma-separated):
```shell
terrascan scan --scan-rules <id>
```

## Exclude specific checks (comma-separated):
```shell
terrascan scan --skip-rules <id>
```

<br><br>

## Output in verbose format:
```shell
terrascan scan --verbose
terrascan scan -v
```

## Output passed checks too:
```shell
terrascan scan --show-passed
```