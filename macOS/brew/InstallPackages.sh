#!/usr/bin/env bash

set -e +x

path=~/repos/mattiasholm
cd ${path}

userName="Mattias Holm"
userEmail="mattias.holm@live.com"

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

brew install --cask iterm2

brew install bash &&
    chmod +x "$(git rev-parse --show-toplevel)/bash/bashrc.sh" &&
    "$(git rev-parse --show-toplevel)/bash/bashrc.sh"

if [[ -z "$(cat /etc/shells | grep -- /usr/local/bin/bash)" ]]; then
    echo "/usr/local/bin/bash" | sudo tee -a /etc/shells
fi
chsh -s /usr/local/bin/bash
sudo chsh -s /usr/local/bin/bash

echo -e "# sudo: auth account password session
auth       sufficient     pam_tid.so
auth       sufficient     pam_smartcard.so
auth       required       pam_opendirectory.so
account    required       pam_permit.so
password   required       pam_deny.so
session    required       pam_permit.so" | sudo tee /etc/pam.d/sudo

brew install coreutils
brew install grep
brew install vim
brew install jq
brew install mas

brew install git &&
    git config --global user.name "${userName}" &&
    git config --global user.email "${userEmail}" &&
    git config --global credential.helper osxkeychain &&
    chmod +x "$(git rev-parse --show-toplevel)/git/CloneRepos.sh" &&
    "$(git rev-parse --show-toplevel)/git/CloneRepos.sh"

brew install --cask visual-studio-code &&
    chmod +x "$(git rev-parse --show-toplevel)/vscode/InstallExtensions.sh" &&
    "$(git rev-parse --show-toplevel)/vscode/InstallExtensions.sh"

brew install python3

# brew install ffmpeg ### Don't think I use this anymore ###
# pip3 install pydub ### Don't think I use this anymore ###
# pip3 install soundfile ### Don't think I use this anymore ###
# pip3 install numpy ### Don't think I use this anymore ###
# pip3 install mssql-cli ### Don't think I use this anymore ###

brew install --cask powershell

brew install azure-cli &&
    (
        az extension add --name azure-devops
        az extension add -y --source https://azclishowdeployment.blob.core.windows.net/releases/dist/show_deployment-0.0.7-py2.py3-none-any.whl
    )

brew tap azure/bicep https://github.com/azure/bicep
brew install azure/bicep/bicep

brew install --cask dotnet-sdk
brew install terraform
brew install pulumi
brew install kubernetes-cli
brew install lastpass-cli
brew install p7zip
brew install sox
brew install --cask owasp-zap
brew install --cask azure-data-studio
brew install --cask microsoft-azure-storage-explorer
# brew install --cask docker ### Not supported on Apple Silicon ###
brew install --cask google-chrome
brew install --cask intune-company-portal
brew install --cask microsoft-office
brew install --cask microsoft-teams
brew install --cask teamviewer
brew install --cask watchguard-mobile-vpn-with-ssl
brew install --cask avg-antivirus
brew install --cask dropbox
brew install --cask gimp
brew install --cask paintbrush
brew install --cask vlc
brew install --cask spotify
brew install --cask plex-media-server
brew install --cask obs
brew install --cask openemu
brew install --cask transmission
