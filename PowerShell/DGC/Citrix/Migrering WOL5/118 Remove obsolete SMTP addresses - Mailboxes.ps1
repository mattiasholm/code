$OUname = "Donator"



$ErrorActionPreference = "Stop"
if (!(Get-PSSnapin | where {$_.Name -match "Exchange.Management"})) { Add-PSSnapin Microsoft.Exchange.Management.* }
$ReturnValue = $null
$OUPath = "OU=Customers,OU=Hosting2,DC=emcat,DC=com"
$MigrationGroup = "$OUname.WO.ToBeMigrated"
$Users = Get-ADGroupMember $MigrationGroup

foreach ($User in $Users)
{
$Mailbox = Get-Mailbox $User.SamAccountName

$OriginalSMTPAddresses = (Get-Mailbox $Mailbox).Emailaddresses.ProxyAddressString
$OriginalSMTPAddresses > "C:\DS\OriginalSMTPAddresses\$($Mailbox.Guid)_$(Get-Date -Format "yyyy-MM-dd_HH.mm.ss").txt"


$ErrorActionPreference = "Stop"
$RemoveAddresses = @()
$RemoveAddresses += ((Get-Mailbox $Mailbox).Emailaddresses | where {$_.ProxyAddressString -like "*hostingcustomer*"}).ProxyAddressString
$RemoveAddresses += ((Get-Mailbox $Mailbox).Emailaddresses | where {$_.ProxyAddressString -like "*msxcustomer*"}).ProxyAddressString
$RemoveAddresses += ((Get-Mailbox $Mailbox).Emailaddresses | where {$_.ProxyAddressString -like "X400:*"}).ProxyAddressString

Set-Mailbox $Mailbox -EmailAddresses @{remove=$RemoveAddresses} -ErrorVariable ReturnValue
}