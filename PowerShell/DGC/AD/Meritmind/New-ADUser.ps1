$UserPrincipalName = Read-Host "UserPrincipalName"
$FirstName = Read-Host "Förnamn"
$LastName = Read-Host "Efternamn"

$AssocieradKonsult = $null
$AnstalldKonsult = $null

if ($UserPrincipalName -like "*@brightby.se")
{
$AnstalldKonsult = Read-Host "Är användaren en anställd konsult? (Y/N)"

$CopyGroupMembershipFrom = Read-Host "UserPrincipalName för konto att kopiera gruppmedlemskap från"
}

if ($UserPrincipalName -like "*@meritmind.se")
{
$AssocieradKonsult = Read-Host "Är användaren en associerad konsult? (Y/N)"

if ($AssocieradKonsult -eq "Y")
{
$CopyGroupMembershipFrom = $null
}
else
{
$AnstalldKonsult = Read-Host "Är användaren en anställd konsult? (Y/N)"

$CopyGroupMembershipFrom = Read-Host "UserPrincipalName för konto att kopiera gruppmedlemskap från"
}
}

$FileServerPath = "\\meritmind.local\Storage\"

if ($UserPrincipalName -like "*@meritmind.se")
{
$OUname = "_Innepersonal,OU=Meritmind"

if ($AssocieradKonsult -eq "Y")
{
$OUname = "_Associerade konsulter,OU=Meritmind"
}
if ($AnstalldKonsult -eq "Y")
{
$OUname = "_Anställda konsulter,OU=Meritmind"
}
}
elseif ($UserPrincipalName -like "*@brightby.se")
{
$OUname = "_Innepersonal,OU=Brightby"

if ($AnstalldKonsult -eq "Y")
{
$OUname = "_Anställda konsulter,OU=Brightby"
}
}
else
{
Write-Host "Användaren måste ha UPN-suffix meritmind.se eller brightby.se"
sleep 5
return
$OUname = $null
}

if ($OUname -ne $null)
{
$ReturnValue = $null
$Name = "$FirstName $LastName"
$OUPath = "DC=meritmind,DC=local"


$lowercase = ("a","b","c","d","e","f","g","h","i","j","k","m","n","p","q","r","s","t","u","v","w","x","y","z")
$uppercase = ("A","B","C","D","E","F","G","H","J","K","L","M","N","P","Q","R","S","T","U","V","W","X","Y","Z")
$symbols = ("!","@","#","%")
$p1 = Get-Random $lowercase
$p2 = Get-Random -Minimum 1 -Maximum 9
$p3 = Get-Random $uppercase
$p4 = Get-Random $symbols
$Password = "$p1$p1$p2$p2$p3$p3$p4$p4"

$SamAccountName = "$FirstName.$LastName".ToLower().Replace("å","a").Replace("ä","a").Replace("ö","o").Replace("é","e").Replace("ü","u").Replace(" ","")
if ($SamAccountName.Length -gt 20)
{
$SamAccountName = $SamAccountName.Substring(0,20)
}

if (!(Get-Module | where {$_.Name -match "ActiveDirectory"})) { Import-Module ActiveDirectory }

$ErrorActionPreference = "Stop"
New-ADUser -UserPrincipalName $UserPrincipalName -Path "OU=$OUname,$OUPath" -AccountPassword (ConvertTo-SecureString -AsPlainText $Password -Force) -GivenName $FirstName -SurName $LastName -SamAccountName $SamAccountName -Name $Name -DisplayName $Name -ChangePasswordAtLogon:$False -Enabled:$True -Confirm:$False -ErrorVariable ReturnValue

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

if (!($AssocieradKonsult -eq "Y"))
{
Get-ADUser -Filter {UserPrincipalName -eq $UserPrincipalName} | Set-ADUser -EmailAddress $UserPrincipalName -Add @{proxyAddresses="SMTP:$UserPrincipalName"} -ErrorVariable ReturnValue
}

if ($CopyGroupMembershipFrom)
{
if (!(Get-ADUser -Filter {UserPrincipalName -eq $CopyGroupMembershipFrom}))
{
Write-Host -ForegroundColor Red "Kan ej hitta kontot $CopyGroupMembershipFrom som behörigheter skall kopieras från. Verifiera att UPN stämmer."
sleep 5
return
}
else
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
}


if ($UserPrincipalName -like "*@meritmind.se")
{
Add-ADGroupMember -Identity "alla.meritmind@meritmind.se" -Members $SamAccountName -ErrorVariable ReturnValue
if ($AssocieradKonsult -ne "Y")
{
Add-ADGroupMember -Identity "allusers@meritmind.se" -Members $SamAccountName -ErrorVariable ReturnValue
}
}
elseif ($UserPrincipalName -like "*@brightby.se" -and $AnstalldKonsult -ne "Y")
{
Add-ADGroupMember -Identity "MM.Brightby.G.Access" -Members $SamAccountName -ErrorVariable ReturnValue
}


if ($AssocieradKonsult -ne "Y" -and $AnstalldKonsult -ne "Y")
{
$OUname = $OUname -replace "_.*="

$HomeFolderPath = Join-Path $FileServerPath "$OUname\Home"

New-Item -ItemType Container "$HomeFolderPath\$SamAccountName" -ErrorVariable ReturnValue

$ErrorActionPreference = "SilentlyContinue"

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
}
until ((Get-Item "$HomeFolderPath\$SamAccountName") -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired while creating folders."
return
}

$SID = (Get-ADUser $SamAccountName).SID

$Path = "$HomeFolderPath\$SamAccountName"
$IdentityReference = New-Object System.Security.Principal.SecurityIdentifier $SID
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
$ACE = (Get-Acl $Path).access | where {$_.IdentityReference -eq "MERITMIND\$SamAccountName"}
}
until (($ACE.FileSystemRights) -eq "FullControl" -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired while adding $FileSystemRights permission for $($Group.Name) on path $Path"
return
}


$Path = "$HomeFolderPath\$SamAccountName"
$IdentityReference = New-Object System.Security.Principal.SecurityIdentifier (Get-ADGroup "Domain Admins").SID
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
$ACE = (Get-Acl $Path).access | where {$_.IdentityReference -eq "MERITMIND\Domain Admins"}
}
until (($ACE.FileSystemRights) -eq "FullControl" -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired while adding $FileSystemRights permission for $($Group.Name) on path $Path"
return
}

Set-ADUser $SamAccountName -HomeDrive H -HomeDirectory "$HomeFolderPath\$SamAccountName"
}
}


Write-Host $ReturnValue
if (!$ReturnValue)
{
Write-Host -ForegroundColor Green "AD-konto $UserPrincipalName skapat!"
Write-Host -ForegroundColor Cyan "Lösenord: $Password"
}
Pause