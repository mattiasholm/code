# # # ALT 1:

$StartDate = Get-Date
$Timeout = [System.TimeSpan]::FromSeconds(30)

while ($StartDate + $Timeout -gt (Get-Date))
{
    Write-Host -Object 'Timeout not reached'
    Start-Sleep -Seconds 3
}

Write-Host -Object 'Timeout reached'



# # # ALT 2:
$Timeout = (Get-Date).AddSeconds(30)

while ($Timeout -gt (Get-Date))
{
    Write-Host -Object 'Timeout not reached'
    Start-Sleep -Seconds 3
}

Write-Host -Object 'Timeout reached'



# # # ALT 3:
$Timer = [System.Diagnostics.Stopwatch]::StartNew()

while ($Timer.Elapsed -lt [System.TimeSpan]::FromSeconds(30))
{
    Write-Host -Object 'Timeout not reached'
    Start-Sleep -Seconds 3
}

Write-Host -Object 'Timeout reached'
$Timer.Stop()



# # # ALT 4:
$Timeout = 30
$Timer = [System.Diagnostics.Stopwatch]::StartNew()

while ($Timer.Elapsed.Seconds -lt $Timeout)
{
    Write-Host -Object 'Timeout not reached'
    Start-Sleep -Seconds 3
}

Write-Host -Object 'Timeout reached'
$Timer.Stop()
throw 'Action did not complete before timeout period.'