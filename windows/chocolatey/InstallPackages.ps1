$userName = "Mattias Holm"
$userEmail = "mattias.holm@live.com"



Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux

choco install -y vscode
choco install -y git ; git config --global user.name $userName ; git config --global user.email $userEmail ; git config --global credential.helper wincred
choco install -y python3
choco install -y powershell-core ; pwsh "$(git rev-parse --show-toplevel)/pwsh/InstallModules.ps1"
powershell "$(git rev-parse --show-toplevel)/pwsh/InstallModules.ps1"
choco install -y azure-cli ; az extension add -y --source https://azclishowdeployment.blob.core.windows.net/releases/dist/show_deployment-0.0.7-py2.py3-none-any.whl
choco install -y terraform
choco install -y pulumi
choco install -y jq
choco install -y kubernetes-cli
choco install -y azure-data-studio
choco install -y microsoftazurestorageexplorer$
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
