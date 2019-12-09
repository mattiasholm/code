$UserPrincipalName = "karima.khushal@pubmedgroup.se"
$OUname = "Ostragbg"



if (!(Get-Module | where {$_.Name -match "ActiveDirectory"})) { Import-Module ActiveDirectory }
$ReturnValue = $null
$CustomersPath = "\\emcat.com\wo-care\customers"
$OUPath = "OU=Customers,OU=Hosting2,DC=emcat,DC=com"
$ErrorActionPreference = "Stop"
$wsMultiOTP = New-WebServiceProxy 'http://10.99.196.208/WebServiceSOAP/server.php?wsdl'

$User = Get-ADUser -Filter {UserPrincipalName -eq $UserPrincipalName}
if (!$User)
{
$ReturnValue = "User $UserPrincipalName does not exist."
exit
}

New-Item -ItemType Container "$CustomersPath\$OUname\Home\$($User.SamAccountName)" -ErrorVariable ReturnValue
New-Item -ItemType Container "$CustomersPath\$OUname\System\$($User.SamAccountName)" -ErrorVariable ReturnValue

$ErrorActionPreference = "SilentlyContinue"

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
}
until (((Get-Item "$CustomersPath\$OUname\System\$($User.SamAccountName)") -and (Get-Item "$CustomersPath\$OUname\Home\$($User.SamAccountName)")) -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired while creating folders."
return
}


$ErrorActionPreference = "Stop"
$Path = "$CustomersPath\$OUname\Home\$($User.SamAccountName)"
$IdentityReference = New-Object System.Security.Principal.SecurityIdentifier $User.SID
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
$ACE = (Get-Acl $Path).access | where {$_.IdentityReference -eq "EMCAT\$($User.SamAccountName)"}
}
until (($ACE.FileSystemRights) -eq "FullControl" -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired while adding $FileSystemRights permission for $($Group.Name) on path $Path"
return
}


$ErrorActionPreference = "Stop"
$Path = "$CustomersPath\$OUname\Home\$($User.SamAccountName)"
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
$Path = "$CustomersPath\$OUname\System\$($User.SamAccountName)"
$IdentityReference = New-Object System.Security.Principal.SecurityIdentifier $User.SID
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
$ACE = (Get-Acl $Path).access | where {$_.IdentityReference -eq "EMCAT\$($User.SamAccountName)"}
}
until (($ACE.FileSystemRights) -eq "FullControl" -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired while adding $FileSystemRights permission for $($Group.Name) on path $Path"
return
}


$ErrorActionPreference = "Stop"
$Path = "$CustomersPath\$OUname\System\$($User.SamAccountName)"
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
Set-ADUser $User -HomeDrive "H:" -HomeDirectory "$CustomersPath\$OUname\Home\$($User.SamAccountName)" -ErrorVariable ReturnValue


$objUser = [ADSI]“LDAP://$($User.Distinguishedname)”
$objUser.PSbase.InvokeSet("TerminalServicesHomeDrive","S:")
$objUser.PSbase.InvokeSet("TerminalServicesHomeDirectory","$CustomersPath\$OUname\System\$($User.SamAccountName)")
$objUser.setInfo()

$ErrorActionPreference = "SilentlyContinue"

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
}
until (((Get-ADUser -Filter {UserPrincipalName -eq $UserPrincipalName} -Properties *).HomeDirectory -eq "$CustomersPath\$OUname\Home\$($User.SamAccountName)" -and ($objUser.TerminalServicesHomeDirectory) -eq "$CustomersPath\$OUname\System\$($User.SamAccountName)") -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired while setting parameters on ADUser $UserPrincipalName."
return
}


$GroupName = "WO.AllWOCUsers"

$ErrorActionPreference = "Stop"
Add-ADGroupMember -Identity "CN=$OUname.$GroupName,OU=Functions,OU=$OUname,$OUPath" -Members $User.DistinguishedName -ErrorVariable ReturnValue

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


$GroupName = "WO.Application.DesktopWOC"

$ErrorActionPreference = "Stop"
Add-ADGroupMember -Identity "CN=$OUname.$GroupName,OU=Applications,OU=$OUname,$OUPath" -Members $User.DistinguishedName -ErrorVariable ReturnValue

$ErrorActionPreference = "SilentlyContinue"

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
}
until ((Get-ADGroup "CN=$OUname.$GroupName,OU=Applications,OU=$OUname,$OUPath" -Properties *).MemberOf -like "CN=$GroupName,OU=Applications,OU=Hosting2,DC=emcat,DC=com" -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired while adding ADGroup $OUname.$GroupName to $GroupName."
return
}


$wsMultiOTP.provisionMultiOtpUser($UserPrincipalName);