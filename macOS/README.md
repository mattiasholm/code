# Cheat Sheet - Mac

<br>

>## **GUI**

## Show hidden files in Finder:
<kbd>Cmd</kbd>+<kbd>Shift</kbd>+<kbd>.</kbd>

## Go to folder:
<kbd>Cmd</kbd>+<kbd>Shift</kbd>+<kbd>G</kbd>

## Go to Home (~):
<kbd>Cmd</kbd>+<kbd>Shift</kbd>+<kbd>H</kbd>

## Force quit applications:
<kbd>Cmd</kbd>+<kbd>Alt</kbd>+<kbd>Esc</kbd>

## Take a screenshot of entire screen:
<kbd>Cmd</kbd>+<kbd>Shift</kbd>+<kbd>3</kbd>

## Take a screenshot of selection:
<kbd>Cmd</kbd>+<kbd>Shift</kbd>+<kbd>4</kbd>

## Empty recycle bin:
<kbd>Cmd</kbd>+<kbd>Alt</kbd>+<kbd>Shift</kbd>+<kbd>Del</kbd>

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
open <filename>
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

## Flush DNS cache:
```shell
dscacheutil -flushcache
```

<br><br>

## Change hostname:
```shell
sudo scutil --set HostName <hostname>

sudo scutil --set LocalHostName <hostname>

sudo scutil --set ComputerName <hostname>
```

<br><br>

## Copy to clipboard:
```shell
<command> | pbcopy
```

## Paste from clipboard:
```shell
pbpaste
```

<br><br>

## Lock the Dock to prevent unwanted changes:
```shell
defaults write com.apple.Dock position-immutable -bool true; killall Dock

defaults write com.apple.Dock size-immutable -bool true; killall Dock

defaults write com.apple.Dock contents-immutable -bool true; killall Dock
```

## Unlock the Dock in order to make changes:
```shell
defaults write com.apple.Dock position-immutable -bool false; killall Dock

defaults write com.apple.Dock size-immutable -bool false; killall Dock

defaults write com.apple.Dock contents-immutable -bool false; killall Dock
```