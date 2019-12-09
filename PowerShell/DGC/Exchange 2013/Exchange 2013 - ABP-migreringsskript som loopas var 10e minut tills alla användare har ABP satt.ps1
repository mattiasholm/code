Add-PSSnapin microsoft.exchange*

while ($true)
{
$abp = "INM.ABP"
$Mailboxes = Get-Mailbox -OrganizationalUnit "emcat.com/hosting/INM" | where {$_.AdminDisplayVersion -like "*15*"}


$ErrorActionPreference = "SilentlyContinue"
Foreach ($Mailbox in $Mailboxes)
{
Set-Mailbox $Mailbox.Identity -AddressBookPolicy $abp
$mailbox = Get-Mailbox $Mailbox.Identity
$aduser = Get-ADUser $mailbox.distinguishedname -Properties *
Set-ADUser $aduser -Remove @{msexchUseOAB=$aduser.msexchuseOAB;msexchquerybasedn=$aduser.msexchquerybasedn}
}
sleep 600
}