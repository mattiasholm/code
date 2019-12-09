$FilePath = "C:\Temp\vht.local_unicode.csv"
$Delimiter = ","
$OuName = "Kvarters"
$ExchangeDatabase = "DB11"



$ErrorActionPreference = "Stop"
if (!(Get-PSSnapin | where {$_.Name -match "Exchange.Management"})) { Add-PSSnapin Microsoft.Exchange.Management.* }
$CsvUsers = Import-CSV $FilePath -Delimiter "$Delimiter"
$SearchBase = Get-ADOrganizationalUnit -Filter {Name -eq $OuName}
$ABP = "$OuName.ABP"

$ADUsers = Get-ADUser -SearchBase $SearchBase -Filter *

foreach ($ADUser in $ADUsers)
{
if ($CsvUsers | where {$_.PrimarySmtpAddress -eq $ADUser.UserPrincipalName})
{
$CsvUser = $CsvUsers | where {$_.PrimarySmtpAddress -eq $ADUser.UserPrincipalName}

Enable-Mailbox $ADUser.UserPrincipalName -Database $ExchangeDatabase -Alias ($ADUser.UserPrincipalName -replace "@.*", "") -AddressBookPolicy $ABP

$LegacyExchangeDN = $CsvUser.LegacyExchangeDN
$X500 = "X500:$LegacyExchangeDN"


$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
$ErrorActionPreference = "SilentlyContinue"
}
until ((Get-Mailbox $ADUser.UserPrincipalName) -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired during creation of Mailbox $UserPrincipalName"
return
}


Set-Mailbox $ADUser.UserPrincipalName -CustomAttribute1 ($ADUser.UserPrincipalName -replace ".*@", "") -EmailAddressPolicyEnabled:$True -Emailaddresses @{add=$X500}
}


else
{
Enable-Mailbox $ADUser.UserPrincipalName -Database $ExchangeDatabase -Alias ($ADUser.UserPrincipalName -replace "@.*", "") -AddressBookPolicy $ABP

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
$ErrorActionPreference = "SilentlyContinue"
}
until ((Get-Mailbox $ADUser.UserPrincipalName) -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired during creation of Mailbox $UserPrincipalName"
return
}


Set-Mailbox $ADUser.UserPrincipalName -CustomAttribute1 ($ADUser.UserPrincipalName -replace ".*@", "") -EmailAddressPolicyEnabled:$True
}
}