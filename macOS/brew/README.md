## Cheat Sheet - Homebrew

<br>

## Official docs:
https://docs.brew.sh/

## Formulae:
https://formulae.brew.sh/formula/

## Casks:
https://formulae.brew.sh/cask/

<br><br>

## Install Homebrew:
```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

## Check Homebrew version:
```shell
brew --version
brew -v
```

## Check your system for potential problems:
```shell
brew doctor
```

## Contextual help:
```shell
brew help [<subcommand>]
brew [<subcommand>] --help
brew [<subcommand>] -h
```

## List all Homebrew commands:
```shell
brew commands
```

<br><br>

## Update Homebrew:
```shell
brew update
```

<br><br>

## Display information about a formula:
```shell
brew info <formula-name>
```

## Install formula:
```shell
brew install <formula-name>
```

## Install an old version of a formula:
```shell
brew tap-new $USER/local-tap

brew extract <formula-name> --version=<version> $USER/local-tap

brew install <formula-name>@<version>
```

## Install cask:
```shell
brew install --cask <cask-name>
```

<br><br>

## Upgrade formula:
```shell
brew upgrade <formula-name>
```

## Upgrade cask:
```shell
brew upgrade --cask <cask-name>
```

<br><br>

## Activate a previously installed version of a formula:
```shell
brew switch <formula-name> <version>
```

<br><br>

## Uninstall formula:
```shell
brew uninstall <formula-name>
```

## Uninstall cask:
```shell
brew uninstall --cask <cask-name>
```

<br><br>

## Reinstall a formula:
```shell
brew reinstall <formula-name>
```

## Reinstall a cask:
```shell
brew reinstall <cask-name>
```

<br><br>

## Suppress upgrades for a formula:
```shell
brew pin <formula-name>
```

## Enable upgrades for a formula:
```shell
brew unpin <formula-name>
```

<br><br>

## Upgrade all formulae:
```shell
brew update &&
    brew upgrade
```

## Upgrade all casks:
```shell
brew update &&
    brew upgrade --cask
```

<br><br>

## Link a manually installed formula to Homebrew:
```shell
brew link --overwrite <formula-name>
```

## Clean up old versions of formulae and casks:
```shell
brew cleanup
```

<br><br>

## List all available formulae:
```shell
brew search
```

## Search for a specific formula:
```shell
brew search <formula-name>
```

<br><br>

## List installed formulae:
```shell
brew list
```

## List installed casks:
```shell
brew list --cask
```

<br><br>

## List tapped repositories:
```shell
brew tap
```

## Tap a formula repository:
```shell
brew tap <github-account>/<github-repo>
```

## Untap a formula respository:
```shell
brew untap <github-account>/<github-repo>
```

## Create a new tap:
```shell
brew new-tap <user>/<repo>
```