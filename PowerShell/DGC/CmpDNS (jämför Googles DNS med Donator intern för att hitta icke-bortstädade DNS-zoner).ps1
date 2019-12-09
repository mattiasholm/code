<#@ECHO OFF
REM Syntax: CmpDNS [domain] [type]
:loop
cls
nslookup -q=%2 %1 8.8.8.8
PAUSE
cls
nslookup -q=%2 %1 ns1.donator.se
PAUSE
goto loop
#>



$DnsName = "exchange.donator.se"
$ResourceType = "CNAME"



$ReferenceDns = "8.8.8.8"

$LocalResolution = (Resolve-DnsName $DnsName).Name
$ReferenceResolution = (Resolve-DnsName $DnsName -Server $ReferenceDns).Name

$LocalResolution -eq $ReferenceResolution