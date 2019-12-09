$Users = Get-ADUser -SearchBase "OU=Leroy,OU=Customers,OU=Hosting2,DC=emcat,DC=com" -Filter * -Properties * -SearchScope Subtree

foreach ($User in $Users)
{
$proxyAddresses = $User.proxyAddresses
$PrimarySmtpAddress = $proxyAddresses | findstr "SMTP:"
$SipAddress = $PrimarySmtpAddress -replace "SMTP:","sip:"
Set-ADUser $User -Add @{proxyAddresses=$SipAddress}
Write-Host -ForegroundColor Green "$SipAddress added to $($User.UserPrincipalName)"
}