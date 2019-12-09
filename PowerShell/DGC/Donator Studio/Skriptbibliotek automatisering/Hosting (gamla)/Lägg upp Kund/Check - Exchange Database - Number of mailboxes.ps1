$ReturnValue = $null
if (!(Get-PSSnapin | where {$_.Name -match "Exchange.Management"})) { Add-PSSnapin Microsoft.Exchange.Management.* }

$MailboxDatabases = Get-MailboxDatabase DB*
$UserCounts = @{}
foreach ($MailboxDatabase in $MailboxDatabases)
{
$Identity = (Get-MailboxDatabase $MailboxDatabase).Name
$UserCount = (Get-Mailbox -Database $MailboxDatabase | measure).Count
$UserCounts.$Identity += $UserCount
}

$LeastUsers = ($UserCounts.GetEnumerator() | Sort-Object Value | Select -First 1).Name

$Database = (Get-MailboxDatabase $LeastUsers).Name