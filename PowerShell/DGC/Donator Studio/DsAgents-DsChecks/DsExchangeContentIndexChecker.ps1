if (!(Get-PSSnapin | where {$_.Name -match "Exchange.Management"})) { Add-PSSnapin Microsoft.Exchange.Management.* }

$DBs = Get-MailboxDatabase

foreach ($DB in $DBs)
{
$State = (Get-MailboxDatabaseCopyStatus $DB).ContentIndexState
if ($State -ne "Healthy")
{
$Body = "The following Exchange 2013 database appears to have a corrupted ContentIndex (Current state: $State): <br><br> $($DB.Name) <br><br> Users on this database might not be able to search their mailboxes! <br> If there is no ongoing maintenance and this is unexpected, verify the health of the ContentIndex by running the following PowerShell code in Exchange Management Shell on $($DB.Server): <br><br>(Get-MailboxDatabaseCopyStatus -Server $($DB.Server)).ContentIndexState <br><br>If the state is 'Healthy', this was a false alarm and can be safely ignored. <br>If the state is 'Failed' or 'Unknown', reindex the database manually by running the following PowerShell code in Exchange Management Shell on $($DB.Server): <br><br>Stop-Service MSExchangeFastSearch<br>Stop-Service HostControllerService<br><br>Remove-Item `"$("$($DB.EdbFilePath.PathName)$($DB.Guid)12.1.Single" -replace "$($DB.Name).edb",`"`")`" -Recurse<br><br>Start-Service MSExchangeFastSearch<br>Start-Service HostControllerService <br><br>Verify that crawling has started with the following cmdlet: <br><br>(Get-MailboxDatabaseCopyStatus -Server $($DB.Server)).ContentIndexState <br><br>Crawling may take several hours. The state will return to 'Healthy' as soon as the crawling has completed successfully."
Send-MailMessage -From "Donator <service@donator.se>" -To "DGC Göteborg Servicedesk <servicedesk-gbg@dgc.se>" -Subject "FIX: Exchange 2013 ContentIndex $($DismountedDB.Name) corrupted" -BodyAsHtml "$Body" -dno onSuccess, onFailure -smtpServer mail.emcat.com
Send-MailMessage -From "Donator <service@donator.se>" -To "driftlarm@donator.se <driftlarm@donator.se>" -Subject "FIX: Exchange 2013 ContentIndex $($DismountedDB.Name) corrupted" -BodyAsHtml "$Body" -dno onSuccess, onFailure -smtpServer mail.emcat.com
Send-MailMessage -From "Donator <service@donator.se>" -To "Mattias Holm <mattias.holm@dgc.se>" -Subject "FIX: Exchange 2013 ContentIndex $($DismountedDB.Name) corrupted" -BodyAsHtml "$Body" -dno onSuccess, onFailure -smtpServer mail.emcat.com
}
}