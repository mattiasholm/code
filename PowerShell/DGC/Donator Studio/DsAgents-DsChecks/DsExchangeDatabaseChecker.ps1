if (!(Get-PSSnapin | where {$_.Name -match "Exchange.Management"})) { Add-PSSnapin Microsoft.Exchange.Management.* }

$DBs = Get-MailboxDatabase -Status
$ActiveDBs = @()

foreach ($DB in $DBs)
{
if (Get-Mailbox -Database $DB)
{
$ActiveDBs += $DB
}
}

$DismountedDBs = $ActiveDBs | Where-Object {$_.Mounted -eq $False}

if ($DismountedDBs)
{
foreach ($DismountedDB in $DismountedDBs)
{
$Body = "The following Exchange 2013 database appears to be dismounted: <br><br> $($DismountedDB.Name) <br><br> Users on this database might not able to access their mailboxes! <br> If there is no ongoing maintenance and this is unexpected, verify the Mount Status by running the following PowerShell cmdlet in Exchange Management Shell on $($DismountedDB.Server): <br><br>Get-MailboxDatabase $($DismountedDB.Name) -Status | Select-Object Mounted <br><br>If the property Mounted is set to True, this was a false-positive and can be safely ignored.<br>If the property Mounted is set to False, mount the database manually by running the following PowerShell cmdlet in Exchange Management Shell on $($DismountedDB.Server): <br><br>Mount-Database $($DismountedDB.Name)"
Send-MailMessage -From "Donator <service@donator.se>" -To "DGC Göteborg Servicedesk <servicedesk-gbg@dgc.se>" -Subject "CRITICAL - Exchange 2013 database $($DismountedDB.Name) dismounted" -BodyAsHtml "$Body" -dno onSuccess, onFailure -smtpServer mail.emcat.com
Send-MailMessage -From "Donator <service@donator.se>" -To "driftlarm@donator.se <driftlarm@donator.se>" -Subject "CRITICAL - Exchange 2013 database $($DismountedDB.Name) dismounted" -BodyAsHtml "$Body" -dno onSuccess, onFailure -smtpServer mail.emcat.com
Send-MailMessage -From "Donator <service@donator.se>" -To "Mattias Holm <mattias.holm@dgc.se>" -Subject "CRITICAL - Exchange 2013 database $($DismountedDB.Name) dismounted" -BodyAsHtml "$Body" -dno onSuccess, onFailure -smtpServer mail.emcat.com
}
}