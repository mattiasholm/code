# Note: Chocolatey needs to be run from an elevated PowerShell prompt - also avoid using PowerShell Core!

choco install -y vscode
choco install -y git ; git config --global user.name "Mattias Holm" ; git config --global user.email "mattias.holm@live.com" ; git config --global credential.helper wincred
choco install -y python3
choco install -y powershell-core
choco install -y azure-cli ; az extension add -y --source https://azclishowdeployment.blob.core.windows.net/releases/dist/show_deployment-0.0.7-py2.py3-none-any.whl
choco install -y kubernetes-cli
choco install -y pulumi
choco install -y azure-data-studio
choco install -y microsoftazurestorageexplorer
choco install -y docker-desktop
choco install -y googlechrome
choco install -y office365proplus
choco install -y onenote
choco install -y microsoft-teams
choco install -y teamviewer
choco install -y dropbox
choco install -y gimp
choco install -y vlc
choco install -y spotify
choco install -y nestopia
choco install -y wsl
choco install -y 7zip
choco install -y winscp
choco install -y vim
choco install -y greenshot
choco install -y filezilla
choco install -y jabra-direct
choco install -y microsoft-windows-terminal
