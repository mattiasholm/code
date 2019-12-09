$ImportUsers = Import-Csv C:\temp\LeroyImportUsers.txt


foreach ($ImportUser in $ImportUsers)
{
$UserPrincipalName = $ImportUser.UserPrincipalName
$Password = $ImportUser.Password



$ErrorActionPreference = "Stop"
if (!(Get-PSSnapin | where {$_.Name -match "Exchange.Management"})) { Add-PSSnapin Microsoft.Exchange.Management.* }
$OldUPN = $UserPrincipalName -replace ".test@","@"
$OldAccount = Get-ADUser -Filter {UserPrincipalName -eq $OldUPN} -Properties *
if ($OldAccount -eq $null)
{
$Recipient = Get-Recipient $OldUPN
if (!($Recipient -eq $null))
{
$Sam = $Recipient.SamAccountName
$OldUPN = (Get-ADUser $Sam).UserPrincipalName
$OldAccount = Get-ADUser -Filter {UserPrincipalName -eq $OldUPN} -Properties *
}
else
{
Write-Host "$UserPrincipalName finns ej sedan tidigare! Lägg upp manuellt!" -ForegroundColor Red
break
}
}
if ($OldAccount.Enabled -eq $false)
{
Write-Host "Kontot $UserPrincipalName är inaktiverat. Verifiera att det verkligen skall läggas upp i nya miljön!" -ForegroundColor Red
break
}
$FirstName = $OldAccount.GivenName
$LastName = $OldAccount.Surname
$MobilePhone = $OldAccount.MobilePhone
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
}