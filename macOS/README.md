# Cheat Sheet - Mac

<br>

>## **GUI**

## Show hidden files in Finder:
```
Cmd+Shift+.
```

## Go to folder:
```
Cmd+Shift+G
```

## Go to Home (~):
```
Cmd+Shift+H
```

## Force quit applications:
```
Cmd+Alt+Esc
```

## Take a screenshot of entire screen:
```
Cmd+Shift+3
```

## Take a screenshot of selection:
```
Cmd+Shift+4
```

## Empty recycle bin:
```
Cmd+Alt+Shift+Del
```

<br><br>
<br><br>

>## **TERMINAL**

## List OS version:
```shell
sw_vers
```

## Open working directory in Finder:
```shell
open .
```

## Open a specific file from Terminal:
```shell
open <file-name>
```

<br><br>

## List all available software updates:
```shell
softwareupdate --list
softwareupdate -l
```

## Download all available software updates:
```shell
softwareupdate --download --all
softwareupdate -d -a
```

## Install all available software updates:
```shell
softwareupdate --install --all
softwareupdate -i -a
```

<br><br>

## List all volumes, such as external hard drives:
```shell
ls /Volumes/
```

<br><br>

## Source `.bashrc` from `.bash_profile` to mimic Linux (will overwrite existing profile):
```shell
echo ". ~/.bashrc" > ~/.bash_profile
```
