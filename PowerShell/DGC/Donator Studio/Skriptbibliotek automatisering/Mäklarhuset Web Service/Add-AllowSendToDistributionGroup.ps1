# Kund skickar in:
$GroupUPN = "group123456@maklarhuset.se"
$MemberUPN = "user123456@maklarhuset.se"

# Sätts av oss:
$OrganizationalUnit = "emcat.com/Hosting/Maklarhuset"



$ReturnValue = $null
if (!(Get-PSSnapin | where {$_.Name -match "Exchange.Management"})) { Add-PSSnapin Microsoft.Exchange.Management.* }

if (Get-DistributionGroup $GroupUPN -OrganizationalUnit $OrganizationalUnit)
{
if (Get-Mailbox $MemberUPN -OrganizationalUnit $OrganizationalUnit)
{
Set-DistributionGroup $GroupUPN -AcceptMessagesOnlyFrom @{add=$MemberUPN} -ErrorVariable $ReturnValue
}
else
{
$ReturnValue = "Mailbox $MemberUPN couldn't be found."
}
}
else
{
$ReturnValue = "DistributionGroup $GroupUPN couldn't be found."
}