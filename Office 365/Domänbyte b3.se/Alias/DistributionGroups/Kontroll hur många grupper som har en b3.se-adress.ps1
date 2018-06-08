Connect-EXOPSSession

$ErrorActionPreference = "Stop"

$Count = (Get-DistributionGroup | Where-Object {$_.EmailAddresses -like "*@b3.se*"}).Count

Write-Host "`n$Count grupper har b3.se-adress!"