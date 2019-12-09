$OUname = "GaShipping"



$ReturnValue = $null
$OUPath = "OU=Customers,OU=Hosting2,DC=emcat,DC=com"
$CustomersPath = "\\emcat.com\wo\customers"

if (!(Get-Module | where {$_.Name -match "ActiveDirectory"})) { Import-Module ActiveDirectory }


$ErrorActionPreference = "Stop"
New-Item -ItemType Container "$CustomersPath\$OUname" -ErrorVariable ReturnValue

$ErrorActionPreference = "SilentlyContinue"

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
}
until ((Get-Item "$CustomersPath\$OUname") -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired while creating folders."
return
}


$ErrorActionPreference = "Stop"
New-Item -ItemType Container "$CustomersPath\$OUname\Common" -ErrorVariable ReturnValue
New-Item -ItemType Container "$CustomersPath\$OUname\Home" -ErrorVariable ReturnValue
New-Item -ItemType Container "$CustomersPath\$OUname\Program" -ErrorVariable ReturnValue
New-Item -ItemType Container "$CustomersPath\$OUname\System" -ErrorVariable ReturnValue

$ErrorActionPreference = "SilentlyContinue"

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
}
until (((Get-Item "$CustomersPath\$OUname\Common") -and (Get-Item "$CustomersPath\$OUname\Home") -and (Get-Item "$CustomersPath\$OUname\Program") -and (Get-Item "$CustomersPath\$OUname\System")) -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired while creating folders."
return
}


$GroupName = "WO.AllCitrixUsers"
$SubOU = "Functions"

$SamAccountName = "$OUname.$GroupName"

$ErrorActionPreference = "Stop"
$Group = New-ADGroup -GroupCategory Security -GroupScope Global -Name $SamAccountName -DisplayName $SamAccountName -SamAccountName "$SamAccountName" -Path "OU=$SubOU,OU=$OUname,$OUPath" -ErrorVariable ReturnValue -PassThru

$ErrorActionPreference = "SilentlyContinue"

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
}
until ([ADSI]::Exists("LDAP://CN=$OUname.$GroupName,OU=$SubOU,OU=$OUname,$OUPath") -eq $True -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired during creation of ADGroup $OUname.$GroupName."
return
}


$ErrorActionPreference = "Stop"


$GroupName = "WO.Application.DesktopPro"
$SubOU = "Applications"

$SamAccountName = "$OUname.$GroupName"

$ErrorActionPreference = "Stop"
$Group = New-ADGroup -GroupCategory Security -GroupScope Global -Name $SamAccountName -DisplayName $SamAccountName -SamAccountName "$SamAccountName" -Path "OU=$SubOU,OU=$OUname,$OUPath" -ErrorVariable ReturnValue -PassThru

$ErrorActionPreference = "SilentlyContinue"

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
}
until ([ADSI]::Exists("LDAP://CN=$OUname.$GroupName,OU=$SubOU,OU=$OUname,$OUPath") -eq $True -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired during creation of ADGroup $OUname.$GroupName."
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


$ErrorActionPreference = "Stop"
$Path = "$CustomersPath\$OUname"
$IdentityReference = New-Object System.Security.Principal.SecurityIdentifier $Group.SID
$FileSystemRights = "ReadAndExecute"
$InheritanceFlags = "ContainerInherit, ObjectInherit"
$PropagationFlags = "None"
$AccessControlType = "Allow"
$acl = Get-Acl $Path
$isProtected = $true
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
$ACE = (Get-Acl $Path).access | where {$_.IdentityReference -eq "EMCAT\$($Group.SamAccountName)"}
}
until (($ACE.FileSystemRights) -like "*$FileSystemRights*" -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired while adding $FileSystemRights permission for $($Group.Name) on path $Path"
return
}


$GlobalGroup = Get-ADGroup $GroupName

$ErrorActionPreference = "Stop"
$Path = "$CustomersPath\$OUname"
$IdentityReference = New-Object System.Security.Principal.SecurityIdentifier $GlobalGroup.SID
$FileSystemRights = "ReadAndExecute"
$InheritanceFlags = "ContainerInherit, ObjectInherit"
$PropagationFlags = "None"
$AccessControlType = "Allow"
$acl = Get-Acl $Path
$rule = New-Object System.Security.AccessControl.FileSystemAccessRule($IdentityReference,$FileSystemRights, $InheritanceFlags, $PropagationFlags, $AccessControlType)
$acl.RemoveAccessRule($rule)
Set-Acl $Path $acl

$ErrorActionPreference = "SilentlyContinue"

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
$ACE = (Get-Acl $Path).access | where {$_.IdentityReference -eq "EMCAT\$($GlobalGroup.SamAccountName)"}
}
until (!($ACE.FileSystemRights) -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired while adding $FileSystemRights permission for $($Group.Name) on path $Path"
return
}


$ErrorActionPreference = "Stop"
$Path = "$CustomersPath\$OUname\Common"
$IdentityReference = New-Object System.Security.Principal.SecurityIdentifier $Group.SID
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
$ACE = (Get-Acl $Path).access | where {$_.IdentityReference -eq "EMCAT\$($Group.SamAccountName)"}
}
until (($ACE.FileSystemRights) -like "*$FileSystemRights*" -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired while adding $FileSystemRights permission for $($Group.Name) on path $Path"
return
}


$ErrorActionPreference = "Stop"
$Path = "$CustomersPath\$OUname\Program"
$IdentityReference = New-Object System.Security.Principal.SecurityIdentifier $Group.SID
$FileSystemRights = "Modify"
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
$ACE = (Get-Acl $Path).access | where {$_.IdentityReference -eq "EMCAT\$($Group.SamAccountName)"}
}
until (($ACE.FileSystemRights) -like "*$FileSystemRights*" -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired while adding $FileSystemRights permission for $($Group.Name) on path $Path"
return
}