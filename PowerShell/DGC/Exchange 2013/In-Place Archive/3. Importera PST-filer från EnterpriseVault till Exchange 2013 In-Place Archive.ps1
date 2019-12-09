$FilePath = "\\evs01\EnterpriseVault\ScriptImport\"
$FilePath = "\\don-arkiv1\EnterpriseVault\Evakuering\ScriptImport\"



if (!(Test-Path "$FilePath\Started"))
{
New-Item -ItemType Directory -Name "Started" -Path $FilePath
}


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
Move-Item -Path $($FileName -replace ".cfg","*") -Destination "$($FilePath)Started" -ErrorVariable $ReturnValue

$FileName = $FileName -replace "ScriptImport","ScriptImport\Started"

if (Get-MailboxImportRequest -Mailbox $Mailbox | where {$_.FilePath -eq $($FileName -replace ".cfg",".pst")} | where {$_.Status -ne "InProgress"})
{
$MailboxImport = Get-MailboxImportRequest -Mailbox $Mailbox | where {$_.FilePath -eq $($FileName -replace ".cfg",".pst") -and $_.Status -ne "InProgress"}
Remove-MailboxImportRequest $MailboxImport.Identity -Confirm:$False
}

New-MailboxImportRequest -Mailbox $Mailbox -IsArchive -FilePath $($FileName -replace ".cfg",".pst") -BadItemLimit 10000 -ConflictResolutionOption KeepSourceItem
}