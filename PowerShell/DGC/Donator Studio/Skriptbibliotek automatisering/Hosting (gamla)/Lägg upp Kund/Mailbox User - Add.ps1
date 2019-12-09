$UserPrincipalName = "info.test@betalningskontroll.se"
#$Database = ""
#$Session = ""



$ReturnValue = $null
if (!(Get-Module | where {$_.Name -match "ActiveDirectory"})) { Import-Module ActiveDirectory }
if (!(Get-PSSnapin | where {$_.Name -match "Exchange.Management"})) { Add-PSSnapin Microsoft.Exchange.Management.* }

$ErrorActionPreference = "SilentlyContinue"
if (!(Get-ADUser -Filter {UserPrincipalName -eq $UserPrincipalName}))
{
$ReturnValue = "AD account not found."
return
}
elseif (Get-Mailbox $UserPrincipalName)
{
$ReturnValue = "Mailbox already exists."
return
}

$OU = (((Get-ADUser -Filter {UserPrincipalName -eq $UserPrincipalName} -Properties *).DistinguishedName).Split(",") | select -Skip 1 -First 1) -Replace "OU=", ""
$ABP = "$OU.ABP"

$ErrorActionPreference = "Stop"
Invoke-Command -Session $Session -ScriptBlock {
Param($UserPrincipalName,$Database,$ABP)
Enable-Mailbox $UserPrincipalName -Database $Database -Alias ($UserPrincipalName -replace "@.*", "") -AddressBookPolicy $ABP
} -ArgumentList ($UserPrincipalName,$Database,$ABP) -ErrorVariable ReturnValue


$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
$ErrorActionPreference = "SilentlyContinue"
}
until ((Get-Mailbox $UserPrincipalName) -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired during creation of Mailbox $UserPrincipalName"
return
}


$ErrorActionPreference = "Stop"
Invoke-Command -Session $Session -ScriptBlock {
Param($UserPrincipalName)
Set-Mailbox $UserPrincipalName -CustomAttribute1 ($UserPrincipalName -replace ".*@", "") -EmailAddressPolicyEnabled:$True
} -ArgumentList ($UserPrincipalName) -ErrorVariable ReturnValue

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
$ErrorActionPreference = "SilentlyContinue"
}
until ((Get-Mailbox $UserPrincipalName).CustomAttribute1 -eq ($UserPrincipalName -replace ".*@", "") -and (Get-Mailbox $UserPrincipalName).EmailAddressPolicyEnabled -eq $True -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired while setting parameters on Mailbox $UserPrincipalName"
return
}

Write-Host $ReturnValue