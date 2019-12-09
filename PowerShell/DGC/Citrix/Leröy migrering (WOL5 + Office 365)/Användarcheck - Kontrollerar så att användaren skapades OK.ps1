$ImportUsers = Import-Csv C:\temp\LeroyImportUsers.txt


foreach ($ImportUser in $ImportUsers)
{
$UserPrincipalName = $ImportUser.UserPrincipalName

if (Get-ADUser -Filter {UserPrincipalName -eq $UserPrincipalName} -SearchBase "OU=Leroy,OU=Customers,OU=Hosting2,DC=emcat,DC=com")
{
Write-Host "OK" -ForegroundColor Green
}
else
{
Write-Host "$UserPrincipalName SAKNAS" -ForegroundColor Red
}
}