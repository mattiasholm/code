$FilePath = "\\don-arkiv1\EnterpriseVault\Evakuering\ScriptImport\"



$ErrorActionPreference = "Stop"
$ReturnValue = $null

if (!(Get-PSSnapin | where {$_.Name -match "Exchange.Management"})) { Add-PSSnapin Microsoft.Exchange.Management.* }

$Pattern = "*.cfg"
$Files = Get-ChildItem $($FilePath)$($Pattern)

foreach ($File in $Files)
{
$LegacyExchangeDN = (Get-Content "$($FilePath)$($File)" | findstr "MAILBOXDN") -replace "MAILBOXDN = "

$Mailbox = Get-Mailbox $LegacyExchangeDN -ErrorVariable $ReturnValue
if ($Mailbox.ArchiveDatabase -eq $null)
{

if ($Mailbox.ManagedFolderMailboxPolicy -ne $null)
{
Set-Mailbox $Mailbox -ManagedFolderMailboxPolicy $null -Confirm:$False
}

Enable-Mailbox $Mailbox -Archive -ArchiveDatabase Archive01 -ErrorVariable $ReturnValue
}
else
{
"Mailbox $($Mailbox.UserPrincipalName) already has an In-Place Archive enabled on database $($Mailbox.ArchiveDatabase)."
}
}