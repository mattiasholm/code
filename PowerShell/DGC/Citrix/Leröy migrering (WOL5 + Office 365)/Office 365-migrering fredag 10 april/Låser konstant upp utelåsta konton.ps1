while ($true)
{
$LockedAccounts = Search-ADAccount -LockedOut -SearchBase "OU=Leroy,OU=Customers,OU=Hosting2,DC=emcat,DC=com"

foreach ($LockedAccount in $LockedAccounts)
{
Unlock-ADAccount $LockedAccount
}
Write-Host "Låser upp $LockedAccount"
sleep 5
}