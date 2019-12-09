$OUname = "Longdrink"



$ErrorActionPreference = "Stop"
if (!(Get-PSSnapin | where {$_.Name -match "Exchange.Management"})) { Add-PSSnapin Microsoft.Exchange.Management.* }
$ReturnValue = $null
$OUPath = "OU=Customers,OU=Hosting2,DC=emcat,DC=com"

$Mailboxes = Get-Mailbox -OrganizationalUnit "OU=$OUname,$OUPath"
$DistributionGroups = Get-DistributionGroup -OrganizationalUnit "OU=$OUname,$OUPath"
$MailContacts = Get-MailContact -OrganizationalUnit "OU=$OUname,$OUPath"


foreach ($Mailbox in $Mailboxes)
{
$ErrorActionPreference = "Stop"
$OriginalSMTPAddresses = @()
$OriginalSMTPAddresses += (Get-Item "C:\DS\OriginalSMTPAddresses\$($Mailbox.Guid)_*" | select -First 1 | Get-Content)

$CurrentSMTPAddresses = @()
$CurrentSMTPAddresses = (Get-Mailbox $Mailbox).Emailaddresses.ProxyAddressString

foreach ($CurrentSMTPAddress in $CurrentSMTPAddresses)
{
$OriginalSMTPAddresses = $OriginalSMTPAddresses -replace "$CurrentSMTPAddress",$null
}
$OriginalSMTPAddresses = $OriginalSMTPAddresses -notlike ""

if ((Get-Mailbox $Mailbox).EmailAddresses | where {$_.ProxyAddressString -like "X500:*"})
{
$OriginalSMTPAddresses = $OriginalSMTPAddresses -notlike "X500:*"
}

foreach ($OriginalSMTPAddress in $OriginalSMTPAddresses)
{
$ErrorActionPreference = "Stop"
$Mailbox.EmailAddresses += $OriginalSMTPAddress
}
Set-Mailbox $Mailbox -EmailAddresses $Mailbox.EmailAddresses
}


foreach ($DistributionGroup in $DistributionGroup)
{
$ErrorActionPreference = "Stop"
$OriginalSMTPAddresses = @()
$OriginalSMTPAddresses += (Get-Item "C:\DS\OriginalSMTPAddresses\$($DistributionGroup.Guid)_*" | select -First 1 | Get-Content)

$CurrentSMTPAddresses = @()
$CurrentSMTPAddresses = (Get-DistributionGroup $DistributionGroup).Emailaddresses.ProxyAddressString

foreach ($CurrentSMTPAddress in $CurrentSMTPAddresses)
{
$OriginalSMTPAddresses = $OriginalSMTPAddresses -replace "$CurrentSMTPAddress",$null
}
$OriginalSMTPAddresses = $OriginalSMTPAddresses -notlike ""

if ((Get-Mailbox $Mailbox).EmailAddresses | where {$_.ProxyAddressString -like "X500:*"})
{
$OriginalSMTPAddresses = $OriginalSMTPAddresses -notlike "X500:*"
}

foreach ($OriginalSMTPAddress in $OriginalSMTPAddresses)
{
$ErrorActionPreference = "Stop"
$DistributionGroup.EmailAddresses += $OriginalSMTPAddress
}
Set-DistributionGroup $DistributionGroup -EmailAddresses $DistributionGroup.EmailAddresses
}


foreach ($MailContact in $MailContacts)
{
$ErrorActionPreference = "Stop"
$OriginalSMTPAddresses = @()
$OriginalSMTPAddresses += (Get-Item "C:\DS\OriginalSMTPAddresses\$($MailContact.Guid)_*" | select -First 1 | Get-Content)

$CurrentSMTPAddresses = @()
$CurrentSMTPAddresses = (Get-MailContact $MailContact).Emailaddresses.ProxyAddressString

foreach ($CurrentSMTPAddress in $CurrentSMTPAddresses)
{
$OriginalSMTPAddresses = $OriginalSMTPAddresses -replace "$CurrentSMTPAddress",$null
}
$OriginalSMTPAddresses = $OriginalSMTPAddresses -notlike ""

if ((Get-Mailbox $Mailbox).EmailAddresses | where {$_.ProxyAddressString -like "X500:*"})
{
$OriginalSMTPAddresses = $OriginalSMTPAddresses -notlike "X500:*"
}

foreach ($OriginalSMTPAddress in $OriginalSMTPAddresses)
{
$ErrorActionPreference = "Stop"
$MailContact.EmailAddresses += $OriginalSMTPAddress
}
Set-MailContact $MailContact -EmailAddresses $MailContact.EmailAddresses
}