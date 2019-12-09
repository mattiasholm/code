$UserPrincipalName = Read-Host "E-postadress"

if ($UserPrincipalName -like "*@meritmind.se")
{
$OUname = "Meritmind"
}
elseif ($UserPrincipalName -like "*@brightby.se")
{
$OUname = "Brightby"
}

if ($OUname -ne $null)
{
$FileServerPath = "\\meritmind.local\Storage\"

$ReturnValue = $null
if (!(Get-Module | where {$_.Name -match "ActiveDirectory"})) { Import-Module ActiveDirectory }

$ADUser = Get-ADUser -Filter {UserPrincipalName -eq $UserPrincipalName}

if ($ADUser)
{
if ([ADSI]::Exists("LDAP://CN=ExchangeActiveSyncDevices,$($ADUser.DistinguishedName)") -eq $True)
{
$ErrorActionPreference = "Stop"
Remove-ADObject "CN=ExchangeActiveSyncDevices,$($ADUser.DistinguishedName)" -Confirm:$False -ErrorVariable ReturnValue

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
}
until ([ADSI]::Exists("LDAP://CN=ExchangeActiveSyncDevices,$($ADUser.DistinguishedName)") -eq $False -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired during deletion of LDAP container 'ExchangeActiveSyncDevices' for $UserPrincipalName."
return
}
}


$ErrorActionPreference = "Stop"
Remove-ADUser $ADUser -Confirm:$False -ErrorVariable ReturnValue

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
}
until (!(Get-ADUser -Filter {UserPrincipalName -eq $UserPrincipalName}) -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired during deletion of ADUser $UserPrincipalName."
}

$SamAccountName = $ADUser.SamAccountName
$HomeFolderPath = Join-Path $FileServerPath "$OUname\Home"

if (Test-Path "$HomeFolderPath\$SamAccountName")
{
Remove-Item "$HomeFolderPath\$SamAccountName" -ErrorVariable ReturnValue -Confirm:$False -Recurse:$true
}

$ErrorActionPreference = "SilentlyContinue"

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
}
until (!(Get-Item "$HomeFolderPath\$SamAccountName") -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired while removing folders."
return
}

}
else
{
$ReturnValue = "AD account not found"
}
}

Write-Host $ReturnValue

if (!$ReturnValue)
{
Write-Host -ForegroundColor Green "AD-konto $UserPrincipalName raderat!"
}

Pause