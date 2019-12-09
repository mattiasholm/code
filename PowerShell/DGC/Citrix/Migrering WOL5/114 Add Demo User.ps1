$OUname = "Donator"
$WorkOnline = $True
$Exchange = $False
$Password = "1qaz!QAZ"



$ErrorActionPreference = "Stop"
$ReturnValue = $null
$OUPath = "OU=Customers,OU=Hosting2,DC=emcat,DC=com"
$objOU = [ADSI]“LDAP://OU=$OUname,$OUPath”
$UPNSuffix = $objOU.uPNSuffixes
$FirstName = "Demo"
$LastName = $OUname
$Name = "Demo.$OUname"
$UserPrincipalName = "demo@$UPNSuffix"
$SamAccountName = "Demo.$OUname"
$wsMultiOTP = New-WebServiceProxy 'http://10.99.196.208/WebServiceSOAP/server.php?wsdl'

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
Add-ADGroupMember -Identity "CN=Hosting.Exkludering.Fakturering,OU=_Applications,OU=Hosting,DC=emcat,DC=com" -Members $SamAccountName -ErrorVariable ReturnValue

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
}
until ((Get-ADUser $SamAccountName -Properties *).MemberOf -like "*$OUname.AllUsers*" -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired while adding ADUser $UserPrincipalName to ADGroup Hosting.Exkludering.Fakturering."
return
}

$ErrorActionPreference = "Stop"
Get-ADUser -Filter {UserPrincipalName -eq $UserPrincipalName} | Set-ADUser -Company "$OUname" -PasswordNeverExpires $True -ErrorVariable ReturnValue


if ($MobilePhone)
{
$ErrorActionPreference = "Stop"
Get-ADUser -Filter {UserPrincipalName -eq $UserPrincipalName} | Set-ADUser -MobilePhone "$MobilePhone" -ErrorVariable ReturnValue
}



if ($WorkOnline -eq $True)
{
$CustomersPath = "\\emcat.com\wo\customers"

$User = Get-ADUser -Filter {UserPrincipalName -eq $UserPrincipalName}


$ErrorActionPreference = "Stop"
New-Item -ItemType Container "$CustomersPath\$OUname\Home\$SamAccountName" -ErrorVariable ReturnValue
New-Item -ItemType Container "$CustomersPath\$OUname\System\$SamAccountName" -ErrorVariable ReturnValue

$ErrorActionPreference = "SilentlyContinue"

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
}
until (((Get-Item "$CustomersPath\$OUname\System\$SamAccountName") -and (Get-Item "$CustomersPath\$OUname\Home\$SamAccountName")) -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired while creating folders."
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


$ErrorActionPreference = "Stop"
Set-ADUser $User -HomeDrive "H:" -HomeDirectory "\\emcat.com\wo\customers\$OUname\Home\$SamAccountName" -ErrorVariable ReturnValue


$objUser = [ADSI]“LDAP://$($User.Distinguishedname)”
$objUser.PSbase.InvokeSet("TerminalServicesHomeDrive","S:")
$objUser.PSbase.InvokeSet("TerminalServicesHomeDirectory","\\emcat.com\wo\customers\$OUname\System\$SamAccountName")
$objUser.setInfo()

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
}
until (((Get-ADUser -Filter {UserPrincipalName -eq $UserPrincipalName} -Properties *).HomeDirectory -eq "\\emcat.com\wo\customers\$OUname\Home\$SamAccountName" -and ($objUser.TerminalServicesHomeDirectory) -eq "\\emcat.com\wo\customers\$OUname\System\$SamAccountName") -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired while setting parameters on ADUser $UserPrincipalName."
return
}


$Groups = Get-ADGroup -SearchBase "OU=$OUname,$OUPath" -Filter * | where {$_.SamAccountName -like "$OUname.WO.*"}

foreach ($Group in $Groups)
{
Add-ADGroupMember -Identity $Group.DistinguishedName -Members $User.DistinguishedName -ErrorVariable ReturnValue
}


$wsMultiOTP.provisionTestUser($UserPrincipalName);
}



if ($Exchange -eq $True)
{
$ReturnValue = $null
if (!(Get-Module | where {$_.Name -match "ActiveDirectory"})) { Import-Module ActiveDirectory }
if (!(Get-PSSnapin | where {$_.Name -match "Exchange.Management"})) { Add-PSSnapin Microsoft.Exchange.Management.* }

$ErrorActionPreference = "SilentlyContinue"
if (!(Get-ADUser -Filter {UserPrincipalName -eq $UserPrincipalName}))
{
$ReturnValue = "AD account not found."
return
}
elseif (Get-Mailbox $UserPrincipalName)
{
$ReturnValue = "Mailbox already exists."
return
}

$OU = (Get-ADUser -Filter {UserPrincipalName -eq $UserPrincipalName} -Properties *).Company
$ABP = "$OU.ABP"

$ErrorActionPreference = "Stop"
$MailboxDatabases = Get-MailboxDatabase DB*
$ActualSizes = @{}
foreach ($MailboxDatabase in $MailboxDatabases)
{
$Identity = (Get-MailboxDatabase $MailboxDatabase).Name
$EDBSize = (Get-MailboxDatabase $MailboxDatabase -Status).DatabaseSize
$WhiteSpace = (Get-MailboxDatabase $MailboxDatabase -Status).AvailableNewMailboxSpace
$ActualSize = $EDBSize - $WhiteSpace
$ActualSizes.$Identity += $ActualSize
}

$SmallestDB = ($ActualSizes.GetEnumerator() | Sort-Object Value | Select -First 1).Name

$Database = (Get-MailboxDatabase $SmallestDB).Name


$ErrorActionPreference = "Stop"
Enable-Mailbox $UserPrincipalName -Database $Database -Alias ($UserPrincipalName -replace "@.*", "") -AddressBookPolicy $ABP -ErrorVariable ReturnValue


$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
$ErrorActionPreference = "SilentlyContinue"
}
until ((Get-Mailbox $UserPrincipalName) -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired during creation of Mailbox $UserPrincipalName"
return
}


$ErrorActionPreference = "Stop"
Set-Mailbox $UserPrincipalName -CustomAttribute1 ($UserPrincipalName -replace ".*@", "") -EmailAddressPolicyEnabled:$True -ErrorVariable ReturnValue

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
$ErrorActionPreference = "SilentlyContinue"
}
until ((Get-Mailbox $UserPrincipalName).CustomAttribute1 -eq ($UserPrincipalName -replace ".*@", "") -and (Get-Mailbox $UserPrincipalName).EmailAddressPolicyEnabled -eq $True -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired while setting parameters on Mailbox $UserPrincipalName"
return
}
}