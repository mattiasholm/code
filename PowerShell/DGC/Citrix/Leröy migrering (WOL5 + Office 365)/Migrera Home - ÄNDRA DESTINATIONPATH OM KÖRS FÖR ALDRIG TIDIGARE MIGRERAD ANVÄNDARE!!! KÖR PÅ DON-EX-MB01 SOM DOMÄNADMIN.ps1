### OBS: OM KÖRS PÅ NYA KONTON (EJ TIDIGARE STAGEADE - ÄNDRA DESTINATIONPATH ENLIGT NYTT SKRIPT!!!) ###


$ErrorActionPreference = "Stop"

$ImportUsers = Import-Csv C:\temp\LeroyImportUsers.txt


foreach ($ImportUser in $ImportUsers)
{
$UserPrincipalName = $ImportUser.UserPrincipalName

if (!(Get-PSSnapin | where {$_.Name -match "Exchange.Management"})) { Add-PSSnapin Microsoft.Exchange.Management.* }
$OldUPN = $UserPrincipalName -replace ".test@","@"
$OldAccount = Get-ADUser -Filter {UserPrincipalName -eq $OldUPN} -Properties *
if ($OldAccount -eq $null)
{
$Recipient = Get-Recipient $OldUPN
if (!($Recipient -eq $null))
{
$Sam = $Recipient.SamAccountName
$OldUPN = (Get-ADUser $Sam).UserPrincipalName
$OldAccount = Get-ADUser -Filter {UserPrincipalName -eq $OldUPN} -Properties *
}
else
{
Write-Host "$UserPrincipalName finns ej sedan tidigare! Lägg upp manuellt!" -ForegroundColor Red
break
}
}
if ($OldAccount.Enabled -eq $false)
{
Write-Host "Kontot $UserPrincipalName är inaktiverat. Verifiera att det verkligen skall läggas upp i nya miljön!" -ForegroundColor Red
break
}

$objUser = [ADSI]“LDAP://$($OldAccount.Distinguishedname)”
$TerminalServicesHomeDirectory = $objUser.TerminalServicesHomeDirectory
$SourcePath = $TerminalServicesHomeDirectory

$AdUser = Get-ADUser -Filter {UserPrincipalName -eq $UserPrincipalName} -Properties *

$DestinationPath = $AdUser.HomeDirectory



# Kontrollera sökvägar för alla användare i loopen:
#Write-Host "$SourcePath will be exported to $DestinationPath"

### OBS: OM KÖRS PÅ NYA KONTON (EJ TIDIGARE STAGEADE - ÄNDRA DESTINATIONPATH ENLIGT NYTT SKRIPT!!!) ###
##### Detta kan tas bort vid nästa migrering!!! #####
if (Get-ChildItem $DestinationPath | where {$_.Name -eq "! Data från tidigare WorkOnline-miljö"})
{
Rename-Item "$DestinationPath\! Data från tidigare WorkOnline-miljö" "$DestinationPath\WINDOWS"
}
##### Detta kan tas bort vid nästa migrering!!! #####

robocopy $SourcePath $DestinationPath /z /e /xd "Chrome" /B /R:0
### OBS: OM KÖRS PÅ NYA KONTON (EJ TIDIGARE STAGEADE - ÄNDRA DESTINATIONPATH ENLIGT NYTT SKRIPT!!!) ###

##### Detta kan tas bort vid nästa migrering!!! #####
if (Get-ChildItem $DestinationPath | where {$_.Name -eq "WINDOWS"})
{
Rename-Item "$DestinationPath\WINDOWS" "$DestinationPath\! Data från tidigare WorkOnline-miljö"
}
##### Detta kan tas bort vid nästa migrering!!! #####

}