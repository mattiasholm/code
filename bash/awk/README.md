# Cheat Sheet - awk

<br>

## Print a specific field using space as a delimiter:
```shell
awk '{print $<field-index>}'
```

## Print a specific field using the specified delimiter:
```shell
awk -F '<delimiter>' '{print $<field-index>}'
```

## Print lines that match a specific regex:
```shell
awk '/<regex>/'
```

## Print lines that don't match a specific regex:
```shell
awk '!/<regex>/'
```

<br><br>

## Print lines where a specific field is equal to the specified string:
```shell
awk '$<field-index> == "<string>"'
```

## Print lines where a specific field does not equal the specified string:
```shell
awk '$<field-index> != "<string>"'
```

## Print lines where a specific field matches the specified regex:
```shell
awk '$<field-index> ~ /<regex>/'
```

## Print lines where a specific field does not match the specified regex:
```shell
awk '$<field-index> !~ /<regex>/'
```