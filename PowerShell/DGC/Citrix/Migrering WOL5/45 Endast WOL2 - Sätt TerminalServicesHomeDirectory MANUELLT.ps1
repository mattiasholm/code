$OUname = "Mollerst"
$Path = "\\emcat.com\public\hosting\mollerstrommedical\Home"



$ReturnValue = $null
$ErrorActionPreference = "Stop"
$MigrationGroup = "$OUname.WO.ToBeMigrated"
$WOUsers = Get-ADGroupMember $MigrationGroup
$CustomersPath = "\\emcat.com\wo\customers"
$wsDS = New-WebServiceProxy 'http://donator-app1.emcat.com/DSSupportWS/DS.asmx?WSDL'


foreach ($WOUser in $WOUsers)
{

if (Get-Item $Path\$($WOUser.SamAccountName) -ErrorAction SilentlyContinue)
{
$objUser = [ADSI]“LDAP://$($WOUser.Distinguishedname)”
$ObjectGUID = $WOUser.ObjectGUID

$DsPath = $wsDS.GetTerminalServicesHomeDrive($ObjectGUID);
$AdPath = $objUser.TerminalServicesHomeDirectory

if ($DsPath -eq $AdPath)
{
$wsDS.RemoveTerminalServicesHomeDrive($ObjectGUID);
}

$TerminalServicesHomeDirectory = "$Path\$($WOUser.SamAccountName)"
$wsDS.SetTerminalServicesHomeDrive($ObjectGUID,$TerminalServicesHomeDirectory);
}
}