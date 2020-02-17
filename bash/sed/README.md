# Cheat Sheet - sed

<br>

## Remove a specific pattern:
```shell
sed 's/<pattern>//g'
```

## Remove any of the specified patterns:
```shell
sed 's/[<pattern1><pattern2>]//g'
```

## Replace a specific pattern with another character/string:
```shell
sed 's/<old-pattern>/<new-pattern>/g'
```

## Replace any of the specified patterns with character/string:
```shell
sed 's/[<old-pattern1><old-pattern2>]/<new-pattern>/g'
```

## Make multiple replacements in one command:
```shell
sed 's/<old-pattern1>/<new-pattern1>/g; s/<old-pattern2>/<new-pattern2>/g'
```

## Remove only first occurence of a specific pattern:
```shell
sed 's/<pattern>//'
```

## Remove a specific pattern from beginning of line:
```shell
sed 's/^<pattern>//'
```

## Remove a specific pattern from end of line:
```shell
sed 's/<pattern>$//'
```

## Remove a specific pattern if there's nothing else on the line:
```shell
sed 's/^<pattern>$//'
```

## Remove entire line if it contains a specific pattern:
```shell
sed '/<pattern>/d'
```
## Remove file extension from filename:
```shell
sed 's/\.[^.]*$//'
```

<!-- Skapa tabell liknande den för regex med syntax och alla vanliga växlar! -->

<!-- g -->
<!-- d -->
<!-- s -->
<!-- FLER? -->
