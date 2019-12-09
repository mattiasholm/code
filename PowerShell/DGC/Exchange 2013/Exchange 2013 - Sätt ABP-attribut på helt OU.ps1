$abp = "SBK.ABP"
$Mailboxes = Get-Mailbox -OrganizationalUnit SBK | where {$_.AdminDisplayVersion -like "*15*"}

Foreach ($Mailbox in $Mailboxes)
{
Set-Mailbox $Mailbox.Identity -AddressBookPolicy $abp
$mailbox = Get-Mailbox $Mailbox.Identity
$aduser = Get-ADUser $mailbox.distinguishedname -Properties *
Set-ADUser $aduser -Remove @{msexchUseOAB=$aduser.msexchuseOAB;msexchquerybasedn=$aduser.msexchquerybasedn}
}