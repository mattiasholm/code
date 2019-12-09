$Users = Get-ADUser -SearchBase "OU=Leroy,OU=Customers,OU=Hosting2,DC=emcat,DC=com" -Filter * -Properties * -SearchScope Subtree

foreach ($User in $Users)
{
$proxyAddresses = $User.proxyAddresses
$PrimarySmtpAddress = $proxyAddresses | findstr "SMTP:"
$365Address = $PrimarySmtpAddress -replace "SMTP:","smtp:" -replace "@leroy.se","@leroysmogen.mail.onmicrosoft.com"
$targetAddress = $365Address -replace "smtp:","SMTP:"

# Lägger till ny 365-adress för mailflöde Hosted Exchange-Office 365:
Set-ADUser $User -Add @{proxyAddresses=$365Address}
Write-Host "$365Address added to $($User.UserPrincipalName)"

# Sätter ovannämnda adress i AD-attribut targetAddress:
Set-ADUser $User -Add @{targetAddress=$targetAddress}
Write-Host -ForegroundColor Green "Updated targetAddress attribute: $targetAddress"
}





# Verifiera:

$Users = Get-ADUser -SearchBase "OU=Leroy,OU=Customers,OU=Hosting2,DC=emcat,DC=com" -Filter * -Properties * -SearchScope Subtree

foreach ($User in $Users)
{
$User.targetAddress
#$User.proxyAddresses |findstr mail.onmicrosoft.com
}