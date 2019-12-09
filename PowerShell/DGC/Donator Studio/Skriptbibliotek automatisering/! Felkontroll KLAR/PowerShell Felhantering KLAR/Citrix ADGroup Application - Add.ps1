$OUname = "Longdrink"
$Group = "WO.Application.AdobeReader"



if (!(Get-Module | where {$_.Name -match "ActiveDirectory"})) { Import-Module ActiveDirectory }
$ReturnValue = $null
$OUPath = "OU=Customers,OU=Hosting2,DC=emcat,DC=com"
$SubOU = "Applications"


$ErrorActionPreference = "Stop"
New-ADGroup -GroupCategory Security -GroupScope Global -Name "$OUname.$Group" -DisplayName "$OUname.$Group" -Path "OU=$SubOU,OU=$OUname,$OUPath" -ErrorVariable ReturnValue

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
$ErrorActionPreference = "SilentlyContinue"
}
until ([adsi]::Exists("LDAP://CN=$OUname.$Group,OU=$SubOU,OU=$OUname,$OUPath") -eq $True -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired while creating group $OUname.$Group"
return
}

$ErrorActionPreference = "Stop"
Add-ADGroupMember -Identity $Group -Members "$OUname.$Group" -ErrorVariable ReturnValue

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
$ErrorActionPreference = "SilentlyContinue"
}
until ((Get-ADGroup "CN=$OUname.$Group,OU=$SubOU,OU=$OUname,$OUPath" -Properties *).MemberOf -like "*$Group*" -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired while adding group $OUname.$Group to $Group"
return
}