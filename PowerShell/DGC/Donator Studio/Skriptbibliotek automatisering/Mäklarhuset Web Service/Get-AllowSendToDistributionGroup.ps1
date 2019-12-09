# Kund skickar in:
$GroupUPN = "group123456@maklarhuset.se"

# Sätts av oss:
$OrganizationalUnit = "emcat.com/Hosting/Maklarhuset"



$ReturnValue = $null
if (!(Get-PSSnapin | where {$_.Name -match "Exchange.Management"})) { Add-PSSnapin Microsoft.Exchange.Management.* }

if (Get-DistributionGroup $GroupUPN -OrganizationalUnit $OrganizationalUnit)
{
$Allowed = (Get-DistributionGroup $GroupUPN).AcceptMessagesOnlyFrom.Name
}
else
{
$ReturnValue = "DistributionGroup $GroupUPN couldn't be found."
return
}



$Allowed