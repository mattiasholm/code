$Users= Get-ADUser -SearchBase "OU=Leroy,OU=Hosting,DC=emcat,DC=com" -Filter * -Properties * -SearchScope Subtree


foreach ($User in $Users)
{
Set-ADUser $User -Clear proxyAddresses
}