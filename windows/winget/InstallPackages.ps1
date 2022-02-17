$UserName = "Mattias Holm"
$UserEmail = "mattias.holm@live.com"

$Packages = @(
    "Microsoft.VisualStudioCode"
    "Microsoft.WindowsTerminal"
    "Git.Git"
    "Microsoft.PowerShell"
    "Microsoft.AzureCLI"
    "Microsoft.Bicep"
)

foreach ($Package in $Packages) {
    winget install $Package --silent
}

git config --global user.name $UserName
git config --global user.email $UserEmail
git config --global credential.helper wincred
git config --global init.defaultBranch main
