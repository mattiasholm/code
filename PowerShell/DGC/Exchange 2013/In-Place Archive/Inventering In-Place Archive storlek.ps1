if (!(Get-PSSnapin | where {$_.Name -match "Exchange.Management"})) { Add-PSSnapin Microsoft.Exchange.Management.* }
$Archives = Get-Mailbox -Archive

$List = @{}

foreach ($Archive in $Archives)
{
$UserPrincipalName = $Archive.UserPrincipalName
$TotalItemSize = ($Archive | Get-MailboxStatistics).TotalItemSize

$List.$UserPrincipalName += $TotalItemSize
}

$List