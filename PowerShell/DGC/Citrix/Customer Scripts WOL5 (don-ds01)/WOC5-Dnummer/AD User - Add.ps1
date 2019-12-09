$UserPrincipalName = "mattias.holm@donator.se"
$FirstName = "Mattias"
$LastName = "Holm"
$MobilePhone = "+46707800740"
$CopyGroupMembershipFrom = "gustaf.merkander@donator.se"
$OUname = "Donator"



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



Write-Host $ReturnValue
Write-Host -ForegroundColor Green "AD-konto $UserPrincipalName skapat!"
Write-Host -ForegroundColor Cyan "Lösenord: $Password"