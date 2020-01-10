$DNS = 'B3CARE-NL-AD01.ad.b3care.se'
$DHCP = 'B3CARE-SE-AD01.ad.b3care.se'

$Zones = Get-DnsServerZone -ComputerName $DNS | Where-Object {$_.ZoneType -eq "Primary" -and $_.IsReverseLookupZone -eq $false}
$DNSIP = $Zones | ForEach-Object {Get-DnsServerResourceRecord -ComputerName $DNS -ZoneName $_.ZoneName | Where-Object {$_.RecordType -eq "A"} | Select-Object @{Name="IP Address";Expression={$_.RecordData.IPv4Address}}, @{Name="Device Name";Expression={$_.HostName}}, @{Name="Assignment Date";Expression={$_.TimeStamp}}, @{Name="Expiry Date";Expression={$_.TimeToLive + $_.TimeStamp}}}
$DHCPIP = Get-DhcpServerv4Scope -ComputerName $DHCP | ForEach-Object {Get-DhcpServerv4Lease -ComputerName $DHCP -ScopeId $_.ScopeId | Select-Object @{Name="IP Address";Expression={$_.IpAddress}}, @{Name="MAC Address";Expression={$_.ClientId}}, @{Name="Device Name";Expression={$_.HostName}}, @{Name="Expiry Date";Expression={$_.LeaseExpiryTime}}, @{Name="Description";Expression={$_.Description}}, @{Name="Assignment Type";Expression="Dynamic"}}
$IPs = @()
foreach ($IP in $DNSIP)
{
    if (!($DHCPIP."IP Address" -contains $IP."IP Address"))
    {
        $IPs += $IP
    }
}
$IPs |  Export-Csv -Path $env:TEMP\DnsIpamImport.csv -NoTypeInformation -Force
Import-IpamAddress -Path $env:TEMP\DnsIpamImport.csv -AddressFamily IPv4 -Force