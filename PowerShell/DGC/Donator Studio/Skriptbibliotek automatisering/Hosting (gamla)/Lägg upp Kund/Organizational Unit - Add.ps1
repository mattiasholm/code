$OUname = "MH.Malmo"



$ReturnValue = $null
$OUPath = "OU=Hosting,DC=emcat,DC=com"

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

$GroupName = "Everyone"

$ErrorActionPreference = "Stop"
$Group = New-ADGroup -GroupCategory Security -GroupScope Global -Name "$OUname.$GroupName" -DisplayName "$OUname.$GroupName" -Path "OU=$OUname,$OUPath" -ErrorVariable ReturnValue -PassThru

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
}
until ([ADSI]::Exists("LDAP://CN=$OUname.$GroupName,OU=$OUname,$OUPath") -eq $True -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired during creation of ADGroup $OUname.$GroupName."
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
$ACE = (Get-ACL "AD:$OU").access | where {$_.IdentityReference -eq "EMCAT\$OUname.$GroupName"}
}
until (($ACE.ActiveDirectoryRights) -eq "GenericRead" -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired while adding Read permission for $OUname.$GroupName on OrganizationalUnit $OUname"
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

Write-host $ReturnValue