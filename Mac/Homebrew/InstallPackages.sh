#!/bin/bash

brew cask install visual-studio-code
brew install git && git config --global user.name "Mattias Holm" && git config --global user.email "mattias.holm@live.com" && git config --global credential.helper osxkeychain
brew install python3
brew cask install powershell
brew install azure-cli
brew install kubernetes-cli
brew cask install azure-data-studio
brew cask install microsoft-azure-storage-explorer
brew cask install docker
brew cask install google-chrome
brew cask install microsoft-office
brew cask install microsoft-teams
brew cask install skype-for-business
brew cask install teamviewer
brew cask install watchguard-mobile-vpn-with-ssl
brew cask install avg-antivirus
brew cask install dropbox
brew cask install gimp
brew cask install paintbrush
brew cask install vlc
brew cask install spotify
brew cask install plex-media-server
brew cask install openemu
brew cask install transmission

code --install-extension ms-vscode.powershell
code --install-extension ms-python.python
code --install-extension foxundermoon.shell-format
code --install-extension ms-vscode-remote.remote-wsl
code --install-extension waderyan.gitblame
code --install-extension ms-mssql.mssql
code --install-extension redhat.vscode-yaml
code --install-extension msazurermtools.azurerm-vscode-tools
code --install-extension bencoleman.armview
code --install-extension josin.kusto-syntax-highlighting
code --install-extension yzhang.markdown-all-in-one
