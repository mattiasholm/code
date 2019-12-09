$NewUsers = Get-ADUser -SearchBase "OU=Leroy,OU=Customers,OU=Hosting2,DC=emcat,DC=com" -Filter {UserPrincipalName -like "*.test@leroy.se"}





### 1. ÄNDRAR GAMLA KOLLIDERANDE ANVÄNDARNAMN TILL .OLD:

foreach ($NewUser in $NewUsers)
{
$TestUPN = $NewUser.UserPrincipalName
$NewUPN = $TestUPN -replace ".test@leroy.se","@leroy.se"

if (Get-ADUser -Filter {UserPrincipalName -eq $NewUPN})
{
$OldUser = Get-ADUser -Filter {UserPrincipalName -eq $NewUPN}
Write-Host -ForegroundColor Yellow "Namnet $NewUPN är upptaget"
$OldUPN = $TestUPN -replace ".test@leroy.se",".old@leroy.se"
#replace#Set-ADUser $OldUser -UserPrincipalName $OldUPN
Write-Host "Ändrat $($OldUser.UserPrincipalName) till $OldUPN"
}
else
{
Write-Host -ForegroundColor Green "Namnet $NewUPN är redan ledigt"
}
}



### 2. VERIFIERAR INGA ANVÄNDARNAMN LÄNGRE KOLLIDERAR:

foreach ($NewUser in $NewUsers)
{
$TestUPN = $NewUser.UserPrincipalName
$NewUPN = $TestUPN -replace ".test@leroy.se","@leroy.se"

if (Get-ADUser -Filter {UserPrincipalName -eq $NewUPN})
{
$OldUser = Get-ADUser -Filter {UserPrincipalName -eq $NewUPN}
Write-Host -ForegroundColor Yellow "Namnet $NewUPN är fortfarande upptaget"
$OldUPN = $TestUPN -replace ".test@leroy.se",".old@leroy.se"
}
else
{
Write-Host -ForegroundColor Green "Namnet $NewUPN är nu ledigt"
}
}



### 3. TAR BORT .TEST FRÅN NYA ANVÄNDARNAMN:


foreach ($NewUser in $NewUsers)
{
$TestUPN = $NewUser.UserPrincipalName
$NewUPN = $TestUPN -replace ".test@leroy.se","@leroy.se"

if (Get-ADUser -Filter {UserPrincipalName -eq $NewUPN})
{
$OldUser = Get-ADUser -Filter {UserPrincipalName -eq $NewUPN}
Write-Host -ForegroundColor Red "Namnet $NewUPN är upptaget"
}
else
{

#replace#Set-ADUser $NewUser -UserPrincipalName $NewUPN -WhatIf
Write-Host -ForegroundColor Green "Ändrat $($NewUser.UserPrincipalName) till $NewUPN"
}
}