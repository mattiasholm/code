$Domain = "piglift.se"



$ReturnValue = $null
$PublicDNS = "8.8.8.8"
$ReferenceDomain = "ondonator.se"

$ErrorActionPreference = "Stop"
$ReferenceNameServers = (Resolve-DnsName -Name $ReferenceDomain -Type NS -Server $PublicDNS -ErrorVariable ReturnValue).NameHost
$ReferenceNameServer = Get-Random $ReferenceNameServers
$ReferenceNameExchange = (Resolve-DnsName -Name $ReferenceDomain -Type MX -Server $ReferenceNameServer -ErrorVariable ReturnValue | Sort-Object -Property Preference | select -First 1).NameExchange

$NameServers = (Resolve-DnsName -Name $Domain -Type NS -Server $PublicDNS -ErrorVariable ReturnValue).NameHost
$NameServer = Get-Random $NameServers
$HighestPreference = (Resolve-DnsName -Name $Domain -Type MX -Server $NameServer -ErrorVariable ReturnValue | Sort-Object -Property Preference | select -First 1).Preference
$NameExchanges = @()
$NameExchanges += (Resolve-DnsName -Name $Domain -Type MX -Server $NameServer -ErrorVariable ReturnValue | where {$_.Preference -eq $HighestPreference}).NameExchange

$bool = @()
foreach ($NameExchange in $NameExchanges)
{
$bool += ($NameExchange -eq $ReferenceNameExchange)
}

if ($bool -contains $True -and $bool -contains $False)
{
$ReturnValue = "CRITICAL: Other MX record(s) with equal priority as $ReferenceNameExchange was found for $Domain."
}
elseif ($bool -contains $False)
{
$ReturnValue = "CRITICAL: MX record for $Domain is not $ReferenceNameExchange. "
}
else
{
$NameExchanges = @()
$NameExchanges = (Resolve-DnsName -Name $Domain -Type MX -Server $NameServer -ErrorVariable ReturnValue).NameExchange

$bool = @()
foreach ($NameExchange in $NameExchanges)
{
$bool += ($NameExchange -eq $ReferenceNameExchange)
}

if ($bool -contains $False)
{
$ReturnValue = "WARNING: Other MX record(s) with lower priority than $ReferenceNameExchange was found for $Domain."
}
elseif ($bool -contains $True)
{
$ReturnValue = "OK: MX record for $Domain is $ReferenceNameExchange."
}
}

Write-Host $ReturnValue