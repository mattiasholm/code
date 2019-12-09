$OUname = "Leroy"
$DisplayName = "Skrivbord - Leröy"
$TSservers = "leroy-ts02"



if (!(Get-PSSnapin | where {$_.Name -match "Citrix"})) { Add-PSSnapin Citrix* }
if (!(Get-Module | where {$_.Name -match "ActiveDirectory"})) { Import-Module ActiveDirectory }
$ErrorActionPreference = "Stop"
$CitrixGroup = "$($OUname).WO.Application.DesktopPro"
$CitrixController = "don-wo-ddc01"
$OUPath = "OU=Customers,OU=Hosting2,DC=emcat,DC=com"
$SubOU = "Applications"
$Group = "WO.Application.DesktopPro"


if (!([adsi]::Exists("LDAP://CN=$OUname.$Group,OU=$SubOU,OU=$OUname,$OUPath")))
{
New-ADGroup -GroupCategory Security -GroupScope Global -Name "$OUname.$Group" -DisplayName "$OUname.$Group" -Path "OU=$SubOU,OU=$OUname,$OUPath" -ErrorVariable ReturnValue

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
$ErrorActionPreference = "SilentlyContinue"
}
until ([adsi]::Exists("LDAP://CN=$OUname.$Group,OU=$SubOU,OU=$OUname,$OUPath") -eq $True -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired while creating group $OUname.$Group"
return
}

$ErrorActionPreference = "Stop"
Add-ADGroupMember -Identity $Group -Members "$OUname.$Group" -ErrorVariable ReturnValue

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
$ErrorActionPreference = "SilentlyContinue"
}
until ((Get-ADGroup "CN=$OUname.$Group,OU=$SubOU,OU=$OUname,$OUPath" -Properties *).MemberOf -like "*$Group*" -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired while adding group $OUname.$Group to $Group"
return
}


}


New-BrokerCatalog -Name $OUname -AllocationType Random -ProvisioningType Manual -SessionSupport MultiSession -PersistUserChanges OnLocal -Description $DisplayName -IsRemotePC:$False -MachinesArePhysical:$True -AdminAddress $CitrixController


$MachineCatalog = Get-BrokerCatalog $OUname -AdminAddress $CitrixController


if ($TSservers)
{
Foreach ($TSserver in $TSservers)
{
New-BrokerMachine -CatalogUid $MachineCatalog.Uid -MachineName $TSserver -AdminAddress $CitrixController
}
}


New-BrokerDesktopGroup -Name $OUname -DesktopKind "Shared" -Description $DisplayName -PublishedName $DisplayName -AutomaticPowerOnForAssigned:$True -SessionSupport MultiSession -TimeZone "W. Europe Standard Time" -TurnOnAddedMachine:$True -OffPeakBufferSizePercent 10 -PeakBufferSizePercent 10 -AdminAddress $CitrixController


$Count = (Get-BrokerMachine -CatalogName $OUname -AdminAddress $CitrixController | measure).Count
Add-BrokerMachinesToDesktopGroup -Catalog $OUname -DesktopGroup $OUname -Count $Count -AdminAddress $CitrixController


$DesktopGroup = Get-BrokerDesktopGroup $OUname -AdminAddress $CitrixController

New-BrokerAccessPolicyRule -AllowRestart:$True -AllowedConnections ViaAG -AllowedProtocols HDX, RDP -Description $DisplayName -DesktopGroupUid $DesktopGroup.Uid -IncludedClientNameFilterEnabled:$False -IncludedSmartAccessFilterEnabled:$True -IncludedUserFilterEnabled:$True -IncludedUsers $CitrixGroup -Name "$($OUname)_AG" -AdminAddress $CitrixController

New-BrokerAccessPolicyRule -AllowRestart:$True -AllowedConnections NotViaAG -AllowedProtocols HDX, RDP -Description $DisplayName -DesktopGroupUid $DesktopGroup.Uid -IncludedClientNameFilterEnabled:$False -IncludedSmartAccessFilterEnabled:$True -IncludedUserFilterEnabled:$True -IncludedUsers $CitrixGroup -Name "$($OUname)_Direct" -AdminAddress $CitrixController


New-BrokerEntitlementPolicyRule -DesktopGroupUid $DesktopGroup.Uid -Name "$($OUname)_1" -IncludedUserFilterEnabled:$False -PublishedName $DisplayName -AdminAddress $CitrixController