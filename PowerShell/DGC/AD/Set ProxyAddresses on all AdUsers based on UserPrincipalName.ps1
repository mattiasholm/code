$Users = Get-ADUser -Filter * -Properties *

foreach ($User in $Users)
{
$PrimarySmtpAddress = $null
if ($User.UserPrincipalName -notlike "*local*")
{
$PrimarySmtpAddress = $User.UserPrincipalName
$ProxyAddress = "SMTP:$PrimarySmtpAddress"
if (!($User.proxyAddresses -clike "*SMTP:*"))
{
Write-Host "Setting EmailAddress to: $PrimarySmtpAddress"
Set-ADUser -Identity $User.DistinguishedName -EmailAddress $PrimarySmtpAddress -Add @{proxyAddresses=$ProxyAddress}
}
}
}