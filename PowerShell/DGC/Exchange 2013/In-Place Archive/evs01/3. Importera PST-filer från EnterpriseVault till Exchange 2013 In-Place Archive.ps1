$FilePath = "\\evs01\EnterpriseVault\ScriptImport\"



$ErrorActionPreference = "Stop"
$ReturnValue = $null

if (!(Get-PSSnapin | where {$_.Name -match "Exchange.Management"})) { Add-PSSnapin Microsoft.Exchange.Management.* }

$Pattern = "*.cfg"

$Files = Get-ChildItem $($FilePath)$($Pattern)


foreach ($File in $Files)
{
$LegacyExchangeDN = (Get-Content "$($FilePath)$($File)" | findstr "MAILBOXDN") -replace "MAILBOXDN = "
$Mailbox = Get-Mailbox $LegacyExchangeDN -ErrorVariable $ReturnValue
$FileName = "$($FilePath)$($File)"

$ErrorActionPreference = "Stop"
New-MailboxImportRequest -Mailbox $Mailbox -IsArchive -FilePath $($FileName -replace ".cfg",".pst") -BadItemLimit 10000 -ConflictResolutionOption KeepSourceItem
}