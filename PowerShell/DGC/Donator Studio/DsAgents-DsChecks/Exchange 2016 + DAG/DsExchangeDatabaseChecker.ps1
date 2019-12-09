if (!(Get-PSSnapin | where {$_.Name -match "Exchange.Management"})) { Add-PSSnapin Microsoft.Exchange.Management.* }

$DBs = Get-MailboxDatabaseCopyStatus *

foreach ($DB in $DBs)
{

$Status = $DB.Status
if ($Status -ne "Mounted" -and $Status -ne "Healthy")
{
$Subject = "FIX: Exchange 2016 Database $($DB.Name) Failed"
$Body = "The following Exchange 2016 database appears to have failed (Current status: $Status): <br><br> $($DB.Name) <br><br> Users on this database might not be able to access their mailboxes! <br> If there is no ongoing maintenance and this is unexpected, verify the health of the database by running the following PowerShell code in Exchange Management Shell on $($DB.Server): <br><br>(Get-MailboxDatabaseCopyStatus $($DB.Name)).Status <br><br>If the state is 'Healthy' or 'Mounted', this was a false alarm and can be safely ignored. <br>If the state is 'Failed' or 'Unknown', make sure that the database is mounted and / or reseed the database manually: <br>https://technet.microsoft.com/en-us/library/dd351100(v=exchg.160).aspx"

Send-MailMessage -From "Donator <service@donator.se>" -To "DGC Göteborg Servicedesk <servicedesk-gbg@dgc.se>" -Subject $Subject -BodyAsHtml "$Body" -dno onSuccess, onFailure -smtpServer mail.emcat.com
Send-MailMessage -From "Donator <service@donator.se>" -To "driftlarm@donator.se <driftlarm@donator.se>" -Subject $Subject -BodyAsHtml "$Body" -dno onSuccess, onFailure -smtpServer mail.emcat.com
Send-MailMessage -From "Donator <service@donator.se>" -To "Bix <bix@dgc.se>" -Subject $Subject -BodyAsHtml "$Body" -dno onSuccess, onFailure -smtpServer mail.emcat.com
}
}

foreach ($DB in $DBs)
{

$State = $DB.ContentIndexState
if ($State -ne "Healthy")
{
sleep 300
$State = (Get-MailboxDatabaseCopyStatus $DB.Name).ContentIndexState

if ($State -ne "Healthy")
{
$Subject = "FIX: Exchange 2016 ContentIndex $($DB.Name) corrupted"
$Body = "The following Exchange 2016 database appears to have a corrupted ContentIndex (Current state: $State): <br><br> $($DB.Name) <br><br> Users on this database might not be able to search their mailboxes! <br> If there is no ongoing maintenance and this is unexpected, verify the health of the ContentIndex by running the following PowerShell code in Exchange Management Shell on $($DB.Server): <br><br>(Get-MailboxDatabaseCopyStatus $($DB.Name)).ContentIndexState <br><br>If the state is 'Healthy', this was a false alarm and can be safely ignored. <br>If the state is 'Failed' or 'Unknown', reseed the database manually: <br>https://technet.microsoft.com/en-us/library/ee633475(v=exchg.150).aspx"

Send-MailMessage -From "Donator <service@donator.se>" -To "DGC Göteborg Servicedesk <servicedesk-gbg@dgc.se>" -Subject $Subject -BodyAsHtml "$Body" -dno onSuccess, onFailure -smtpServer mail.emcat.com
Send-MailMessage -From "Donator <service@donator.se>" -To "driftlarm@donator.se <driftlarm@donator.se>" -Subject $Subject -BodyAsHtml "$Body" -dno onSuccess, onFailure -smtpServer mail.emcat.com
Send-MailMessage -From "Donator <service@donator.se>" -To "Bix <bix@dgc.se>" -Subject $Subject -BodyAsHtml "$Body" -dno onSuccess, onFailure -smtpServer mail.emcat.com
}
}

}