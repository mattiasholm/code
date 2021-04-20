# Cheat Sheet - gitignore

<br>

## Ignore a specific file:
```
<filename>.<file-extension>
```

## Keep a specific file:
```
!<filename>.<file-extension>
```

<br><br>

## Ignore all files with a specific file extension:
```
*.<file-extension>
```

## Ignore all files with a specific filename:
```
<filename>.*
```

<br><br>

## Ignore a directory:
```
<directory>/
```

## Ignore all files in a specific directory:
```
<directory>/*
```

## Ignore a specific file in the root directory:
```
/<filename>.<file-extension>
```

## Ignore a specific file in a specific directory:
```
<directory>/<filename>.<file-extension>
```

## Ignore a specific file in all directories:
```
**/<filename>.<file-extension>
```

## Ignore a specific directory in all directories:
```
**/<directory>/
```

## Ignore a specific file in zero or more directories:
```
<directory>/**/<filename>.<file-extension>
```

## Ignore all files:
```
/*
```

<br><br>

## Ignore files that match exactly one character (except slash `/`):
```
?
```

## Ignore files that match one or more characters (except slash `/`):
```
*
```

## Ignore files that match a single character from a specific set:
```
[123]
[abc]
```

## Ignore files that match a single character from a specific range:
```
[0-9]
[a-z]
[a-zA-Z]
```

## Ignore files that don't match a single character from a specific set:
```
[!123]
[!abc]
```

<br><br>

## Add a comment:
```
# <comment>
```

## Escape a special character:
```
\<special-character>
```