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

## Get all elements of an array;
```shell
cat <json-file> | jq ".<key-name> | .[]"
cat <json-file> | jq .<key-name> | jq .[]
```

## Get element `n` of an array:
```shell
cat <json-file> | jq ".<key-name> | .[<n>]"
cat <json-file> | jq .<key-name> | jq .[<n>]
```

## Get a specific array element, based on the value of another subelement:
```shell
cat <json-file> | jq -r ".<key-name>[] | select(.<first-subelement> == <value>) | .<second-subelement>"
```

<br><br>

## Output values as raw strings rather than JSON (useful to remove quotes from output, instead of using `sed`):
```shell
jq -r
```

## Output in compact format, instead of pretty-printed format:
```shell
jq -c
```

## Use tabs instead of spaces for indentation:
```shell
jq --tab
```