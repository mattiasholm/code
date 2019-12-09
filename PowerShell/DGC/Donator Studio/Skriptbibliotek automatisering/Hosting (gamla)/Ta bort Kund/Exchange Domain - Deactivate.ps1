$OU = "bixtest"
$Domain = "bixtest.se"
#$Session = ""


$ReturnValue = $null
if (!(Get-PSSnapin | where {$_.Name -match "Exchange.Management"})) { Add-PSSnapin Microsoft.Exchange.Management.* }

$ErrorActionPreference = "Stop"
Invoke-Command -Session $Session -ScriptBlock {
Param($OU,$Domain)
Remove-EmailAddressPolicy "$OU.EAP" -Confirm:$False
} -ArgumentList ($OU,$Domain) -ErrorVariable ReturnValue

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
$ErrorActionPreference = "SilentlyContinue"
}
until (!(Get-EmailAddressPolicy "$OU.EAP" -or $Timeout -le 0))

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired during deletion of EmailAddressPolicy $OUname.EAP."
return
}


$ErrorActionPreference = "Stop"
Remove-AcceptedDomain "$Domain" -Confirm:$False -ErrorVariable ReturnValue

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
$ErrorActionPreference = "SilentlyContinue"
}
until (!(Get-AcceptedDomain "$Domain" -or $Timeout -le 0))

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired during deletion of AcceptedDomain $Domain."
return
}

Write-Host $ReturnValue