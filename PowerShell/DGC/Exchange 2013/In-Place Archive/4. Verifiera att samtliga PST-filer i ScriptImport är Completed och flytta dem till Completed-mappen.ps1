$FilePath = "\\evs01\EnterpriseVault\ScriptImport\Started\"
#$FilePath = "\\don-arkiv1\EnterpriseVault\Evakuering\ScriptImport\Started\"



if (!(Test-Path "$FilePath\Completed"))
{
New-Item -ItemType Directory -Name "Completed" -Path $FilePath
}

$ErrorActionPreference = "Stop"
$ReturnValue = $null
$Count = 0

if (!(Get-PSSnapin | where {$_.Name -match "Exchange.Management"})) { Add-PSSnapin Microsoft.Exchange.Management.* }

$Pattern = "*.cfg"

$Files = Get-ChildItem $($FilePath)$($Pattern)


foreach ($File in $Files)
{
$LegacyExchangeDN = (Get-Content "$($FilePath)$($File)" | findstr "MAILBOXDN") -replace "MAILBOXDN = "
$Mailbox = Get-Mailbox $LegacyExchangeDN -ErrorVariable $ReturnValue
$FileName = "$($FilePath)$($File)"

$ErrorActionPreference = "Stop"
$MailboxImportRequest = Get-MailboxImportRequest -Mailbox $Mailbox | where {$_.FilePath -eq $($FileName -replace ".cfg",".pst")}

if ($MailboxImportRequest.Status -ne "Completed")
{
Write-Host "Import of $($File.Name) to Mailbox $($Mailbox.UserPrincipalName) has not completed yet."
$Count = $Count + 1
}
elseif ($MailboxImportRequest.Status -eq "Completed")
{
Write-Host "Import complete. Files will be moved to $($FilePath)Completed"
$ErrorActionPreference = "Stop"
Move-Item -Path $($FileName -replace ".cfg","*") -Destination "$($FilePath)Completed" -ErrorVariable $ReturnValue
}
}

if ($Count -eq 0)
{
Write-Host "All PST files in $FilePath have been imported to their corresponding Mailboxes."
}
else
{
Write-Host "$Count PST file(s) are still being imported to their corresponding Mailboxes."
}