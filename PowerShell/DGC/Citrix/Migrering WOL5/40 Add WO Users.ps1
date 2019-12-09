$OUname = "Donator"



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
return
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


$ErrorActionPreference = "Stop"
$Path = "$CustomersPath\$OUname\Home\$NewSamAccountName"
$IdentityReference = New-Object System.Security.Principal.SecurityIdentifier $WOUser.SID
$FileSystemRights = "FullControl"
$InheritanceFlags = "ContainerInherit, ObjectInherit"
$PropagationFlags = "None"
$AccessControlType = "Allow"
$acl = Get-Acl $Path
$isProtected = $true
$preserveInheritance = $false
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
$isProtected = $true
$preserveInheritance = $false
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