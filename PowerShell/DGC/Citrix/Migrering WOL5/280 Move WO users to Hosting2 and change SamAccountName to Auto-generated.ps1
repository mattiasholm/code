$OUname = "Donator"



if (!(Get-Module | where {$_.Name -match "ActiveDirectory"})) { Import-Module ActiveDirectory }
if (!(Get-PSSnapin | where {$_.Name -match "Exchange.Management"})) { Add-PSSnapin Microsoft.Exchange.Management.* }
$ErrorActionPreference = "Stop"
$ReturnValue = $null
$OUPath = "OU=Customers,OU=Hosting2,DC=emcat,DC=com"
$OU = Get-ADOrganizationalUnit "OU=$OUname,$OUPath"
$MigrationGroup = "$OUname.WO.ToBeMigrated"
$wsDS = New-WebServiceProxy 'http://donator-app1.emcat.com/DSSupportWS/DS.asmx?WSDL'
$Users = Get-ADGroupMember $MigrationGroup

 
foreach ($User in $Users)
{
$ErrorActionPreference = "Stop"
$OldOuDN = (Get-ADUser $User).DistinguishedName -replace "^[^,]*,",""

Get-ADUser $User | Set-ADObject -ProtectedFromAccidentalDeletion:$false
Get-ADUser $User | Move-ADObject -TargetPath "OU=$OUname,$OUPath" -ErrorVariable ReturnValue
$NewDN = $User.DistinguishedName -replace ",OU.*",",OU=$OUname,$OUPath"
Get-ADUser $NewDN | Set-ADObject -ProtectedFromAccidentalDeletion:$true
}

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
$ErrorActionPreference = "SilentlyContinue"
}
until ((Get-ADUser -Filter * -SearchBase "OU=$OUname,$OUPath") -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired while moving ADUsers."
return
}



$Users = Get-ADGroupMember $MigrationGroup
 
foreach ($User in $Users)
{
$ObjectGUID = $User.ObjectGUID
$NewSamAccountName = $wsDS.GetNewSamAccountName($ObjectGUID);

$ErrorActionPreference = "Stop"
Set-ADUser $User -SamAccountName $NewSamAccountName -PasswordNeverExpires:$True -Company "$OUname" -ErrorVariable ReturnValue


if (!(Get-Mailbox $User.DistinguishedName -ErrorAction SilentlyContinue))
{
$objOU = [ADSI]“LDAP://OU=$OUname,$OUPath”
$UPNSuffix = $objOU.uPNSuffixes
$NewUserPrincipalName = (Get-ADUser $User -Properties *).UserPrincipalName -replace "@.*","@$UPNSuffix"

Set-ADUser $User -UserPrincipalName $NewUserPrincipalName -ProfilePath $null -ErrorVariable ReturnValue
}

Add-ADGroupMember "CN=$OUname.AllUsers,OU=Functions,OU=$OUname,$OUPath" $NewSamAccountName -ErrorVariable ReturnValue
}



$Users = Get-ADGroupMember $MigrationGroup

foreach ($User in $Users)
{
Set-ADUser $User -HomeDrive "H:" -HomeDirectory "\\emcat.com\wo\customers\$OUname\Home\$($User.SamAccountName)" -ErrorVariable ReturnValue

$objUser = [ADSI]“LDAP://$($User.Distinguishedname)”
$objUser.PSbase.InvokeSet("TerminalServicesHomeDrive","S:")
$objUser.PSbase.InvokeSet("TerminalServicesHomeDirectory","\\emcat.com\wo\customers\$OUname\System\$($User.SamAccountName)")
$objUser.PSbase.InvokeSet("TerminalServicesProfilePath","")
$objUser.setInfo()

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
}
until (((Get-ADUser $User -Properties *).HomeDirectory -eq "\\emcat.com\wo\customers\$OUname\Home\$($User.SamAccountName)" -and ($objUser.TerminalServicesHomeDirectory) -eq "\\emcat.com\wo\customers\$OUname\System\$($User.SamAccountName)") -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired while setting parameters on ADUser $((Get-ADUser $User).UserPrincipalName)."
return
}
}