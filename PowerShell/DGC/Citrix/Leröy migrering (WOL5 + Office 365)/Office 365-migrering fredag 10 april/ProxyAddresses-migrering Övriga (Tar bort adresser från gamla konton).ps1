$Users = Get-ADUser -SearchBase "OU=Leroy,OU=Customers,OU=Hosting2,DC=emcat,DC=com" -Filter * -Properties * -SearchScope Subtree

foreach ($User in $Users)
{
$UserPrincipalName = $User.UserPrincipalName
$OldUserPrincipalName = $UserPrincipalName -replace "@leroy.se",".old@leroy.se"


if (Get-ADUser -SearchBase "OU=Leroy,OU=Hosting,DC=emcat,DC=com" -SearchScope Subtree -Filter {UserPrincipalname -eq $OldUserPrincipalName})
{
$OldUser = Get-ADUser -SearchBase "OU=Leroy,OU=Hosting,DC=emcat,DC=com" -SearchScope Subtree -Filter {UserPrincipalname -eq $OldUserPrincipalName} -Properties *
$ProxyAddresses = $OldUser.proxyAddresses
foreach ($ProxyAddress in $ProxyAddresses)
{
if (!($ProxyAddress -like "*hostingcustomer*" -or $ProxyAddress -like "*msxcustomer*" -or $ProxyAddress -like "X400:*"))
{
Set-ADUser $User -Add @{ProxyAddresses=$ProxyAddress}
Set-ADUser $OldUser -Remove @{ProxyAddresses=$ProxyAddress}
}
}
$X500 = "X500:$($OldUser.LegacyExchangeDN)"
Set-ADUser $User -Add @{proxyAddresses=$X500}
Set-ADUser $OldUser -Remove @{proxyAddresses=$X500}
# Tar bor alla proxyadresser:
Set-ADUser $OldUser -Clear proxyAddresses
}
else
{
#Write-Host -ForegroundColor Yellow "$OldUserPrincipalName finns ej"
}
}




### VERIFIERA:

$Users = Get-ADUser -SearchBase "OU=Leroy,OU=Customers,OU=Hosting2,DC=emcat,DC=com" -Filter * -Properties * -SearchScope Subtree

foreach ($User in $Users)
{
$User.proxyAddresses
}