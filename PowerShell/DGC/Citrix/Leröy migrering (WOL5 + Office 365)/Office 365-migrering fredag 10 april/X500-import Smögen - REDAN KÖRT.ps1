$LegacyExchangeDNs = Import-Csv C:\Temp\LegacyExchangeDN.csv -Delimiter ","

foreach ($LegacyExchangeDN in $LegacyExchangeDNs)
{
$X500 = "X500:$($LegacyExchangeDN.LegacyExchangeDN)"
$UserPrincipalName = $LegacyExchangeDN.PrimarySmtpAddress

if (Get-ADUser -SearchBase "OU=Leroy,OU=Customers,OU=Hosting2,DC=emcat,DC=com" -Filter {UserPrincipalname -eq $UserPrincipalName})
{
$User = Get-ADUser -SearchBase "OU=Leroy,OU=Customers,OU=Hosting2,DC=emcat,DC=com" -Filter {UserPrincipalname -eq $UserPrincipalName}
Set-ADUser $User -Add @{ProxyAddresses=$X500}
Write-Host -ForegroundColor Green "$UserPrincipalName klar"
}
else
{
Write-Host -ForegroundColor Red "$UserPrincipalName finns ej"
}
}