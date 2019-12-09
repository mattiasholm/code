$users = Get-ADUser -SearchBase "OU=Leroy,OU=Customers,OU=Hosting2,DC=emcat,DC=com" -Filter * -Properties *



foreach ($user in $users)
{
Set-ADUser $user -Clear proxyAddresses
}