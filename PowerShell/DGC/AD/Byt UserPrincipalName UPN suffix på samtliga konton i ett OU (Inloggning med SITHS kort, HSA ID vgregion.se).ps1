$Users = Get-ADUser -SearchBase "OU=Ravlanda,OU=Customers,OU=Hosting2,DC=emcat,DC=com" -Filter {UserPrincipalName -like "SE*"}

foreach ($User in $Users)
{

$NewUserPrincipalName = $User.UserPrincipalName -replace "@.*","@vgregion.se"

Set-ADUser $User.SamAccountName -UserPrincipalName $NewUserPrincipalName
Write-Host -ForegroundColor Green "Changed UserPrincipalName from $($User.UserPrincipalName) to $NewUserPrincipalName"
}