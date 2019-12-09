$ErrorActionPreference = "Stop"

$ImportUsers = Import-Csv C:\temp\LeroyImportUsers.txt


foreach ($ImportUser in $ImportUsers)
{
$UserPrincipalName = $ImportUser.UserPrincipalName

$AdUser = Get-ADUser -Filter {UserPrincipalName -eq $UserPrincipalName} -Properties *

$DestinationPath = $AdUser.HomeDirectory

if (Get-ChildItem $DestinationPath | where {$_.Name -eq "WINDOWS"})
{
Rename-Item "$DestinationPath\WINDOWS" "$DestinationPath\! Data från tidigare WorkOnline-miljö"
}
else
{
Write-Host -ForegroundColor Yellow "Cannot find a WINDOWS folder!"
}
}



# KONTROLLERA:
<#
$ErrorActionPreference = "Stop"

$ImportUsers = Import-Csv C:\temp\LeroyImportUsers.txt


foreach ($ImportUser in $ImportUsers)
{
$UserPrincipalName = $ImportUser.UserPrincipalName

$AdUser = Get-ADUser -Filter {UserPrincipalName -eq $UserPrincipalName} -Properties *

$DestinationPath = $AdUser.HomeDirectory

Get-ChildItem $DestinationPath | where {$_.Name -eq "! Data från tidigare WorkOnline-miljö"}
}
#>