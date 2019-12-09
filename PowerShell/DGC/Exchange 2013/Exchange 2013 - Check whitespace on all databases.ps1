$ReturnValue = $null
if (!(Get-PSSnapin | where {$_.Name -match "Exchange.Management"})) { Add-PSSnapin Microsoft.Exchange.Management.* }

$MailboxDatabases = Get-MailboxDatabase DB*
$WhiteSpaces = @{}
foreach ($MailboxDatabase in $MailboxDatabases)
{
$Identity = (Get-MailboxDatabase $MailboxDatabase).Name
$WhiteSpace = (Get-MailboxDatabase $MailboxDatabase -Status).AvailableNewMailboxSpace
$WhiteSpaces.$Identity += $WhiteSpace
}

$WhiteSpaces | Sort-Object -Property Value