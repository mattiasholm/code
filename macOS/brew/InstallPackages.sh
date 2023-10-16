#!/usr/bin/env bash

set -e

path=~/repos/code
cd "$path"

userName='Mattias Holm'
userEmail='mattias.holm@live.com'
topLevel="$(git rev-parse --show-toplevel)"

touch ~/.hushlogin

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

echo '# sudo: auth account password session
auth       sufficient     pam_tid.so
auth       sufficient     pam_smartcard.so
auth       required       pam_opendirectory.so
account    required       pam_permit.so
password   required       pam_deny.so
session    required       pam_permit.so' | sudo tee /etc/pam.d/sudo

brew install tcping
brew install fping
brew install coreutils
brew install grep
brew install vim
brew install jq
brew install pwgen
brew install gh
brew install azure/bicep/bicep
brew install terraform
brew install opentofu
brew install tflint
brew install tfsec
brew install terrascan
brew install terraform-docs
brew install infracost
brew install checkov
brew install pulumi
brew install python3
brew install kubectl
brew install kubectx
brew install lastpass-cli
brew install tmate
brew install act
brew install ddosify/tap/ddosify
brew install graphviz
brew install p7zip
brew install sox
brew install abcmidi
brew install timidity

brew install bash
. "$topLevel/bash/.bashrc"
.b

if [[ -z "$(cat /etc/shells | grep -- /usr/local/bin/bash)" ]]; then
    echo '/usr/local/bin/bash' | sudo tee -a /etc/shells
fi

brew install fish
cp "$topLevel/fish/config.fish" ~/.config/fish/config.fish

if [[ -z "$(cat /etc/shells | grep -- /usr/local/bin/fish)" ]]; then
    echo '/usr/local/bin/fish' | sudo tee -a /etc/shells
fi

chsh -s /usr/local/bin/fish
sudo chsh -s /usr/local/bin/fish

brew install mas &&
    chmod +x "$topLevel/macOS/mas/InstallApps.sh" &&
    "$topLevel/macOS/mas/InstallApps.sh"

brew install git &&
    git config --global user.name "$userName" &&
    git config --global user.email "$userEmail" &&
    git config --global credential.helper osxkeychain &&
    git config --global init.defaultBranch main &&
    chmod +x "$topLevel/git/cloneRepos.sh" &&
    "$topLevel/git/cloneRepos.sh"

brew install azure-cli &&
    (
        az init
        az extension add --name azure-devops
        az extension add -y --source https://azclishowdeployment.blob.core.windows.net/releases/dist/show_deployment-0.0.7-py2.py3-none-any.whl
    )

brew install --cask iterm2
brew install --cask dotnet-sdk
brew install --cask postman
brew install --cask balenaetcher
brew install --cask owasp-zap
brew install --cask azure-data-studio
brew install --cask microsoft-azure-storage-explorer
brew install --cask google-chrome
brew install --cask drawio
brew install --cask intune-company-portal
brew install --cask microsoft-office
brew install --cask microsoft-teams
brew install --cask zoom
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
brew install --cask dosbox-x
brew install --cask tor-browser
brew install --cask transmission

brew install --cask visual-studio-code &&
    chmod +x "$topLevel/vscode/InstallExtensions.sh" &&
    "$topLevel/vscode/InstallExtensions.sh"

brew install --cask powershell &&
    pwsh "$topLevel/pwsh/InstallModules.ps1" &&
    cp "$topLevel/pwsh/Microsoft.PowerShell_profile.ps1" ~/.config/powershell/Microsoft.PowerShell_profile.ps1
