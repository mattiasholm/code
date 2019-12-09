$Users = Get-ADUser -Filter * -Properties * | Where-Object {$_.MobilePhone -ne $null}

foreach ($User in $Users)
{
$MobilePhone = $User.MobilePhone
Set-ADUser $User -Replace @{iBPOtpPhoneNumber=$MobilePhone}
}

# Verifiera:
# Get-ADUser -Filter * -Properties * | Where-Object {$_.MobilePhone -ne $null} | select iBPOtpPhoneNumber



<#


$Users = Get-ADUser -Filter * -Properties * | Where-Object {$_.MobilePhone -ne $null}

foreach ($User in $Users)
{
Set-ADUser $User -MobilePhone $null
}

# Verifiera:
# Get-ADUser -Filter * -Properties * | Where-Object {$_.iBPOtpPhoneNumber -ne $null} | select MobilePhone


#>