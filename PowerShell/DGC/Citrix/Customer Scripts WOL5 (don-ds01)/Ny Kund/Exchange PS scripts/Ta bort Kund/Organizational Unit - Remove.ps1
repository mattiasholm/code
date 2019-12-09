$OUname = "Gibraltar"



$ReturnValue = $null
$OUPath = "OU=Hosting,DC=emcat,DC=com"

if (!(Get-Module | where {$_.Name -match "ActiveDirectory"})) { Import-Module ActiveDirectory }

$ErrorActionPreference = "Stop"
Set-ADOrganizationalUnit "OU=$OUname,$OUPath" -ProtectedFromAccidentalDeletion:$False -ErrorVariable ReturnValue

$Timeout = 120
$ErrorActionPreference = "SilentlyContinue"
do
{
sleep 1
$Timeout = $Timeout - 1
}
until ((Get-ADOrganizationalUnit "OU=$OUname,$OUPath" -Properties *).ProtectedFromAccidentalDeletion -eq $False -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired while disabling ProtectedFromAccidentalDeletion on OrganizationalUnit $OUname."
return
}


$ErrorActionPreference = "Stop"
Remove-ADOrganizationalUnit "OU=$OUname,$OUPath" -Recursive -Confirm:$False -ErrorVariable ReturnValue

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
}
until ([adsi]::Exists("LDAP://OU=$OUname,$OUPath") -eq $False -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired while deleting OrganizationalUnit $OUname."
return
}

Write-Host $ReturnValue