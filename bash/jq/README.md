# Cheat Sheet - jq

<br>

## Parse file as is just to get syntax highlighting:
```shell
cat <json-file> | jq
```

## Get all JSON object under a specific key (1 level down):
```shell
cat <json-file> | jq ".[\"<key-name>\"]"
```


## Use `jq` recursively to get JSON objects of a sub-key (2 levels down):
```shell
cat <json-file> | jq ".[\"<key-name>\"]" | jq ".[\"<sub-key>\"]"
```

## Convert JSON objects to key-value pairs (e.g. before sourcing them in a shell script):
```shell
cat <json-file> | jq ".[\"<key-name>\"]" | jq -r 'to_entries|map("\(.key)=\"\(.value|tostring)\"")|.[]'
```

<br><br>

## Output raw strings, instead of JSON:
```shell
jq -r <...>
```