# Cheat Sheet - cut

<br>

## Cut out a specific field using tab as a delimiter:
```shell
cut -f<field-index>
```

## Cut out a specific field using space as a delimiter:
```shell
cut -d' ' -f<field-index>
```

## Cut out a specific field using the specified delimiter:
```shell
cut -d<delimiter> -f<field-index>
cut -d'<delimiter>' -f<field-index>
```


## Cut out multiple fields using the specified delimiter:
```shell
cut -d<delimiter> -f<field-index>,<field-index>
```

## Cut out a range of fields using the specified delimiter:
```shell
cut -d<delimiter> -f[<field-index>]-[<field-index>]
```

<br><br>

## Cut out a specific character position from each line:
```shell
cut -c <character-position>
```

## Cut out multiple character positions from each line:
```shell
cut -c <character-position>,<character-position>
```

## Cut out a range of character positions from each line:
```shell
cut -c [<character-position>]-[<character-position>]
```

<br><br>

## Suppress lines with no field delimiter characters (including empty lines):
```shell
cut -d<delimiter> -f<field-index> -s
```