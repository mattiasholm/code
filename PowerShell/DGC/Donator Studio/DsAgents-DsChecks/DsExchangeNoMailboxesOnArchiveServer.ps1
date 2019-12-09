if (!(Get-PSSnapin | where {$_.Name -match "Exchange.Management"})) { Add-PSSnapin Microsoft.Exchange.Management.* }

$MisplacedMailboxes = Get-Mailbox -Database "Archive01" | Where-Object {$_.Alias -ne "Archive01"}

if ($MisplacedMailboxes)
{
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

foreach ($MisplacedMailbox in $MisplacedMailboxes)
{
$Body = "The following Exchange 2013 mailbox incorrectly resides in an archive database: <br><br> $($MisplacedMailbox.Name) <br><br> Move the mailbox to a proper database by running the following PowerShell cmdlet in Exchange Management Shell on any Exchange 2013 server: <br><br> New-MoveRequest -Identity $($MisplacedMailbox.UserPrincipalName) -TargetDatabase $Database -BadItemLimit 1000 -PrimaryOnly"
Send-MailMessage -From "Donator <service@donator.se>" -To "DGC Göteborg Servicedesk <servicedesk-gbg@dgc.se>" -Subject "FIX: Exchange 2013 Primary Mailbox in Archive Database" -BodyAsHtml "$Body" -dno onSuccess, onFailure -smtpServer mail.emcat.com
Send-MailMessage -From "Donator <service@donator.se>" -To "Mattias Holm <mattias.holm@dgc.se>" -Subject "FIX: Exchange 2013 Primary Mailbox in Archive Database" -BodyAsHtml "$Body" -dno onSuccess, onFailure -smtpServer mail.emcat.com
}
}