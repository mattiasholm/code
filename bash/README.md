# Cheat Sheet - bash

<br>

## Open BSD General Commands Manual:
```shell
man <command>
```

## Change password for currently logged in user:
```shell
passwd
```

<br><br>

## Portable shebang for `bash`:
```shell
#!/usr/bin/env bash
```

<br><br>

## Logic for running commands conditionally (basically try-catch-finally):
| Operator | Behavior                                     |
| -------- | -------------------------------------------- |
| A; B     | Run A and then B, regardless of success of A |
| A && B   | Run B if and only if A succeeded             |
| A \|\| B | Run B if and only if A failed                |
| A &      | Run A in background                          |

<br><br>

## Print text with escape characters:
```shell
echo -e "\n<text>\n"
```

## Print text without a new line:
```shell
echo -n "<text>"
```

## Print text with different colors:
```shell
echo -e "\033[32mText \033[39mwith \033[35;1mdifferent \033[0;31mcolors\033[0m"
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
which <executable-name>
type <executable-name>
command -v <executable-name>
whereis <executable-name>
```

## Identify the location of executables (lists all available):
```shell
which -a <executable-name>
```

## Locate a specific file:
```shell
locate <filename>
```

## Recursively find all directories that are empty:
```shell
find <path> -type d -empty
```

## Recursively find all files that match a specific wildcard pattern:
```shell
find <path> [-type <f | d>] -name "<pattern>"
```

## Recursively find and remove all files that match a specific wildcard pattern:
```shell
find <path> [-type <f | d>] -name "<pattern>" -delete
find <path> [-type <f | d>] -name "<pattern>" -exec rm {} +
find <path> [-type <f | d>] -name "<pattern>" -exec rm {} \;
```

## Recursively find all files that match a specific wildcard pattern and write each file's content to standard output:
```shell
find <path> [-type <f | d>] -name "<pattern>" -exec cat {} +
find <path> [-type <f | d>] -name "<pattern>" -exec cat {} \;
```

## Recursively find all files that match a specific wildcard pattern and use `grep` to look for a specific pattern in each file's content:
```shell
find <path> [-type <f | d>] -name "<pattern>" -exec grep -- <pattern> {} +
find <path> [-type <f | d>] -name "<pattern>" -exec grep -- <pattern> {} \;
```

## Recursively find all files that match a specific wildcard pattern and run a custom script with each file as argument:
```shell
find . [-type <f | d>] -name "<pattern>" -exec <script-path> {} \;
```

## SSH via a jumphost:
```shell
ssh -J <host1> <host2>
```

## Update hosts file:
```shell
sudo vim /etc/hosts

<ip-address> <host-name>
```

## Update NTP configuration:
```shell
sudo vim /etc/ntp.conf

server <ntp-server>
```

## Check current user's group membership:
```shell
id
```

## List all aliases:
```shell
alias
```

## Create alias:
```shell
alias <name>='<command>'
```

## Create persistent alias by adding it to `.bashrc` (Bash Run Commands):
```shell
vim ~/.bashrc
```

## Remove alias
```shell
unalias <alias-name>
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

## Count number of words:
```shell
wc -w
```

## Count number of characters:
```shell
wc -m
```

## Count number of bytes:
```shell
wc -c
```

<br><br>

## Alias to `ls -la`:
```shell
ll
```

<br><br>

## Grep multiple patterns:
```shell
grep --extended-regexp '<pattern1>|<pattern2>'
grep -E '<pattern1>|<pattern2>'
```

## Grep case insensitive match:
```shell
grep --ignore-case <substring>
grep -i <substring>
```

## Grep inverted match:
```shell
grep --invert-match <substring>
grep -v <substring>
```

## Grep illegal characters (`--` is a delimiter between command options and positional parameters):
```shell
grep -- <substring>
```

## Grep and show `n` number of lines before match:
```shell
grep -B <n>
```

## Grep and show `n` number of lines before match:
```shell
grep -A <n>
```

## Grep and show `n` number of lines before and after match:
```shell
grep -C <n>
```

<br><br>

## Create empty file in working directory:
```shell
touch <filename>
```

## Use process substitution to make list act like a file (command substitution would not work):
```shell
source <(echo key=value)
source /dev/stdin <<<"$(echo key=value)"
```

<br>

## Source `.bashrc` to make changes take effect right away, without having to restart the shell:
```shell
source ~/.bashrc
. ~/.bashrc
```

## Show bash version:
```shell
bash --version

echo ${BASH_VERSION}
```

## Show bash history:
```shell
history
cat ~/.bash_history
```

## Run the most previous command again:
```shell
!!
!-1
```

## Run the second most previous command again:
```shell
!!
!-2
```

## Run a specific command from history again:
```shell
history

!<number>
```

## Show user login history:
```shell
last
```

## Source .config file in the same path as script:
```shell
. $(basename $0 | sed 's/.sh$/.config/')
```

## Reference a variable by another variable's value:
```shell
${!<variable>}
```

## Print output in reversed order:
```shell
tail -r
```

## Run a shell script directly from a public URL, without having to download it locally (use with caution!):
```shell
curl --silent <url> | bash
bash <(curl --silent <url>)
```

## Test a TCP connection to a specific host and port:
```shell
nc -z <host> <port>
```

## Test whether outbound traffic on a specific port is allowed or not:
nc -z portquiz.net <port>

<br><br>

## Make all files with a specific file extension in working directory executable:
```shell
chmod +x *.<file-extension>
```

## Print something only temporarily by using cursor movement (basically placing the cursor at the beginning of the line, effectively overwriting the old text with spaces)
```shell
printf "<temporary-text>" && printf '\r\033[1B'
sleep 1
echo "                "
```

## Print a random element from an array:
```shell
array=("a" "b" "c")

echo ${array[RANDOM%${#array[*]}]}
```

## Output only a specific number of lines:
```shell
head -<number>
```

## Replace lower-case letters with upper-case:
```shell
tr a-z A-Z
```

## Create an MD5 hash from the content of a file (useful for verifying data integrity):
```shell
cat <filename> | md5
```

## Generate a GUID:
```shell
uuidgen
```

## Check if a command is installed:
```shell
if [[ -x "$(command -v <command>)" ]]
```

<br><br>

## Addition in bash:
```shell
expr <int> + <int>
```

## Subtraction in bash:
```shell
expr <int> - <int>
```

## Multiplication in bash:
```shell
expr <int> \* <int>
```

## Integer division in bash:
```shell
expr <int> / <int>
```

<!-- Städa upp och kategorisera bättre här vid tillfälle!

Ev bryta loss grep till egen README.md??? FLER?

-->