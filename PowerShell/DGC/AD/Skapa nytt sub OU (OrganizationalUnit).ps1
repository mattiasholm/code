$Ort = "Linkoping"
$ReadGroup = "emcat\Maklarhuset.Everyone"


New-ADOrganizationalUnit -Name "MH.$Ort" -DisplayName "MH.$Ort" -Path "OU=Maklarhuset,OU=Hosting,DC=emcat,DC=com"

# Tar bort AuthUsers:R och lägger till Kund.Everyone:R

dsacls "OU=MH.$Ort,OU=Maklarhuset,OU=Hosting,DC=emcat,DC=com" /R "NT AUTHORITY\Authenticated Users"
dsacls "OU=MH.$Ort,OU=Maklarhuset,OU=Hosting,DC=emcat,DC=com" /G "emcat\Maklarhuset.Everyone:GR"