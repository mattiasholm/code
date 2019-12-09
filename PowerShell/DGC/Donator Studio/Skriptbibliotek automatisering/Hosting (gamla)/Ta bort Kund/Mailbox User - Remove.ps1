$UserPrincipalName = "bixtest@bixtest.se"
#$Session = ""



$ReturnValue = $null
if (!(Get-Module | where {$_.Name -match "ActiveDirectory"})) { Import-Module ActiveDirectory }
if (!(Get-PSSnapin | where {$_.Name -match "Exchange.Management"})) { Add-PSSnapin Microsoft.Exchange.Management.* }

$ADUser = Get-ADUser -Filter {UserPrincipalName -eq $UserPrincipalName}

$ErrorActionPreference = "Stop"
if (Get-Mailbox $UserPrincipalName -ErrorVariable ReturnValue)
{
if (Get-MobileDevice -Mailbox $UserPrincipalName)
{

$ErrorActionPreference = "Stop"
Invoke-Command -Session $Session -ScriptBlock {
Param($UserPrincipalName)
Get-MobileDevice -Mailbox $UserPrincipalName | Remove-MobileDevice -Confirm:$False
} -ArgumentList ($UserPrincipalName) -ErrorVariable ReturnValue

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
}
until (!(Get-MobileDevice -Mailbox $UserPrincipalName) -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired during deletion of MobileDevices for $UserPrincipalName."
return
}


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
Disable-Mailbox $UserPrincipalName -Confirm:$False -ErrorVariable ReturnValue

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
$ErrorActionPreference = "SilentlyContinue"
}
until (!(Get-Mailbox $UserPrincipalName) -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired during deletion of Mailbox $UserPrincipalName"
return
}
}

Write-Host $ReturnValue