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

## Print text with different colors:
```shell
echo -e "\033[32mText \033[39mwith \033[35mdifferent \033[31mcolors\033[39m"
```

| _FormatCode_ | Description      |
| ------------ | ---------------- |
| 1            | Bold             |
| 2            | Dim              |
| 4            | Underline        |
| 5            | Blink            |
| 8            | Hidden           |
| 0            | Reset all        |
| 21           | Reset bold       |
| 22           | Reset dim        |
| 24           | Reset underline  |
| 25           | Reset blink      |
| 28           | Reset hidden     |
| 39           | Default color    |
| 30           | Black            |
| 31           | Red              |
| 32           | Green            |
| 33           | Yellow           |
| 34           | Blue             |
| 35           | Magenta          |
| 36           | Cyan             |
| 97           | White            |
| 49           | Default bg color |
| 40           | Black bg         |
| 41           | Red bg           |
| 42           | Green bg         |
| 43           | Yellow bg        |
| 44           | Blue bg          |
| 45           | Magenta bg       |
| 46           | Cyan bg          |
| 107          | White bg         |

<br><br>

## Change Internal Field Separator (IFS), i.e. delimiter used in `for` loops:
```shell
IFS='<delimeter>'
```

## Unset a variable:
```shell
unset <variable-name>
```

## Identify the location of executables (list only first one, i.e. default):
```shell
which bash

which python3

which pwsh
```

## Identify the location of executables (lists all available):
```shell
which -a bash

which -a python3

which -a pwsh
```

## Locate a specific file:
```shell
locate <file-name>
```

## Recursively find all files that match a specific wildcard pattern:
```shell
find <path> -type <f | d> -name "<pattern>"
```

## Recursively find all files that match a specific wildcard pattern and use `grep` to look for a specific pattern in each file's content:
```shell
find <path> -type <f | d> -name "<pattern>" -exec grep -- <pattern> {} +
```

## SSH via a jumphost:
```shellßß
ssh -J <host1> <host2>
```

## Update hosts file:
```shell
sudo vim /etc/hosts
```

## Create alias:
```shell
alias a='cmd'
```

## Create persistent alias by adding it to `.bashrc`:
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

## Change prompt to include current git branch:
```shell
vim ~/.bashrc

# Add the following:
export PS1="\u@\h \W\[\033[32m\]\$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/')\[\033[00m\] $ "

```

## Source `.bashrc` to make change take effect right away, without having to restart shell:
```shell
. ~/.bashrc
```

## Show bash version:
```shell
bash --version

echo ${BASH_VERSION}
```

## Show bash history:
```shell
cat ~/.bash_history
```

## Source .env file in the same path as script:
```shell
. "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}" | sed 's/[.].*$/.\env/')"
```