# Kund skickar in:
$GroupUPN = "group123456@maklarhuset.se"

# Sätts av oss:
$OrganizationalUnit = "emcat.com/Hosting/Maklarhuset"



$ReturnValue = $null
if (!(Get-PSSnapin | where {$_.Name -match "Exchange.Management"})) { Add-PSSnapin Microsoft.Exchange.Management.* }

Get-DistributionGroup $GroupUPN -OrganizationalUnit $OrganizationalUnit -ErrorVariable $ReturnValue | Remove-DistributionGroup -Confirm:$False -ErrorVariable $ReturnValue