if (!(Get-PSSnapin | where {$_.Name -match "Exchange.Management"})) { Add-PSSnapin Microsoft.Exchange.Management.* }
$ErrorActionPreference = "Stop"
$ReturnValue = $null

$Mailboxes = Get-Mailbox -ResultSize Unlimited
#$DistributionGroups = Get-DistributionGroup -OrganizationalUnit "OU=$OUname,$OUPath"
#$Contacts = Get-MailContact -OrganizationalUnit "OU=$OUname,$OUPath"


foreach ($Mailbox in $Mailboxes)
{
$OriginalSMTPAddresses = (Get-Mailbox $Mailbox).Emailaddresses.ProxyAddressString
$OriginalSMTPAddresses > "C:\DS\OriginalSMTPAddresses\Baseline\$($Mailbox.Guid)_$(Get-Date -Format "yyyy-MM-dd_HH.mm.ss").txt"
}