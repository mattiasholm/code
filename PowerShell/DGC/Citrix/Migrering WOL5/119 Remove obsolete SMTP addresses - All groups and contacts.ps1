$OUname = "Longdrink"
$OldOuDN = "OU=Longdrink,OU=Hosting,DC=emcat,DC=com"


$ErrorActionPreference = "Stop"
if (!(Get-PSSnapin | where {$_.Name -match "Exchange.Management"})) { Add-PSSnapin Microsoft.Exchange.Management.* }
$ReturnValue = $null
$OUPath = "OU=Customers,OU=Hosting2,DC=emcat,DC=com"

$DistributionGroups = Get-DistributionGroup -OrganizationalUnit $OldOuDN
$MailContacts = Get-MailContact -OrganizationalUnit $OldOuDN


foreach ($DistributionGroup in $DistributionGroups)
{
$OriginalSMTPAddresses = (Get-DistributionGroup $DistributionGroup).Emailaddresses.ProxyAddressString
$OriginalSMTPAddresses > "C:\DS\OriginalSMTPAddresses\$($DistributionGroup.Guid)_$(Get-Date -Format "yyyy-MM-dd_HH.mm.ss").txt"


$ErrorActionPreference = "Stop"
$RemoveAddresses = @()
$RemoveAddresses += ((Get-DistributionGroup $DistributionGroup).Emailaddresses | where {$_.ProxyAddressString -like "*hostingcustomer*"}).ProxyAddressString
$RemoveAddresses += ((Get-DistributionGroup $DistributionGroup).Emailaddresses | where {$_.ProxyAddressString -like "*msxcustomer*"}).ProxyAddressString
$RemoveAddresses += ((Get-DistributionGroup $DistributionGroup).Emailaddresses | where {$_.ProxyAddressString -like "X400:*"}).ProxyAddressString

Set-DistributionGroup $DistributionGroup -EmailAddresses @{remove=$RemoveAddresses} -ErrorVariable ReturnValue
}


foreach ($MailContact in $MailContacts)
{
$OriginalSMTPAddresses = (Get-MailContact $MailContact).Emailaddresses.ProxyAddressString
$OriginalSMTPAddresses > "C:\DS\OriginalSMTPAddresses\$($MailContact.Guid)_$(Get-Date -Format "yyyy-MM-dd_HH.mm.ss").txt"


$ErrorActionPreference = "Stop"
$RemoveAddresses = @()
$RemoveAddresses += ((Get-MailContact $MailContact).Emailaddresses | where {$_.ProxyAddressString -like "*hostingcustomer*"}).ProxyAddressString
$RemoveAddresses += ((Get-MailContact $MailContact).Emailaddresses | where {$_.ProxyAddressString -like "*msxcustomer*"}).ProxyAddressString
$RemoveAddresses += ((Get-MailContact $MailContact).Emailaddresses | where {$_.ProxyAddressString -like "X400:*"}).ProxyAddressString

Set-MailContact $MailContact -EmailAddresses @{remove=$RemoveAddresses} -ErrorVariable ReturnValue
}