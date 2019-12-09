$GroupUPN = "info@nissehult.se"
$MemberUPN = "nisse.hult@nissehult.se"



if (!(Get-Module | where {$_.Name -match "ActiveDirectory"})) { Import-Module ActiveDirectory }
if (!(Get-PSSnapin | where {$_.Name -match "Exchange.Management"})) { Add-PSSnapin Microsoft.Exchange.Management.* }
$ReturnValue = $null
$Type = $null

$ErrorActionPreference = "Stop"
Add-DistributionGroupMember $GroupUPN -Member $MemberUPN -ErrorVariable ReturnValue

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
$ErrorActionPreference = "SilentlyContinue"
}
until ((Get-DistributionGroupMember $GroupUPN).SamAccountName -like (Get-ADUser -Filter {UserPrincipalName -eq $MemberUPN}).SamAccountName -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired while adding principal $MemberUPN to ADGroup $GroupUPN"
return
}