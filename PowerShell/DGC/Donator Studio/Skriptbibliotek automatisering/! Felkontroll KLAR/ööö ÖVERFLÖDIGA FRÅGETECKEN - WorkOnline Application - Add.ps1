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

if ([adsi]::Exists("LDAP://CN=$OU.$Group,OU=$SubOU,OU=$OU,$OUPath") -eq $True)
{
$ExitDescription = "ERROR: Group $OU.$Group already exists."
$ExitCode = 2
Write-Host -Foregroundcolor Red $ExitDescription
}
else
{
Write-Host -ForegroundColor Gray "Creating group $OU.$Group..."
New-ADGroup -GroupCategory Security -GroupScope Global -Name "$OU.$Group" -DisplayName "$OU.$Group" -Path "OU=$SubOU,OU=$OU,$OUPath"
sleep 15
if ([adsi]::Exists("LDAP://CN=$OU.$Group,OU=$SubOU,OU=$OU,$OUPath") -eq $True)
{
Write-Host -Foregroundcolor Green "SUCCESS: Group $OU.$Group created."
$ExitCode = 0
}
else
{
$ExitDescription = "ERROR: Failed to create group $OU.$Group."
$ExitCode = 3
Write-Host -Foregroundcolor Red $ExitDescription
}


if ($ExitCode -eq 0)
{
Write-Host -ForegroundColor Gray "Adding customer group to corresponding global group..."
Add-ADGroupMember -Identity $Group -Members "$OU.$Group"

if ((Get-ADGroup "CN=$OU.$Group,OU=$SubOU,OU=$OU,$OUPath" -Properties *).MemberOf -like "*$Group*")
{
Write-Host -Foregroundcolor Green "SUCCESS: $OU.$Group added to $Group"
$ExitCode = 0
}
else
{
$ExitDescription = "ERROR: Failed to add $OU.$Group to $Group."
$ExitCode = 4
Write-Host -Foregroundcolor Red $ExitDescription
}
}
}