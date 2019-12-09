$OldGroups = (Get-ADGroup -SearchBase "OU=Leroy,OU=Hosting,DC=emcat,DC=com" -SearchScope Subtree -Filter *).SamAccountName

foreach ($OldGroup in $OldGroups)
{
if (($OldGroup -like "Leroy.E*" -and $OldGroup -notlike "*Exchange*" -and $OldGroup -notlike "*Everyone*" -or $OldGroup -like "Leroy.A*" -and $OldGroup -notlike "*Administrators*" -and $OldGroup -notlike "*Application*" -and $OldGroup -notlike "*Alltifisk*" -or $OldGroup -like "Leroy.F*" -or $OldGroup -like "Leroy.I*" -or $OldGroup -like "Leroy.G.*" -or $OldGroup -like "Leroy.P*" -and $OldGroup -notlike "*Public*" -and $OldGroup -notlike "*Printer*" -or $OldGroup -like "*Windows.Folder*"))
{
Write-Host $OldGroup
}
}