$FilePath = "D:\Temp\Exchange2013-x64-cu12.exe"



Add-PSSnapin *Microsoft.Exchange*
$ExchangeServers = Get-ExchangeServer | where {$_.AdminDisplayVersion -like "*15*" -and $_.Name -ne "$env:COMPUTERNAME"}

foreach ($ExchangeServer in $ExchangeServers)
{
if ($ExchangeServer.ServerRole -eq "Mailbox")
{
$DestinationPath = "\\$($ExchangeServer.Name)\F$\Temp"
}
elseif ($ExchangeServer.ServerRole -eq "ClientAccess")
{
$DestinationPath = "\\$($ExchangeServer.Name)\D$\Temp"
}

Remove-Item $DestinationPath\* -Recurse -Force
xcopy $FilePath $DestinationPath /Y
Write-Host -ForegroundColor Green "File copied to $ExchangeServer"
}