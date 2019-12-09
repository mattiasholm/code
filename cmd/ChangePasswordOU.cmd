dsquery user "OU=ItrimUS,OU=Itrim,OU=hosting,DC=emcat,DC=com" -limit 0 | dsmod user -pwd AA11AAss

REM Bättre att använda PowerShell: Import-Module ActiveDirectory ; Get-ADUser -Filter * -SearchScope Subtree -SearchBase "OU=ItrimUS,OU=Itrim,OU=hosting,DC=emcat,DC=com" | Set-ADAccountPassword -Reset -NewPassword (ConvertTo-SecureString -AsPlainText "AA11AAss" -Force)