$UserPrincipalName = "admin.test@leroy.se"
$Password = "tR4Ste"
$FirstName = "admin"
$LastName = ""
$MobilePhone = ""
$OUname = "Leroy"

$ReturnValue = $null
$Name = "$FirstName $LastName"
$OUPath = "OU=Customers,OU=Hosting2,DC=emcat,DC=com"

$wsDS = New-WebServiceProxy 'http://donator-app1.emcat.com/DSSupportWS/DS.asmx?WSDL'
$SamAccountName = $wsDS.GetNextSamAccountName();


if (!(Get-Module | where {$_.Name -match "ActiveDirectory"})) { Import-Module ActiveDirectory }

$ErrorActionPreference = "Stop"
New-ADUser -UserPrincipalName $UserPrincipalName -Path "OU=$OUname,$OUPath" -AccountPassword (ConvertTo-SecureString -AsPlainText $Password -Force) -GivenName $FirstName -SurName $LastName -SamAccountName $SamAccountName -Name $Name -DisplayName $Name -PasswordNeverExpires:$True -Enabled:$True -Confirm:$False -ErrorVariable ReturnValue

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
}
until ((Get-ADUser -Filter {UserPrincipalName -eq $UserPrincipalName}) -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired during creation of ADUser $UserPrincipalName."
return
}


$ErrorActionPreference = "Stop"
Add-ADGroupMember -Identity "CN=$OUname.AllUsers,OU=Functions,OU=$OUname,$OUPath" -Members $SamAccountName -ErrorVariable ReturnValue

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
}
until ((Get-ADUser $SamAccountName -Properties *).MemberOf -like "*$OUname.AllUsers*" -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired while adding ADUser $UserPrincipalName to ADGroup $OUname.Everyone."
return
}


$ErrorActionPreference = "Stop"
Get-ADUser -Filter {UserPrincipalName -eq $UserPrincipalName} | Set-ADUser -Company "$OUname" -ErrorVariable ReturnValue


if ($MobilePhone)
{
$ErrorActionPreference = "Stop"
Get-ADUser -Filter {UserPrincipalName -eq $UserPrincipalName} | Set-ADUser -MobilePhone "$MobilePhone" -ErrorVariable ReturnValue
}





###




if (!(Get-Module | where {$_.Name -match "ActiveDirectory"})) { Import-Module ActiveDirectory }
$ReturnValue = $null
$CustomersPath = "\\emcat.com\wo\customers"
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


$Path = "$CustomersPath\$OUname\Home\$SamAccountName"
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


$Path = "$CustomersPath\$OUname\Home\$SamAccountName"
$IdentityReference = New-Object System.Security.Principal.SecurityIdentifier (Get-ADGroup "WO.AllAdmins.HomeFolders").SID
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


$Path = "$CustomersPath\$OUname\System\$SamAccountName"
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


$Path = "$CustomersPath\$OUname\System\$SamAccountName"
$IdentityReference = New-Object System.Security.Principal.SecurityIdentifier (Get-ADGroup "WO.AllAdmins.HomeFolders").SID
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
Set-ADUser $User -HomeDrive "H:" -HomeDirectory "\\emcat.com\wo\customers\$OUname\Home\$($User.SamAccountName)" -ErrorVariable ReturnValue


$objUser = [ADSI]“LDAP://$($User.Distinguishedname)”
$objUser.PSbase.InvokeSet("TerminalServicesHomeDrive","S:")
$objUser.PSbase.InvokeSet("TerminalServicesHomeDirectory","\\emcat.com\wo\customers\$OUname\System\$($User.SamAccountName)")
$objUser.setInfo()

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
}
until (((Get-ADUser -Filter {UserPrincipalName -eq $UserPrincipalName} -Properties *).HomeDirectory -eq "\\emcat.com\wo\customers\$OUname\Home\$($User.SamAccountName)" -and ($objUser.TerminalServicesHomeDirectory) -eq "\\emcat.com\wo\customers\$OUname\System\$($User.SamAccountName)") -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired while setting parameters on ADUser $UserPrincipalName."
return
}


$GroupName = "WO.AllCitrixUsers"

$ErrorActionPreference = "Stop"
Add-ADGroupMember -Identity "CN=$OUname.$GroupName,OU=Functions,OU=$OUname,$OUPath" -Members $User.DistinguishedName -ErrorVariable ReturnValue

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


$wsMultiOTP.provisionMultiOtpUser($UserPrincipalName);



###



$GlobalGroup = "WO.BypassTwoFactor"



if (!(Get-Module | where {$_.Name -match "ActiveDirectory"})) { Import-Module ActiveDirectory }
$ErrorActionPreference = "Stop"
$ReturnValue = $null
$OUPath = "OU=Customers,OU=Hosting2,DC=emcat,DC=com"
$SubOU = "Functions"


$ErrorActionPreference = "Stop"
Add-ADGroupMember -Identity "$OUname.$GlobalGroup" -Members $SamAccountName -ErrorVariable ReturnValue

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
$ErrorActionPreference = "SilentlyContinue"
}
until ((Get-ADUser $SamAccountName -Properties *).MemberOf -like "*CN=$OUname.$GlobalGroup,OU=$SubOU,OU=$OUname,$OUPath*" -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired while adding ADUser $SamAccountName to ADGroup $OUname.$GlobalGroup"
return
}






###




$GlobalGroup = "WO.Application.DesktopPro"



if (!(Get-Module | where {$_.Name -match "ActiveDirectory"})) { Import-Module ActiveDirectory }
$ErrorActionPreference = "Stop"
$ReturnValue = $null
$OUPath = "OU=Customers,OU=Hosting2,DC=emcat,DC=com"
$SubOU = "Applications"
$CustomersPath = "\\emcat.com\wo\customers"


$ErrorActionPreference = "Stop"
Add-ADGroupMember -Identity "$OUname.$GlobalGroup" -Members $SamAccountName -ErrorVariable ReturnValue


$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
$ErrorActionPreference = "SilentlyContinue"
}
until ((Get-ADUser $SamAccountName -Properties *).MemberOf -like "*CN=$OUname.$GlobalGroup,OU=$SubOU,OU=$OUname,$OUPath*" -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired while adding ADUser $SamAccountName to ADGroup $OUname.$GlobalGroup"
return
}



Write-Host "ReturnValue: $ReturnValue" -ForegroundColor Green