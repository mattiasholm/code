$Members = "malin.sundqvist"
$OUname = "Donator"
$Domain = "donator.se"



$ReturnValue = $null
$OUPath = "OU=Customers,OU=Hosting2,DC=emcat,DC=com"

if (!(Get-Module | where {$_.Name -match "ActiveDirectory"})) { Import-Module ActiveDirectory }

$GroupName = "WO.ToBeMigrated"

$SamAccountName = "$OUname.$GroupName"
$SubOU = "Functions"

$ErrorActionPreference = "Stop"

if (Get-ADGroupMember $SamAccountName)
{
Write-Host "Verifiera medlemmar i migreringsgrupp $OUname.WO.ToBeMigrated innan du fortsätter!"
Pause
}

Add-ADGroupMember $SamAccountName -Members $Members


###

if (!(Get-Module | where {$_.Name -match "ActiveDirectory"})) { Import-Module ActiveDirectory }
$ReturnValue = $null
$CustomersPath = "\\emcat.com\wo\customers"
$OUPath = "OU=Customers,OU=Hosting2,DC=emcat,DC=com"
$MigrationGroup = "$OUname.WO.ToBeMigrated"
$WOUsers = Get-ADGroupMember $MigrationGroup
$wsDS = New-WebServiceProxy 'http://donator-app1.emcat.com/DSSupportWS/DS.asmx?WSDL'
$wsMultiOTP = New-WebServiceProxy 'http://10.99.196.208/WebServiceSOAP/server.php?wsdl'


foreach ($WOUser in $WOUsers)
{
$ErrorActionPreference = "Stop"
$ObjectGUID = $WOUser.ObjectGUID

$wsDS.SetNewSamAccountName($ObjectGUID);

$NewSamAccountName = $wsDS.GetNewSamAccountName($ObjectGUID);

if ($NewSamAccountName -eq "Hittar inte upn")
{
$ReturnValue = "DS Web Service hittar ej angivet UPN i databas."
exit
}

$ErrorActionPreference = "Stop"
New-Item -ItemType Container "$CustomersPath\$OUname\Home\$NewSamAccountName" -ErrorVariable ReturnValue
New-Item -ItemType Container "$CustomersPath\$OUname\System\$NewSamAccountName" -ErrorVariable ReturnValue

$ErrorActionPreference = "SilentlyContinue"

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
}
until (((Get-Item "$CustomersPath\$OUname\System\$NewSamAccountName") -and (Get-Item "$CustomersPath\$OUname\Home\$NewSamAccountName")) -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired while creating folders."
return
}

$ErrorActionPreference = "SilentlyContinue"

$ErrorActionPreference = "Stop"
$Path = "$CustomersPath\$OUname\Home\$NewSamAccountName"
$IdentityReference = New-Object System.Security.Principal.SecurityIdentifier $WOUser.SID
$FileSystemRights = "FullControl"
$InheritanceFlags = "ContainerInherit, ObjectInherit"
$PropagationFlags = "None"
$AccessControlType = "Allow"
$acl = Get-Acl $Path
$isProtected = $false
$preserveInheritance = $true
$acl.SetAccessRuleProtection($isProtected, $preserveInheritance)
$rule = New-Object System.Security.AccessControl.FileSystemAccessRule($IdentityReference,$FileSystemRights, $InheritanceFlags, $PropagationFlags, $AccessControlType)
$acl.AddAccessRule($rule)
Set-Acl $Path $acl

$ErrorActionPreference = "SilentlyContinue"

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
$ACE = (Get-Acl $Path).access | where {$_.IdentityReference -eq "EMCAT\$($WOUser.SamAccountName)"}
}
until (($ACE.FileSystemRights) -eq "FullControl" -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired while adding $FileSystemRights permission for $($WOUser.Name) on path $Path"
return
}


$ErrorActionPreference = "Stop"
$Path = "$CustomersPath\$OUname\Home\$NewSamAccountName"
$IdentityReference = New-Object System.Security.Principal.SecurityIdentifier (Get-ADGroup "WO.AllAdmins.HomeFolders").SID
$FileSystemRights = "FullControl"
$InheritanceFlags = "ContainerInherit, ObjectInherit"
$PropagationFlags = "None"
$AccessControlType = "Allow"
$acl = Get-Acl $Path
$rule = New-Object System.Security.AccessControl.FileSystemAccessRule($IdentityReference,$FileSystemRights, $InheritanceFlags, $PropagationFlags, $AccessControlType)
$acl.AddAccessRule($rule)
Set-Acl $Path $acl

$ErrorActionPreference = "SilentlyContinue"

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
$ACE = (Get-Acl $Path).access | where {$_.IdentityReference -eq "EMCAT\WO.AllAdmins.HomeFolders"}
}
until (($ACE.FileSystemRights) -eq "FullControl" -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired while adding $FileSystemRights permission for $($Group.Name) on path $Path"
return
}


$ErrorActionPreference = "Stop"
$Path = "$CustomersPath\$OUname\System\$NewSamAccountName"
$IdentityReference = New-Object System.Security.Principal.SecurityIdentifier $WOUser.SID
$FileSystemRights = "FullControl"
$InheritanceFlags = "ContainerInherit, ObjectInherit"
$PropagationFlags = "None"
$AccessControlType = "Allow"
$acl = Get-Acl $Path
$isProtected = $false
$preserveInheritance = $true
$acl.SetAccessRuleProtection($isProtected, $preserveInheritance)
$rule = New-Object System.Security.AccessControl.FileSystemAccessRule($IdentityReference,$FileSystemRights, $InheritanceFlags, $PropagationFlags, $AccessControlType)
$acl.AddAccessRule($rule)
Set-Acl $Path $acl

$ErrorActionPreference = "SilentlyContinue"

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
$ACE = (Get-Acl $Path).access | where {$_.IdentityReference -eq "EMCAT\$($WOUser.SamAccountName)"}
}
until (($ACE.FileSystemRights) -eq "FullControl" -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired while adding $FileSystemRights permission for $($Group.Name) on path $Path"
return
}


$ErrorActionPreference = "Stop"
$Path = "$CustomersPath\$OUname\System\$NewSamAccountName"
$IdentityReference = New-Object System.Security.Principal.SecurityIdentifier (Get-ADGroup "WO.AllAdmins.HomeFolders").SID
$FileSystemRights = "FullControl"
$InheritanceFlags = "ContainerInherit, ObjectInherit"
$PropagationFlags = "None"
$AccessControlType = "Allow"
$acl = Get-Acl $Path
$rule = New-Object System.Security.AccessControl.FileSystemAccessRule($IdentityReference,$FileSystemRights, $InheritanceFlags, $PropagationFlags, $AccessControlType)
$acl.AddAccessRule($rule)
Set-Acl $Path $acl

$ErrorActionPreference = "SilentlyContinue"

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
$ACE = (Get-Acl $Path).access | where {$_.IdentityReference -eq "EMCAT\WO.AllAdmins.HomeFolders"}
}
until (($ACE.FileSystemRights) -eq "FullControl" -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired while adding $FileSystemRights permission for $($Group.Name) on path $Path"
return
}



$GroupName = "WO.AllCitrixUsers"

$ErrorActionPreference = "Stop"
Add-ADGroupMember -Identity "CN=$OUname.$GroupName,OU=Functions,OU=$OUname,$OUPath" -Members $WOUser.DistinguishedName -ErrorVariable ReturnValue

$ErrorActionPreference = "SilentlyContinue"

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
}
until ((Get-ADGroup "CN=$OUname.$GroupName,OU=Functions,OU=$OUname,$OUPath" -Properties *).MemberOf -like "CN=$GroupName,OU=Functions,OU=Hosting2,DC=emcat,DC=com" -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired while adding ADGroup $OUname.$GroupName to $GroupName."
return
}

$UserPrincipalName = (Get-ADUser $WOUser -Properties *).UserPrincipalName

$wsMultiOTP.provisionMultiOtpUser($UserPrincipalName);
}



###


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



### FIXA HANTERING IFALL ANVÄNDAREN SAKNAR HEMKATALOG ETC!!!
<#
if ($TerminalServicesHomeDirectory -ne "OverloadDefinitions")
{#>
$ObjectGUID = $WOUser.ObjectGUID
$wsDS.SetTerminalServicesHomeDrive($ObjectGUID,$TerminalServicesHomeDirectory);

$OldTerminalServicesHomeDirectory = $wsDS.GetTerminalServicesHomeDrive($ObjectGUID);
$NewSamAccountName = $wsDS.GetNewSamAccountName($ObjectGUID);

$SourcePath = $OldTerminalServicesHomeDirectory
$DestinationPath = "$CustomersPath\$OUname\Home\$NewSamAccountName"

robocopy $SourcePath $DestinationPath /z /e /xd "WINDOWS" "WINDOWS.wol4" "Chrome" /R:0 /B
}
#}

###


$ErrorActionPreference = "Stop"
if (!(Get-PSSnapin | where {$_.Name -match "Exchange.Management"})) { Add-PSSnapin Microsoft.Exchange.Management.* }
$ReturnValue = $null
$OUPath = "OU=Customers,OU=Hosting2,DC=emcat,DC=com"
$MigrationGroup = "$OUname.WO.ToBeMigrated"
$Users = Get-ADGroupMember $MigrationGroup

foreach ($User in $Users)
{
$Mailbox = Get-Mailbox $User.SamAccountName

$OriginalSMTPAddresses = (Get-Mailbox $Mailbox).Emailaddresses.ProxyAddressString
$OriginalSMTPAddresses > "C:\DS\OriginalSMTPAddresses\$($Mailbox.Guid)_$(Get-Date -Format "yyyy-MM-dd_HH.mm.ss").txt"


$ErrorActionPreference = "Stop"
$RemoveAddresses = @()
$RemoveAddresses += ((Get-Mailbox $Mailbox).Emailaddresses | where {$_.ProxyAddressString -like "*hostingcustomer*"}).ProxyAddressString
$RemoveAddresses += ((Get-Mailbox $Mailbox).Emailaddresses | where {$_.ProxyAddressString -like "*msxcustomer*"}).ProxyAddressString
$RemoveAddresses += ((Get-Mailbox $Mailbox).Emailaddresses | where {$_.ProxyAddressString -like "X400:*"}).ProxyAddressString

Set-Mailbox $Mailbox -EmailAddresses @{remove=$RemoveAddresses} -ErrorVariable ReturnValue
}


###

$ErrorActionPreference = "Stop"
if (!(Get-Module | where {$_.Name -match "ActiveDirectory"})) { Import-Module ActiveDirectory }
if (!(Get-PSSnapin | where {$_.Name -match "Exchange.Management"})) { Add-PSSnapin Microsoft.Exchange.Management.* }
$ReturnValue = $null
$OUPath = "OU=Customers,OU=Hosting2,DC=emcat,DC=com"
$MigrationGroup = "$OUname.WO.ToBeMigrated"
$Users = Get-ADGroupMember $MigrationGroup


foreach ($User in $Users)
{
$Mailbox = Get-Mailbox $User.SamAccountName

Write-Host "Verifiera att UPN är korrekt"
(Get-Mailbox $Mailbox).PrimarySmtpAddress.ToString().ToLower()
Pause
sleep 5
}


###



$ErrorActionPreference = "Stop"
if (!(Get-Module | where {$_.Name -match "ActiveDirectory"})) { Import-Module ActiveDirectory }
if (!(Get-PSSnapin | where {$_.Name -match "Exchange.Management"})) { Add-PSSnapin Microsoft.Exchange.Management.* }
$ReturnValue = $null
$OUPath = "OU=Customers,OU=Hosting2,DC=emcat,DC=com"
$MigrationGroup = "$OUname.WO.ToBeMigrated"
$Users = Get-ADGroupMember $MigrationGroup


foreach ($User in $Users)
{
$Mailbox = Get-Mailbox $User.SamAccountName

$NewUserPrincipalName = (Get-Mailbox $Mailbox).PrimarySmtpAddress.ToString().ToLower()

$ErrorActionPreference = "Stop"
Set-Mailbox $Mailbox -UserPrincipalName $NewUserPrincipalName -Alias ($NewUserPrincipalName -replace "@.*", "") -CustomAttribute1 $Domain -EmailAddressPolicyEnabled:$True -AddressBookPolicy "$OUname.ABP" -ErrorVariable ReturnValue
}


###


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
sleep 15
$NewDN = $User.DistinguishedName -replace ",OU.*",",OU=$OUname,$OUPath"
Get-ADUser $NewDN | Set-ADObject -ProtectedFromAccidentalDeletion:$true
}

$ErrorActionPreference = "SilentlyContinue"

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

$ErrorActionPreference = "SilentlyContinue"

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


###


$ReturnValue = $null
$OUPath = "OU=Customers,OU=Hosting2,DC=emcat,DC=com"

if (!(Get-Module | where {$_.Name -match "ActiveDirectory"})) { Import-Module ActiveDirectory }

$GroupName = "WO.ToBeMigrated"

$SamAccountName = "$OUname.$GroupName"
$SubOU = "Functions"

$ErrorActionPreference = "Stop"
Remove-ADGroupMember $SamAccountName -Members $NewSamAccountName -Confirm:$false


###




$Groups = Get-ADGroup -SearchBase "OU=$OUname,$OUPath" -Filter * | where {$_.SamAccountName -like "$OUname.WO.*" -and $_.SamAccountName -ne "$OUname.WO.ToBeMigrated"}

foreach ($Group in $Groups)
{
Add-ADGroupMember -Identity $Group.DistinguishedName -Members $User.SID -ErrorVariable ReturnValue
}



###



Write-Host "Uppdatera UserID i Donator Studio för användaren $Members till $NewSamAccountName (dbc1 -> Donator_Studio -> dbo.Sys_Anvandare)"
Pause
Write-Host -ForegroundColor Green "Migrering klar!"