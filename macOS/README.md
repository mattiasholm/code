# Cheat Sheet - Mac

<br>

>## **GUI**

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

<br><br>

>## **Terminal**

## Open working directory in Finder:
```shell
open .
```

## Open a specific file from Terminal:
```shell
open template.json
```

<br><br>

## Enable tab-completion:
```shell
vim ~/.inputrc

# Add the following lines:
set completion-ignore-case on
set show-all-if-ambiguous on
TAB: menu-complete
```

## List all volumes, such as external hard drives:
```shell
ls /Volumes/
```

<br><br>

## Source `.bashrc` from `.bash_profile` to mimic Linux (WARNING: Will overwrite existing profile!):
```shell
echo ". ~/.bashrc" > ~/.bash_profile
```