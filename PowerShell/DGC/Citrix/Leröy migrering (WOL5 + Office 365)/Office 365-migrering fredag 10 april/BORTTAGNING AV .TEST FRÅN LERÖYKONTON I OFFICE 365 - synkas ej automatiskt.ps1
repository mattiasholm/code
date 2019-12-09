$Users = Get-MsolUser | where {$_.UserPrincipalName -like "*.test@leroy.se"}

foreach ($User in $Users)
{
$UserPrincipalName = $User.UserPrincipalName
$NewUserPrincipalName = $User.UserPrincipalName -replace ".test@leroy.se","@leroy.se"
Set-MsolUserPrincipalName -UserPrincipalName $UserPrincipalName -NewUserPrincipalName $NewUserPrincipalName
Write-Host "Changed $UserPrincipalName to $NewUserPrincipalName"
}