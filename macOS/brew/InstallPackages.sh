#!/usr/bin/env bash

set -e

path=~/repos/code
cd "$path"

userName='Mattias Holm'
userEmail='mattias.holm@live.com'
topLevel="$(git rev-parse --show-toplevel)"

touch ~/.hushlogin

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

eval "$(/opt/homebrew/bin/brew shellenv)"

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
brew install samba
brew install grep
brew install vim
brew install jq
brew install pwgen
brew install ipcalc
brew install gh
brew install azcopy
brew install azure/bicep/bicep
brew install hashicorp/tap/terraform
brew install opentofu
brew install terraform-linters/tap/tflint
brew install tfsec
brew install terrascan
brew install terraform-docs
brew install infracost
brew install checkov
brew install pulumi
brew install python3
brew install node
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

brew install fish
cp "$topLevel/fish/config.fish" ~/.config/fish/config.fish
grep -qx '/opt/homebrew/bin/fish' /etc/shells || echo '/opt/homebrew/bin/fish' | sudo tee -a /etc/shells
chsh -s /opt/homebrew/bin/fish

brew install powershell &&
    pwsh "$topLevel/pwsh/InstallModules.ps1" &&
    cp "$topLevel/pwsh/Microsoft.PowerShell_profile.ps1" ~/.config/powershell/Microsoft.PowerShell_profile.ps1

brew install mas &&
    chmod +x "$topLevel/macOS/mas/InstallApps.sh" &&
    "$topLevel/macOS/mas/InstallApps.sh"

brew install git &&
    git config --global user.name "$userName" &&
    git config --global user.email "$userEmail" &&
    git config --global init.defaultBranch main &&
    git config --global push.autoSetupRemote true &&
    git config --global credential.helper osxkeychain &&
    chmod +x "$topLevel/github/clone.sh" &&
    "$topLevel/github/clone.sh"

brew install azure-cli &&
    (
        az init
        az extension add --name azure-devops
        az extension add -y --source https://azclishowdeployment.blob.core.windows.net/releases/dist/show_deployment-0.0.7-py2.py3-none-any.whl
    )

brew install --cask --force iterm2
brew install --cask --force dotnet-sdk
brew install --cask --force postman
brew install --cask --force microsoft-azure-storage-explorer
brew install --cask --force google-chrome
brew install --cask --force drawio
brew install --cask --force intune-company-portal
brew install --cask --force microsoft-office
brew install --cask --force microsoft-teams
brew install --cask --force zoom
brew install --cask --force teamviewer
brew install --cask --force avg-antivirus
brew install --cask --force dropbox
brew install --cask --force gimp
brew install --cask --force paintbrush
brew install --cask --force vlc
brew install --cask --force spotify
brew install --cask --force plex-media-server
brew install --cask --force obs
brew install --cask --force tor-browser
brew install --cask --force transmission

brew install --cask --force visual-studio-code &&
    chmod +x "$topLevel/vscode/InstallExtensions.sh" &&
    "$topLevel/vscode/InstallExtensions.sh"
