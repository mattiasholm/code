$FilePath = "\\evs01\EnterpriseVault\"



$ErrorActionPreference = "Stop"
$ReturnValue = $null
$Count = 0


if (!(Test-Path "$FilePath\DeletedAccounts"))
{
New-Item -ItemType Directory -Name "DeletedAccounts" -Path $FilePath
}

if (!(Test-Path "$FilePath\ScriptImport"))
{
New-Item -ItemType Directory -Name "ScriptImport" -Path $FilePath
}


if (!(Get-PSSnapin | where {$_.Name -match "Exchange.Management"})) { Add-PSSnapin Microsoft.Exchange.Management.* }

$Pattern = "*.cfg"
$Files = Get-ChildItem $($FilePath)$($Pattern)

foreach ($File in $Files)
{
$LegacyExchangeDN = (Get-Content "$($FilePath)$($File)" | findstr "MAILBOXDN") -replace "MAILBOXDN = "

try
{
Get-Mailbox $LegacyExchangeDN
}
catch
{
$FileName = "$($FilePath)$($File)"
Write-Host "Cannot find mailbox, corresponding files will be moved."
Move-Item -Path $($FileName -replace ".cfg","*") -Destination "$($FilePath)DeletedAccounts" -ErrorVariable $ReturnValue

$Count = $Count + 1
}
}

if ($Count -eq 0)
{
Write-Host "All mailboxes for the specified PST files were found."
}
else
{
Write-Host "$Count mailbox(es) could not be found. The corresponding files have been moved to the directory $($FilePath)DeletedAccounts for manual handling."
}