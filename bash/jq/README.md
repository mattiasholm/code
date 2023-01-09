# Cheat Sheet - jq

<br>

## Parse a JSON file as is in order to get syntax highlighting:
```shell
cat <filename> | jq
```

## Merge two JSON files:
```shell
jq --slurp '.[0] * .[1]' <file1> <file2>
jq -s '.[0] * .[1]' <file1> <file2>
```

## Get all JSON objects under a specific key at the top level:
```shell
cat <filename> | jq .<key-name>
```

## Get all JSON objects under a specific key one level down:
```shell
cat <filename> | jq .<key-name>.<sub-key>
cat <filename> | jq .<key-name> | jq .<sub-key>
```

## Reference a key that contains spaces, dots or variables:
```shell
cat <filename> | jq '."<key-name>"'
cat <filename> | jq ".\"<key-name>\""
```

## Convert JSON objects under a specific key to key-value pairs (for example before sourcing them in a shell script):
```shell
cat <filename> | jq .<key-name> | jq --raw-output 'to_entries|map("\(.key)=\"\(.value|tostring)\"")|.[]'
cat <filename> | jq .<key-name> | jq -r 'to_entries|map("\(.key)=\"\(.value|tostring)\"")|.[]'
```

## Get all elements of an array:
```shell
cat <filename> | jq ".<key-name> | .[]"
cat <filename> | jq .<key-name> | jq .[]
```

## Get element `n` of an array:
```shell
cat <filename> | jq ".<key-name> | .[<n>]"
cat <filename> | jq .<key-name> | jq .[<n>]
```

## Get a property for a specific array element, based on the value of another property:
```shell
cat <filename> | jq -r ".<key-name>[] | select(.<first-property> == \"<value>\") | .<second-property>"
```

<br><br>

## Output values as raw strings rather than JSON (useful to remove quotes from output, instead of using `sed`):
```shell
jq --raw-output
jq --raw-output .
jq -r
jq -r .
```

## Output in compact format, instead of pretty-printed format:
```shell
jq --compact-output
jq -c
```

## Use tabs instead of spaces for indentation:
```shell
jq --tab
```