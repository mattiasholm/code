$UserPrincipalName = "info@nissehult.se"



$ReturnValue = $null
if (!(Get-PSSnapin | where {$_.Name -match "Exchange.Management"})) { Add-PSSnapin Microsoft.Exchange.Management.* }

$ErrorActionPreference = "Stop"
Remove-DistributionGroup $UserPrincipalName -Confirm:$False -ErrorVariable ReturnValue

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
$ErrorActionPreference = "SilentlyContinue"
}
until (!(Get-DistributionGroup $UserPrincipalName -ErrorAction SilentlyContinue) -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired during deletion of DistributionGroup $UserPrincipalName"
return
}