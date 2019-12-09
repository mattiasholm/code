# KOLLA STORLEK PÅ EXCHANGE-DATABASER

$ReturnValue = $null
if (!(Get-PSSnapin | where {$_.Name -match "Exchange.Management"})) { Add-PSSnapin Microsoft.Exchange.Management.* }

$MailboxDatabases = Get-MailboxDatabase DB*
$ActualSizes = @{}
foreach ($MailboxDatabase in $MailboxDatabases)
{
$Identity = (Get-MailboxDatabase $MailboxDatabase).Name
$EDBSize = (Get-MailboxDatabase $MailboxDatabase -Status).DatabaseSize
$WhiteSpace = (Get-MailboxDatabase $MailboxDatabase -Status).AvailableNewMailboxSpace
$ActualSize = $EDBSize - $WhiteSpace
$ActualSizes.$Identity += $ActualSize
}

$Database = ($ActualSizes.GetEnumerator() | Sort-Object Value | Select -First 1).Name
$ActualSizes




# FÖRBERED MIGRERING GENOM ATT LÄGGA KONTON I MIGRERINGSKÖN

$Mailboxes = Get-Mailbox -OrganizationalUnit emcat.com/Hosting/Mollerstrommedical | where {$_.AdminDisplayVersion -notlike "*15*"}
$DB = "DB11"
$StartTime = "2014-10-03 00:00"
# OBS: Om Exchange 2013-migrering, se till att lägga på PrimaryOnly-flaggan på "New-MoveRequest"-cmdlet.



$guid = (Get-MailboxDatabase $DB).Guid.Guid

Foreach ($Mailbox in $Mailboxes)
{
if (Get-MoveRequest -Identity $Mailbox.Identity -ErrorAction SilentlyContinue)
{
Remove-MoveRequest $Mailbox.Identity -Confirm:$false
}
New-MoveRequest $Mailbox.Identity -TargetDatabase $guid -Confirm:$False -BadItemLimit 1000 -StartAfter $StartTime
}





# SÄTT ABP OCH RENSA OBSOLETA AD-ATTRIBUT

$Mailboxes = Get-Mailbox -OrganizationalUnit emcat.com/Hosting/Mollerstrommedical | where {$_.AdminDisplayVersion -like "*15*"}
$ABP = "Mollerst.ABP"

Foreach ($Mailbox in $Mailboxes)
{
Set-Mailbox $Mailbox.Identity -AddressBookPolicy $ABP
$mailbox = Get-Mailbox $Mailbox.Identity
$aduser = Get-ADUser $mailbox.distinguishedname -Properties *
Set-ADUser $aduser -Remove @{msexchUseOAB=$aduser.msexchuseOAB;msexchquerybasedn=$aduser.msexchquerybasedn}
}