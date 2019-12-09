Add-PSSnapin Microsoft.Exchange*

$ExchangeServers = Get-MailboxServer

foreach ($ExchangeServer in $ExchangeServers)
{
Write-Host "Restarting server: $($ExchangeServer.Name)"
Set-ServerComponentState $ExchangeServer.Name -Component HubTransport -State Draining -Requester Maintenance
Redirect-Message -Server "$ExchangeServer.Name.emcat.com" -Target don-ex-arkiv01.emcat.com -Confirm:$False
Set-ServerComponentState $ExchangeServer.Name -Component ServerWideOffline -State InActive -Requester Maintenance
Restart-Computer -ComputerName $ExchangeServer.Name -Force
}