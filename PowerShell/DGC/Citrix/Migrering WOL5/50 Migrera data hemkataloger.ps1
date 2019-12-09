$OUname = "Donator"



$ReturnValue = $null
$ErrorActionPreference = "Stop"
$MigrationGroup = "$OUname.WO.ToBeMigrated"
$WOUsers = Get-ADGroupMember $MigrationGroup
$CustomersPath = "\\emcat.com\wo\customers"
$wsDS = New-WebServiceProxy 'http://donator-app1.emcat.com/DSSupportWS/DS.asmx?WSDL'


foreach ($WOUser in $WOUsers)
{
$objUser = [ADSI]“LDAP://$($WOUser.Distinguishedname)”
$TerminalServicesHomeDirectory = $objUser.TerminalServicesHomeDirectory

$ObjectGUID = $WOUser.ObjectGUID
$wsDS.SetTerminalServicesHomeDrive($ObjectGUID,$TerminalServicesHomeDirectory);

$OldTerminalServicesHomeDirectory = $wsDS.GetTerminalServicesHomeDrive($ObjectGUID);
$NewSamAccountName = $wsDS.GetNewSamAccountName($ObjectGUID);

$SourcePath = $OldTerminalServicesHomeDirectory
$DestinationPath = "$CustomersPath\$OUname\Home\$NewSamAccountName\! Data från tidigare WorkOnline-miljö"

#robocopy $SourcePath $DestinationPath /z /e /xd "Chrome" /B /R:0
}