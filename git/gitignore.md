# Cheat Sheet - gitignore

<br>

## Ignore a specific file:
```
<file-name>.<file-extension>
```

## Keep a specific file:
```
!<file-name>.<file-extension>
```

<br><br>

## Ignore all files with a specific file extension:
```
*.<file-extension>
```

## Ignore all files with a specific filename:
```
<file-name>.*
```

<br><br>

## Ignore a directory:
```
<directory-name>/
```

## Ignore all files in a specific directory:
```
<directory-name>/*
```

## Ignore a specific file in the root directory:
```
/<file-name>.<file-extension>
```

## Ignore a specific file in a specific directory:
```
<directory-name>/<file-name>.<file-extension>
```

## Ignore a specific file in all directories:
```
**/<file-name>.<file-extension>
```

## Ignore a specific directory in all directories:
```
**/<directory-name>/
```

## Ignore a specific file in zero or more directories:
```
<directory-name>/**/<file-name>.<file-extension>
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