$OU = "Banjo"
$Group = "WO.Application.Outlook"


$ExitCode = 0
$ExitDescription = "No errors."
$OUPath = "OU=Customers,OU=Hosting2,DC=emcat,DC=com"
$SubOU = "Applications"

if (!(Get-Module | where {$_.Name -match "ActiveDirectory"})) { Import-Module ActiveDirectory }

if ([adsi]::Exists("LDAP://OU=$OU,$OUPath") -eq $False)
{
$ExitDescription = "ERROR: OU $OU does not exist."
$ExitCode = 1
Write-Host -Foregroundcolor Red $ExitDescription
}

if ([adsi]::Exists("LDAP://CN=$OU.$Group,OU=$SubOU,OU=$OU,$OUPath") -eq $False)
{
$ExitDescription = "ERROR: Group $OU.$Group does not exist."
$ExitCode = 2
Write-Host -Foregroundcolor Red $ExitDescription
}
else
{
Write-Host -ForegroundColor Gray "Deleting group $OU.$Group..."
Remove-ADGroup "CN=$OU.$Group,OU=$SubOU,OU=$OU,$OUPath" -Confirm:$False
sleep 15
if ([adsi]::Exists("LDAP://CN=$OU.$Group,OU=$SubOU,OU=$OU,$OUPath") -eq $False)
{
Write-Host -Foregroundcolor Green "SUCCESS: Group $OU.$Group deleted."
$ExitCode = 0
}
else
{
$ExitDescription = "ERROR: Failed to delete group $OU.$Group."
$ExitCode = 3
Write-Host -Foregroundcolor Red $ExitDescription
}
}