$UserPrincipalName = "susanne.telby@stenvalvet.se"
$FirstName = "Susanne"
$LastName = "Telby"
$MobilePhone = "+46727044091"
$CopyGroupMembershipFrom = "stenvalvet.test@stenvalvet.se"
$OUname = "Stenvalvet"



$ReturnValue = $null
$Name = "$FirstName $LastName"
$OUPath = "OU=Customers,OU=Hosting2,DC=emcat,DC=com"

$wsDS = New-WebServiceProxy 'http://donator-app1.emcat.com/DSSupportWS/DS.asmx?WSDL'
$SamAccountName = $wsDS.GetNextSamAccountName();


$lowercase = ("a","b","c","d","e","f","g","h","i","j","k","m","n","p","q","r","s","t","u","v","w","x","y","z")
$uppercase = ("A","B","C","D","E","F","G","H","J","K","L","M","N","P","Q","R","S","T","U","V","W","X","Y","Z")
$p1 = Get-Random $lowercase
$p2 = Get-Random -Minimum 1 -Maximum 9
$p3 = Get-Random $uppercase
$Password = "$p1$p1$p2$p2$p3$p3"


if (!(Get-Module | where {$_.Name -match "ActiveDirectory"})) { Import-Module ActiveDirectory }

if (!(Get-ADUser -Filter {UserPrincipalName -eq $CopyGroupMembershipFrom}))
{
Write-Host -ForegroundColor Red "Kan ej hitta kontot $CopyGroupMembershipFrom som behörigheter skall kopieras från. Verifiera att UPN stämmer."
return
}

$ErrorActionPreference = "Stop"
New-ADUser -UserPrincipalName $UserPrincipalName -Path "OU=$OUname,$OUPath" -AccountPassword (ConvertTo-SecureString -AsPlainText $Password -Force) -GivenName $FirstName -SurName $LastName -SamAccountName $SamAccountName -Name $Name -DisplayName $Name -ChangePasswordAtLogon:$True -Enabled:$True -Confirm:$False -ErrorVariable ReturnValue

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


if ($CopyGroupMembershipFrom)
{
$CopyGroupMembershipFromAccount = Get-ADUser -Filter {UserPrincipalName -eq $CopyGroupMembershipFrom}
$CopyGroups = Get-ADPrincipalGroupMembership $CopyGroupMembershipFromAccount

foreach ($CopyGroup in $CopyGroups)
{
if ((Get-ADPrincipalGroupMembership $SamAccountName).SamAccountName -notcontains $CopyGroup.SamAccountName)
{
Add-ADGroupMember -Identity $CopyGroup.SamAccountName -Members $SamAccountName -ErrorVariable ReturnValue
}
}
}




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

Write-Host $ReturnValue
Write-Host -ForegroundColor Green "WorkOnline-konto $UserPrincipalName skapat!"
Write-Host -ForegroundColor Cyan "Lösenord: $Password"