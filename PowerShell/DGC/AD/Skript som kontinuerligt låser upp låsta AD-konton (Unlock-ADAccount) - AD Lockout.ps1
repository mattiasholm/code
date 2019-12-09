while ($true)
{
$LockedAccounts = Search-ADAccount -LockedOut -SearchBase "OU=Leroy,OU=Customers,OU=Hosting2,DC=emcat,DC=com"

if ($LockedAccounts)
{
foreach ($LockedAccount in $LockedAccounts)
{
Unlock-ADAccount $LockedAccount
}
Write-Host "Låser upp $LockedAccount"
}
else
{
Write-Host "Inga låsta AD-konton."
}
sleep 5
}