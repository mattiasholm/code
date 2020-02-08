# Cheat Sheet

<br>

## Logic for running commands conditionally (basically try-catch-finally):

| Operator | Behavior                                     |
| -------- | -------------------------------------------- |
| A; B     | Run A and then B, regardless of success of A |
| A && B   | Run B if and only if A succeeded             |
| A \|\| B | Run B if and only if A failed                |
| A &      | Run A in background                          |

<br><br>

## SSH via a jumphost:
```shell
ssh -J <host1> <host2>
```

## Update hosts file:
```shell
vim /etc/hosts
```

## Create alias:
```shell
alias a='cmd'
```

## Create persistent alias:
```shell
vim ~/.bashrc
```

<br><br>

## Change directory to the previous working directory (basically `Alt+Tab` in shell):
```shell
cd -
```

## Change directory to HOME (`~`):
```shell
cd
```

<br><br>

## Count number of lines:
```shell
wc -l
```

## Count number of characters:
```shell
wc -m
```

## Count number of words:
```shell
wc -w
```

<br><br>

## Alias to `ls -la`:
```shell
ll
```

## Grep inverted match:
```shell
grep -v <substring>
```

## Grep illegal characters (`--` is a delimiter between command options and positional parameters):
```shell
grep -- <substring>
```

## Create empty file in working directory:
```shell
touch <file-name>
```

## Use process substitution to make list act like a file (command substitution would not work):
```shell
. <(echo key=value)

. /dev/stdin <<<"$(echo key=value)"
```

<br>

<!-- 
## FLER??? Flytta Curl till en egen cheat sheet, mer logiskt?!
# Eventuellt även flytta https://ifconfig.co/ till egen README - finns fler än endast publik IP!
-->