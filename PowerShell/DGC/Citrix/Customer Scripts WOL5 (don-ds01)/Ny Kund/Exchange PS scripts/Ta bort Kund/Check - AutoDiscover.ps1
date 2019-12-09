$Domain = "longdrink.se"



$ReturnValue = $null
$PublicDNS = "8.8.8.8"
$ReferenceDomain = "ondonator.se"

$ErrorActionPreference = "Stop"
$ReferenceNameServers = (Resolve-DnsName -Name $ReferenceDomain -Type NS -Server $PublicDNS -ErrorVariable ReturnValue).NameHost
$ReferenceNameServer = Get-Random $ReferenceNameServers
$ReferenceNameTarget = (Resolve-DnsName -Name "_autodiscover._tcp.$ReferenceDomain" -Type SRV -Server $ReferenceNameServer -ErrorVariable ReturnValue).NameTarget

$NameServers = (Resolve-DnsName -Name $Domain -Type NS -Server $PublicDNS -ErrorVariable ReturnValue).NameHost
$NameServer = Get-Random $NameServers
$NameTarget = @()
$NameTarget += (Resolve-DnsName -Name "_autodiscover._tcp.$Domain" -Type SRV -Server $NameServer -ErrorVariable ReturnValue).NameTarget

if ($ReferenceNameTarget -eq $NameTarget)
{
$ReturnValue = "OK: Autodiscover record for $Domain is $ReferenceNameTarget."
}
else
{
$ReturnValue = "CRITICAL: Autodiscover record for $Domain is not $ReferenceNameExchange. "
}

Write-Host $ReturnValue