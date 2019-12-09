$OUname = "GaShipping"
$UPNSuffix = "gashipping.com"



$ReturnValue = $null
$OUPath = "OU=Customers,OU=Hosting2,DC=emcat,DC=com"

if (!(Get-Module | where {$_.Name -match "ActiveDirectory"})) { Import-Module ActiveDirectory }

$ErrorActionPreference = "Stop"
$OU = New-ADOrganizationalUnit -Name $OUname -DisplayName $OUname -Path "$OUPath" -ProtectedFromAccidentalDeletion:$True -ErrorVariable ReturnValue -PassThru

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
}
until ([ADSI]::Exists("LDAP://OU=$OUname,$OUPath") -eq $True -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired during creation of OrganizationalUnit $OUname."
return
}


$SubOUs = ("Servers","Applications","Functions")
foreach ($SubOU in $SubOUs)
{
$ErrorActionPreference = "Stop"
New-ADOrganizationalUnit -Name $SubOU -DisplayName $SubOU -Path "OU=$OUname,$OUPath" -ProtectedFromAccidentalDeletion:$True -ErrorVariable ReturnValue
}


$SubOU = "Functions"

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
}
until ([ADSI]::Exists("LDAP://OU=$SubOU,OU=$OUname,$OUPath") -eq $True -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired during creation of OrganizationalUnit $SubOU."
return
}


$GroupName = "AllUsers"

$SamAccountName = "$OUname.$GroupName"

$ErrorActionPreference = "Stop"
$Group = New-ADGroup -GroupCategory Security -GroupScope Global -Name "$SamAccountName" -DisplayName "$SamAccountName" -SamAccountName "$SamAccountName" -Path "OU=$SubOU,OU=$OUname,$OUPath" -ErrorVariable ReturnValue -PassThru

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
}
until ([ADSI]::Exists("LDAP://CN=$SamAccountName,OU=$SubOU,OU=$OUname,$OUPath") -eq $True -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired during creation of ADGroup $SamAccountName."
return
}


$ErrorActionPreference = "Stop"
Add-ADGroupMember -Identity "CN=$GroupName,OU=Functions,OU=Hosting2,DC=emcat,DC=com" -Members $Group.DistinguishedName -ErrorVariable ReturnValue

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


$ADSI = [ADSI]"LDAP://$($OU.DistinguishedName)"
$IdentityReference = New-Object System.Security.Principal.SecurityIdentifier $Group.SID
$ActiveDirectoryRights = [System.DirectoryServices.ActiveDirectoryRights]"GenericRead"
$AccessControlType = [System.Security.AccessControl.AccessControlType]"Allow"
$ActiveDirectorySecurityInheritance = [System.DirectoryServices.ActiveDirectorySecurityInheritance]"All"
$ACE = New-Object System.DirectoryServices.ActiveDirectoryAccessRule($IdentityReference,$ActiveDirectoryRights,$AccessControlType,$ActiveDirectorySecurityInheritance)
$ADSI.PSbase.ObjectSecurity.SetAccessRule($ACE)
$ADSI.PSbase.CommitChanges()

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
$ACE = (Get-ACL "AD:$OU").access | where {$_.IdentityReference -eq "EMCAT\$SamAccountName"}
}
until (($ACE.ActiveDirectoryRights) -eq "GenericRead" -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired while adding Read permission for $SamAccountName on OrganizationalUnit $OUname"
return
}


$SID = "S-1-5-11"
$FriendlyName = "NT AUTHORITY\Authenticated Users"
$ADSI = [ADSI]"LDAP://$($OU.DistinguishedName)"
$IdentityReference = New-Object System.Security.Principal.SecurityIdentifier $SID
$ActiveDirectoryRights = [System.DirectoryServices.ActiveDirectoryRights]"GenericRead"
$AccessControlType = [System.Security.AccessControl.AccessControlType]"Allow"
$ActiveDirectorySecurityInheritance = [System.DirectoryServices.ActiveDirectorySecurityInheritance]"All"
$ACE = New-Object System.DirectoryServices.ActiveDirectoryAccessRule($IdentityReference,$ActiveDirectoryRights,$AccessControlType,$ActiveDirectorySecurityInheritance)
$bool = $null
$bool = $ADSI.PSbase.ObjectSecurity.RemoveAccessRule($ACE)
if ($bool -eq $True)
{
$ADSI.PSbase.CommitChanges()
}
else
{
$ReturnValue = "Failed to remove Read permission for $FriendlyName on OrganizationalUnit $OUname"
return
}

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
$ACE = (Get-ACL "AD:$OU").access | where {$_.IdentityReference -eq "NT AUTHORITY\Authenticated Users"}
}
while (($ACE.ActiveDirectoryRights) -eq "GenericRead" -and $Timeout -gt 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired while removing Read permission for 'Authenticated Users' from OrganizationalUnit $OUname"
return
}


$ErrorActionPreference = "Stop"
$objOU = [ADSI]“LDAP://OU=$OUname,$OUPath”
$objOU.put(“uPNSuffixes”, “$UPNSuffix”)
$objOU.setInfo()

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
}
until ($objOU.uPNSuffixes -eq "$UPNSuffix" -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired while setting UPN suffixes on OrganizationalUnit $OUname"
return
}