$ErrorActionPreference = "Stop"
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

$SmallestDB = ($ActualSizes.GetEnumerator() | Sort-Object Value | Select -First 1).Name

$Database = (Get-MailboxDatabase $SmallestDB).Name