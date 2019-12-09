$Users = Get-ADUser -Filter * -Properties * -SearchBase "OU=Vasterleden,DC=vasterleden,DC=local"

foreach ($User in $Users)
{
if (!($User.proxyAddresses))
{
$NewPrimarySmtpAddress = $User.UserPrincipalName -replace "vasterleden.local","vasterleden.se"
Set-ADUser $User -Add @{proxyAddresses = "SMTP:$NewPrimarySmtpAddress"} -EmailAddress $NewPrimarySmtpAddress
Write-Host -ForegroundColor Green "$($User.DisplayName) har nu: $NewPrimarySmtpAddress"
}

if ($User.proxyAddresses -notlike "*SMTP:*")
{
Write-Host -ForegroundColor Red "Användaren $($User.DisplayName) har proxyAddresses, men saknar en primär SMTP-adress!)"
}
}