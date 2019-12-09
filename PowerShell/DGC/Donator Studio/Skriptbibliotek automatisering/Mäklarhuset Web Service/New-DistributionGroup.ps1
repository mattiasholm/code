# Kund skickar in:
$GroupUPN = "group123456@maklarhuset.se"
$ReceiveFromInternet = $True
$SubOU = "MH.Ahus"

# Sätts av oss:
$OrganizationalUnit = "emcat.com/Hosting/Maklarhuset"



$ReturnValue = $null
if (!(Get-PSSnapin | where {$_.Name -match "Exchange.Management"})) { Add-PSSnapin Microsoft.Exchange.Management.* }

New-DistributionGroup $GroupUPN -PrimarySmtpAddress $GroupUPN -OrganizationalUnit "$OrganizationalUnit/$SubOU" -ErrorVariable $ReturnValue

if ($ReceiveFromInternet = $True)
{
Set-DistributionGroup $GroupUPN -RequireSenderAuthenticationEnabled $False
}