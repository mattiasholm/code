# Cheat Sheet - LastPass CLI

<br>

## GitHub repository:
https://github.com/lastpass/lastpass-cli

## Install LastPass CLI:
```shell
brew install lastpass-cli
```

## Check LastPass CLI version:
```shell
lpass --version
lpass -v
```

## Show help:
```shell
lpass --help
lpass -h
```

## Show manual:
```shell
man lpass
```

<br><br>

## Show current LastPass account:
```shell
lpass status
```

## Log in to LastPass:
```shell
lpass login <email>
```

## Log out from LastPass:
```shell
lpass logout
```

## Log out from LastPass, without confirmation:
```shell
lpass logout --force
lpass logout -f
```

## Sync with LastPass service:
```shell
lpass sync
```

## Change LastPass master password:
```shell
lpass passwd
```

<br><br>

## List all passwords:
```shell
lpass ls
```

## List passwords in a specific folder:
```shell
lpass ls <folder>
```

## List passwords that match a specific pattern:
```shell
lpass ls | grep -- <pattern>
```

## Show a specific password:
```shell
lpass show <id>
```

<br><br>

## Add a new password:
```shell
lpass add <folder>/<name>
```

## Generate a random password and add it to LastPass (write password to standard output):
```shell
lpass generate <id> <password-length>
```

## Generate a random password and add it to LastPass (copy password to clipboard):
```shell
lpass generate <id> <password-length> --clip
```

## Edit a password:
```shell
lpass edit <id>
```

<br><br>

## Move a specific password to another folder:
```shell
lpass mv <id> <folder>
```

## Remove a password:
```shell
lpass rm <id>
```

## Duplicate a password:
```shell
lpass duplicate <id>
```

<br><br>

## Export entire vault to standard output:
```shell
lpass export
```

## Export entire vault to a CSV file:
```shell
lpass export > <path>
```

## Export only entries that match a specific pattern:
```shell
lpass export | grep -- <pattern>
```

## Import entries from a CSV file:
```shell
lpass import <path>
```