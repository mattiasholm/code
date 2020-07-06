#!/usr/bin/env bash

userName="Mattias Holm"
userEmail="mattias.holm@live.com"

brew cask install iterm2

brew install bash &&
    chmod +x "$(git rev-parse --show-toplevel)/bash/bashrc.sh" &&
    "$(git rev-parse --show-toplevel)/bash/bashrc.sh"
if [[ -z "$(cat /etc/shells | grep -- /usr/local/bin/bash)" ]]; then
    echo "/usr/local/bin/bash" | sudo tee -a /etc/shells
fi
chsh -s /usr/local/bin/bash
sudo chsh -s /usr/local/bin/bash

brew install coreutils

brew install git &&
    git config --global user.name "${userName}" &&
    git config --global user.email "${userEmail}" &&
    git config --global credential.helper osxkeychain &&
    chmod +x "$(git rev-parse --show-toplevel)/git/CloneRepos.sh" &&
    "$(git rev-parse --show-toplevel)/git/CloneRepos.sh"

brew cask install visual-studio-code

brew install python3
brew install ffmpeg
brew install sox
pip3 install pydub
pip3 install soundfile
pip3 install numpy
pip3 install mssql-cli

brew cask install powershell

brew install azure-cli &&
    (
        az extension add --name azure-devops
        az extension add -y --source https://azclishowdeployment.blob.core.windows.net/releases/dist/show_deployment-0.0.7-py2.py3-none-any.whl
    )

brew install terraform
brew install pulumi
brew install jq
brew install kubernetes-cli
brew install p7zip
brew cask install azure-data-studio
brew cask install microsoft-azure-storage-explorer
brew cask install docker
brew cask install google-chrome
brew cask install microsoft-office
brew cask install microsoft-teams
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