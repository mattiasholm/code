$ErrorActionPreference = "Stop"

$Count = (Get-Mailbox | Where-Object {$_.EmailAddresses -like "*@b3.se*"}).Count

Write-Host "`n$Count mailboxar har b3.se-adress!"