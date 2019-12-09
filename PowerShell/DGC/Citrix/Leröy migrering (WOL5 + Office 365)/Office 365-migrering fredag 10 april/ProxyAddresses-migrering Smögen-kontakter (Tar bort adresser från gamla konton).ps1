$Users = Get-ADUser -SearchBase "OU=Leroy,OU=Customers,OU=Hosting2,DC=emcat,DC=com" -Filter * -Properties * -SearchScope Subtree

foreach ($User in $Users)
{
$UserPrincipalName = $User.DisplayName

if (Get-ADObject -SearchBase "OU=Leroy,OU=Hosting,DC=emcat,DC=com" -SearchScope Subtree -Filter {ObjectClass -eq "contact"} -Properties * | where {$_.Name -like "*$UserPrincipalName*"})
{

$OldUser = Get-ADObject -SearchBase "OU=Leroy,OU=Hosting,DC=emcat,DC=com" -SearchScope Subtree -Filter {ObjectClass -eq "contact"} -Properties * | where {$_.Name -like "*$UserPrincipalName*"}
$ProxyAddresses = $OldUser.proxyAddresses
foreach ($ProxyAddress in $ProxyAddresses)
{
if (!($ProxyAddress -like "*hostingcustomer*" -or $ProxyAddress -like "*msxcustomer*" -or $ProxyAddress -like "X400:*"))
{
Set-ADUser $User -Add @{ProxyAddresses=$ProxyAddress}
}
}
$X500 = "X500:$($OldUser.LegacyExchangeDN)"
Set-ADUser $User -Add @{proxyAddresses=$X500}
Set-ADObject $OldUser -Clear proxyAddresses
}
else
{
#Write-Host -ForegroundColor Yellow "$UserPrincipalName finns ej"
}
}




### VERIFIERA:

$Users = Get-ADUser -SearchBase "OU=Leroy,OU=Customers,OU=Hosting2,DC=emcat,DC=com" -Filter * -Properties * -SearchScope Subtree

foreach ($User in $Users)
{
$User.proxyAddresses
}