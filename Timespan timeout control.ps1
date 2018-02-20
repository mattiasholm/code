$StartDate = Get-Date
$Timeout = [System.TimeSpan]::FromSeconds(30)

while ($StartDate + $Timeout -gt (Get-Date))
{
    Write-Host -Object "Timeout not reached"
    Start-Sleep -Seconds 3
}

Write-Host -Object "Timeout reached"