if (!(Get-PSSnapin | where {$_.Name -match "Exchange.Management"})) { Add-PSSnapin Microsoft.Exchange.Management.* }


$Username = "emcat\ds.svc"
$Password = "AA11AAss" | ConvertTo-SecureString -asPlainText -Force
$UserCredential = New-Object System.Management.Automation.PSCredential($Username,$Password)
$ExchangeServers = Get-ExchangeServer | where {$_.AdminDisplayVersion -like "*15*" -and $_.ServerRole -eq "ClientAccess"}
$ExchangeServer = Get-Random ($ExchangeServers)
$ReturnValue = $null

$ErrorActionPreference = "Stop"
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri "http://$($ExchangeServer.Name)/PowerShell/" -Authentication Kerberos -Credential $UserCredential -ErrorVariable ReturnValue
Import-PSSession $Session -AllowClobber