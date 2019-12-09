Import-Module ActiveDirectory
Add-PSSnapin Microsoft.Exchange.Management.PowerShell.Admin

$Path = Read-Host "Enter path to CSV file"
Get-Content "$Path" > "$Path.tmp"

$Delimiter = Read-Host "Enter delimiter character used in CSV file"
$Mailboxes = Import-CSV "$Path.tmp" -Delimiter "$Delimiter"

Foreach ($Mailbox in $Mailboxes)
{

# Get the smallest database available:
$MBXDbs = Get-MailboxDatabase -Status | Where-Object {$_.Mounted -eq "True"}
ForEach ($MBXDB in $MBXDbs)
{$TotalItemSize = Get-MailboxStatistics -Database $MBXDB | %{$_.TotalItemSize.Value.ToMB()} | Measure-Object -sum 
$TotalDeletedItemSize = Get-MailboxStatistics -Database $MBXDB.DistinguishedName | %{$_.TotalDeletedItemSize.Value.ToMB()} | Measure-Object -sum 
$TotalDBSize = $TotalItemSize.Sum + $TotalDeletedItemSize.Sum 
If (($TotalDBSize -lt $SmallestDBsize) -or ($SmallestDBsize -eq $null))
{$SmallestDBsize = $DBsize 
$SmallestDB = $MBXDB}}


New-Mailbox -Password (ConvertTo-SecureString -AsPlainText "$Mailbox.Password" -Force) -Database "$SmallestDB" -OrganizationalUnit "$Mailbox.OU" -FirstName "$Mailbox.FirstName" -LastName "$Mailbox.LastName" -SamAccountName "$Mailbox.SamAccountName" -UserPrincipalName "$Mailbox.UserPrincipalName" -Alias "$Mailbox.SamAccountName" -Name "$Mailbox.Name" -DisplayName "$Mailbox.Name" -Confirm:$false

Remove-Item "$Path.tmp"
}