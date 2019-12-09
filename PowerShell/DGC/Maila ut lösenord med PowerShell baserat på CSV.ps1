$ErrorActionPreference = "Stop"

$MeritmindPasswords = Import-Csv -Path "C:\Temp\Meritmind_Associerade konsulter_Passwordlist.csv" -Delimiter ","

$MeritmindUsers = Import-Csv -Path "C:\Temp\MM_FINAL.csv" -Delimiter ","

foreach ($MeritmindUser in $MeritmindUsers)
{
$MeritmindPassword = $null
$GivenName = $MeritmindUser.'First name'
$Surname = $MeritmindUser.'Last name'
$ADUser = Get-ADUser -Filter {GivenName -eq $GivenName -and Surname -eq $Surname} -SearchBase "OU=Associerade konsulter,OU=Meritmind,DC=meritmind,DC=local" -SearchScope Subtree
$MeritmindUserPrincipalName = $ADUser.UserPrincipalName
$MeritmindPassword = ($MeritmindPasswords | Where-Object {$_.UserPrincipalName -eq "$MeritmindUserPrincipalName"}).Password

if ($MeritmindPassword -eq $null)
{
Write-Host -ForegroundColor Red "$($MeritmindUser.'First Name') $($MeritmindUser.'Last Name') HITTAS EJ"
"$($MeritmindUser.'First Name') $($MeritmindUser.'Last Name')" | Out-File "C:\Temp\Meritmind_PasswordMailing_AccountsNotFound.txt" -Append
}
else
{
$From = "Meritmind Reception <reception@meritmind.se>"
$To = "$($MeritmindUser.'First Name') $($MeritmindUser.'Last Name') <$($MeritmindUser.'Email Address')>"
$Subject = "Nytt lösenord för tidrapportering på Meritmind"
$BodyAsHtml = Get-Content -Path "C:\Temp\Mail.htm"
$BodyAsHtmlWithPassword = $BodyAsHtml -creplace "LÖSENORD","$MeritmindPassword"
Send-MailMessage -From $From -To $To -Subject $Subject -BodyAsHtml "$BodyAsHtmlWithPassword" -DNO onSuccess, onFailure -SmtpServer mail.emcat.com -Encoding UTF8

Write-Host "$($MeritmindUser.'Email Address') får lösenord $MeritmindPassword"
}
}