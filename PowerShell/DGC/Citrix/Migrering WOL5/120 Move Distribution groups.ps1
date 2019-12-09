$OUname = "Longdrink"
$Domain = "longdrink.se"
$OldOuDN = "OU=Longdrink,OU=Hosting,DC=emcat,DC=com"



if (!(Get-Module | where {$_.Name -match "ActiveDirectory"})) { Import-Module ActiveDirectory }
if (!(Get-PSSnapin | where {$_.Name -match "Exchange.Management"})) { Add-PSSnapin Microsoft.Exchange.Management.* }
$ErrorActionPreference = "Stop"
$ReturnValue = $null
$OUPath = "OU=Customers,OU=Hosting2,DC=emcat,DC=com"
$OU = Get-ADOrganizationalUnit "OU=$OUname,$OUPath"
$wsDS = New-WebServiceProxy 'http://donator-app1.emcat.com/DSSupportWS/DS.asmx?WSDL'

$Groups = Get-DistributionGroup -OrganizationalUnit $OldOuDN

foreach ($Group in $Groups)
{
$ErrorActionPreference = "Stop"
Get-ADGroup $Group.SamAccountName | Move-ADObject -TargetPath "OU=Functions,OU=$OUname,$OUPath" -ErrorVariable ReturnValue
}

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
$ErrorActionPreference = "SilentlyContinue"
}
until ((Get-DistributionGroup -OrganizationalUnit "OU=Functions,OU=$OUname,$OUPath") -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired while moving DistributionGroups."
return
}


$ErrorActionPreference = "Stop"
$Groups = Get-DistributionGroup -OrganizationalUnit "OU=Functions,OU=$OUname,$OUPath"

foreach ($Group in $Groups)
{

$SamAccountName = $wsDS.GetNextSamAccountName();

$EmailAddress = (Get-DistributionGroup $Group).PrimarySmtpAddress.ToString().ToLower()

Set-DistributionGroup $Group -DisplayName $EmailAddress -Name $EmailAddress -Alias ($EmailAddress -replace "@.*", "") -CustomAttribute1 $Domain -EmailAddressPolicyEnabled:$True -ErrorVariable ReturnValue

Set-ADGroup $Group.SamAccountName -GroupCategory Distribution -GroupScope Universal -SamAccountName $SamAccountName -ErrorVariable ReturnValue -PassThru
}