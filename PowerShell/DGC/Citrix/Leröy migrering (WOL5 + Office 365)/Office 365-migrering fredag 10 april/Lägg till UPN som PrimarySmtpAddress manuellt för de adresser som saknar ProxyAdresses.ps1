$UserPrincipalName = "eorder@leroy.se"

$User = Get-ADUser -SearchBase "OU=Leroy,OU=Customers,OU=Hosting2,DC=emcat,DC=com" -Filter {UserPrincipalName -eq $UserPrincipalName}

$PrimarySmtpAddress = "SMTP:$UserPrincipalName"

Set-ADUser $User -Add @{proxyAddresses=$PrimarySmtpAddress}