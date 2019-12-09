$Mappings = Import-Csv C:\Temp\SmogenProxyAddresses.csv -Delimiter ","

foreach ($Mapping in $Mappings)
{
$Emailaddresses = $Mapping.EmailAddresses
$ProxyAddresses = $Emailaddresses -replace "{" -replace "}"
$ProxyAddresses = $ProxyAddresses -split ", "

$UserPrincipalName = $Mapping.PrimarySmtpAddress

if (Get-ADUser -SearchBase "OU=Leroy,OU=Customers,OU=Hosting2,DC=emcat,DC=com" -Filter {UserPrincipalname -eq $UserPrincipalName})
{
$User = Get-ADUser -SearchBase "OU=Leroy,OU=Customers,OU=Hosting2,DC=emcat,DC=com" -Filter {UserPrincipalname -eq $UserPrincipalName}

foreach ($ProxyAddress in $ProxyAddresses)
{
Set-ADUser $User -Add @{ProxyAddresses=$ProxyAddress}
Write-Host -ForegroundColor Green "$($User.UserPrincipalName) får följande adress: $ProxyAddress"
}
}
else
{
Write-Host -ForegroundColor Red "$UserPrincipalName finns ej"
}
}



# Verifiera:

$Mappings = Import-Csv C:\Temp\SmogenProxyAddresses.csv -Delimiter ","

foreach ($Mapping in $Mappings)
{
$Emailaddresses = $Mapping.EmailAddresses
$ProxyAddresses = $Emailaddresses -replace "{" -replace "}"
$ProxyAddresses = $ProxyAddresses -split ", "

$UserPrincipalName = $Mapping.PrimarySmtpAddress

if (Get-ADUser -SearchBase "OU=Leroy,OU=Customers,OU=Hosting2,DC=emcat,DC=com" -Filter {UserPrincipalname -eq $UserPrincipalName})
{
$User = Get-ADUser -SearchBase "OU=Leroy,OU=Customers,OU=Hosting2,DC=emcat,DC=com" -Filter {UserPrincipalname -eq $UserPrincipalName} -Properties *
$User.proxyAddresses
}
}
