$SamAccountName = "Mollerst.dc.svc"
$Password = "gg88TTzz"
$OUname = "Mollerst"


$OUPath = "OU=Customers,OU=Hosting2,DC=emcat,DC=com"
$objOU = [ADSI]“LDAP://OU=$OUname,$OUPath”
$UpnSuffix = $objOU.uPNSuffixes
$UserPrincipalName = "$SamAccountName@$UpnSuffix"
$ReturnValue = $null
$Name = $SamAccountName


if (!(Get-Module | where {$_.Name -match "ActiveDirectory"})) { Import-Module ActiveDirectory }

$ErrorActionPreference = "Stop"
New-ADUser -UserPrincipalName $UserPrincipalName -Path "OU=Functions,OU=$OUname,$OUPath" -AccountPassword (ConvertTo-SecureString -AsPlainText $Password -Force) -SamAccountName $SamAccountName -Name $Name -DisplayName $Name -ChangePasswordAtLogon:$True -Enabled:$True -Confirm:$False -ErrorVariable ReturnValue

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
}
until ((Get-ADUser -Filter {UserPrincipalName -eq $UserPrincipalName}) -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired during creation of Service Account $SamAccountName."
return
}