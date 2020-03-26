# Cheat Sheet - jq

<br>

## Parse a JSON file as is in order to get syntax highlighting:
```shell
cat <json-file> | jq
```

## Get all JSON objects under a specific key at the top level:
```shell
cat <json-file> | jq .<key-name>
```

## Get all JSON objects under a specific key one level down:
```shell
cat <json-file> | jq .<key-name>.<sub-key>
cat <json-file> | jq .<key-name> | jq .<sub-key>
```

## Reference a key that contains spaces or dots:
```shell
cat <json-file> | jq '."<key-name>"'
cat <json-file> | jq ".\"<key-name>\""
```

## Convert JSON objects under a specific key to key-value pairs (for example before sourcing them in a shell script):
```shell
cat <json-file> | jq .<key-name> | jq -r 'to_entries|map("\(.key)=\"\(.value|tostring)\"")|.[]'
```

<br><br>

## Output in compact format, instead of pretty-printed format:
```shell
jq -c
```

## Output values as raw strings rather than JSON (useful to remove quotes from output):
```shell
jq -r
```

## Use tabs instead of spaces for indentation:
```shell
jq --tab
```