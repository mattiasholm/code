#!/usr/bin/env pwsh

$Port = 22
$NetworkPrefix = '10.0.30.'
$FirstIp = "1"
$LastIp = "254"

$IpArray = $FirstIp..$LastIp

foreach ($Ip in $IpArray) {
    $Test = Test-NetConnection -ComputerName $NetworkPrefix$Ip -Port $Port
    if ($Test.TcpTestSucceeded -eq $true) {
        Write-Host -ForegroundColor Green -Object "$($Test.RemoteAddress) is reachable on port $Port"
    }
    else {
        Write-Host -ForegroundColor Red -Object "$($Test.RemoteAddress) is not reachable on port $Port"
    }
}


# # # OBS: Snabbare variant:
New-Object System.Net.Sockets.TCPClient -ArgumentList $NetworkPrefix$Ip, $Port