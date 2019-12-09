$UserPrincipalName = "fornamn.efternamn@wemind.se"



if (!(Get-Module | where {$_.Name -match "ActiveDirectory"})) { Import-Module ActiveDirectory }
if (!(Get-PSSnapin | where {$_.Name -match "Exchange.Management"})) { Add-PSSnapin Microsoft.Exchange.Management.* }
$ReturnValue = $null
$CustomersPath = "\\emcat.com\wo-care\customers"
$OUPath = "OU=Customers,OU=Hosting2,DC=emcat,DC=com"
$ErrorActionPreference = "Stop"

$User = Get-ADUser -Filter {UserPrincipalName -eq $UserPrincipalName} -Properties *
if (!$User)
{
$ReturnValue = "User $UserPrincipalName does not exist."
return
}

$OUname = $User.Company

if (Test-Path "$CustomersPath\$OUname\Home\$($User.SamAccountName)")
{
Remove-Item "$CustomersPath\$OUname\Home\$($User.SamAccountName)" -ErrorVariable ReturnValue -Confirm:$False -Recurse:$true
}

if (Test-Path "$CustomersPath\$OUname\System\$($User.SamAccountName)")
{
Remove-Item "$CustomersPath\$OUname\System\$($User.SamAccountName)" -ErrorVariable ReturnValue -Confirm:$False -Recurse:$true
}

$ErrorActionPreference = "SilentlyContinue"

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
}
until (((!(Get-Item "$CustomersPath\$OUname\System\$($User.SamAccountName)")) -and (!(Get-Item "$CustomersPath\$OUname\Home\$($User.SamAccountName)"))) -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired while removing folders."
return
}


if ($User)
{
if ([ADSI]::Exists("LDAP://CN=ExchangeActiveSyncDevices,$($User.DistinguishedName)") -eq $True)
{
$ErrorActionPreference = "Stop"
Remove-ADObject "CN=ExchangeActiveSyncDevices,$($User.DistinguishedName)" -Confirm:$False -ErrorVariable ReturnValue

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
}
until ([ADSI]::Exists("LDAP://CN=ExchangeActiveSyncDevices,$($User.DistinguishedName)") -eq $False -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired during deletion of LDAP container 'ExchangeActiveSyncDevices' for $UserPrincipalName."
return
}
}


$ErrorActionPreference = "Stop"
Remove-ADUser $User -Confirm:$False -ErrorVariable ReturnValue

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
return
}
}
else
{
$ReturnValue = "AD account not found"
return
}


Write-Host "Rensa bort användaren $UserPrincipalName från multiOTP manuellt genom att logga in på http://10.99.196.208/multiotp.server.php" -ForegroundColor Yellow