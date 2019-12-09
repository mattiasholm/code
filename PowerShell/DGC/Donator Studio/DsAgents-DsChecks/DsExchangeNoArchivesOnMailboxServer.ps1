if (!(Get-PSSnapin | where {$_.Name -match "Exchange.Management"})) { Add-PSSnapin Microsoft.Exchange.Management.* }

$MisplacedArchives = Get-Mailbox -Archive | Where-Object {$_.ArchiveDatabase -ne "Archive01"}

foreach ($MisplacedArchive in $MisplacedArchives)
{
$Body = "The following Exchange 2013 archive incorrectly resides in a mailbox database: <br><br> $($MisplacedArchive.Name) <br><br> Move the archive to an archive database by running the following PowerShell cmdlet in Exchange Management Shell on $($MisplacedArchive.ServerName): <br><br> New-MoveRequest -Identity $($MisplacedArchive.UserPrincipalName) -ArchiveTargetDatabase Archive01 -BadItemLimit 1000 -ArchiveOnly"
Send-MailMessage -From "Donator <service@donator.se>" -To "DGC Göteborg Servicedesk <servicedesk-gbg@dgc.se>" -Subject "FIX: Exchange 2013 Archive in Mailbox Database" -BodyAsHtml "$Body" -dno onSuccess, onFailure -smtpServer mail.emcat.com
Send-MailMessage -From "Donator <service@donator.se>" -To "Mattias Holm <mattias.holm@dgc.se>" -Subject "FIX: Exchange 2013 Archive in Mailbox Database" -BodyAsHtml "$Body" -dno onSuccess, onFailure -smtpServer mail.emcat.com
}