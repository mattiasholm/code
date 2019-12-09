$MBXDbs = Get-MailboxDatabase -Status | Where-Object {$_.Mounted -eq "True"}
ForEach ($MBXDB in $MBXDbs)
{$TotalItemSize = Get-MailboxStatistics -Database $MBXDB | %{$_.TotalItemSize.Value.ToMB()} | Measure-Object -sum 
$TotalDeletedItemSize = Get-MailboxStatistics -Database $MBXDB.DistinguishedName | %{$_.TotalDeletedItemSize.Value.ToMB()} | Measure-Object -sum 
$TotalDBSize = $TotalItemSize.Sum + $TotalDeletedItemSize.Sum 
If (($TotalDBSize -lt $SmallestDBsize) -or ($SmallestDBsize -eq $null))
{$SmallestDBsize = $DBsize 
$SmallestDB = $MBXDB}}

echo $SmallestDB