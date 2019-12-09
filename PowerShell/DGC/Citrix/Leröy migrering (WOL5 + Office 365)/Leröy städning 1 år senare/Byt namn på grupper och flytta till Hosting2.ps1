$Groups = Get-ADUser -SearchBase "OU=Leroy,OU=Customers,OU=Hosting2,DC=emcat,DC=com" -Filter * | Get-ADPrincipalGroupMembership | Where-Object {$_.DistinguishedName -like "*OU=Leroy,OU=Hosting,DC=emcat,DC=com*"} | Sort-Object -Unique

foreach ($Group in $Groups)
{
$NewSamAccountName = $Group.SamAccountName -replace "^Leroy.","Leroy.Folder."
Move-ADObject $Group.distinguishedName -TargetPath "OU=Functions,OU=Leroy,OU=Customers,OU=Hosting2,DC=emcat,DC=com"
Set-ADGroup $Group.SamAccountName -SamAccountName $NewSamAccountName -DisplayName $NewSamAccountName
# Ändra Cn-attribut manuellt för att namnet skall uppdateras i ADUC!
}