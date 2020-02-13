# Cheat Sheet - Homebrew

<br>

# OBS: RENSKRIV NEDAN, ÄR SAXAT RAKT FRÅN ONENOTE!

<br>

# Install Homebrew (macOS package manager, aka "formulae")
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Update Homebrew
brew update

# Install CLI tools
brew install [formula]

# Install GUI applications
brew cask install [formula]

# Upgrade CLI tools
brew upgrade [formula]

# Upgrade GUI applications
brew cask upgrade [formula]

# Uninstall CLI tools
brew uninstall [formula]

# Uninstall GUI applications
brew cask uninstall [formula]

# Suppress upgrades for a formulae
brew pin [formula]

# Disable upgrade suppression for a formulae
brew unpin [formula]

# Upgrade all formulae
```shell
brew update &&
    brew upgrade
```

# Link something manually installed to Homebrew
brew link --overwrite [Formulae]

# Reinstall with Homebrew
brew reinstall [Formulae]

# Clean up old versions of formulae
brew cleanup

# Search for formulas
brew search
brew search azure

# List installed formulae
brew list

# List installed Casks
brew cask list

# Display contextual help
brew list --help



# On the web:
https://formulae.brew.sh/formula/
https://formulae.brew.sh/cask/