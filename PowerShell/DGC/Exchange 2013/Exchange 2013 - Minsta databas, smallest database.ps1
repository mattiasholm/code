# Kontrollera storlek på storleksbasis:

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
$ActualSizes | Sort-Object -Property Value





# Kontrollera storlek på användarbasis:

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

$UserCounts