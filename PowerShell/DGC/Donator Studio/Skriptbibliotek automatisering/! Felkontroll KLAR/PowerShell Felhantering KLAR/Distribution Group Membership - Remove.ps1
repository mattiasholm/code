$GroupUPN = "info@nissehult.se"
$MemberUPN = "nisse.hult@nissehult.se"



if (!(Get-Module | where {$_.Name -match "ActiveDirectory"})) { Import-Module ActiveDirectory }
$ReturnValue = $null
$Type = $null

$ErrorActionPreference = "Stop"
Remove-DistributionGroupMember $GroupUPN -Member $MemberUPN -Confirm:$False -ErrorVariable ReturnValue

$Timeout = 3
do
{
sleep 1
$Timeout = $Timeout - 1
$ErrorActionPreference = "SilentlyContinue"
}
while ((Get-DistributionGroupMember $GroupUPN).PrimarySMTPAddress -like "*$MemberUPN*" -and $Timeout -gt 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired while adding principal $MemberUPN to ADGroup $GroupUPN"
return
}