$ErrorActionPreference = "Stop"

$ImportUsers = Import-Csv C:\temp\LeroyImportUsers.txt



foreach ($ImportUser in $ImportUsers)
{
$UserPrincipalName = $ImportUser.UserPrincipalName

if (!(Get-PSSnapin | where {$_.Name -match "Exchange.Management"})) { Add-PSSnapin Microsoft.Exchange.Management.* }
$OldUPN = $UserPrincipalName -replace ".test@","@"
$OldAccount = Get-ADUser -Filter {UserPrincipalName -eq $OldUPN} -Properties *
if ($OldAccount -eq $null)
{
$Recipient = Get-Recipient $OldUPN
if (!($Recipient -eq $null))
{
$Sam = $Recipient.SamAccountName
$OldUPN = (Get-ADUser $Sam).UserPrincipalName
$OldAccount = Get-ADUser -Filter {UserPrincipalName -eq $OldUPN} -Properties *
}
else
{
Write-Host "$UserPrincipalName finns ej sedan tidigare! Lägg upp manuellt!" -ForegroundColor Red
break
}
}
if ($OldAccount.Enabled -eq $false)
{
Write-Host "Kontot $UserPrincipalName är inaktiverat. Verifiera att det verkligen skall läggas upp i nya miljön!" -ForegroundColor Red
break
}

$OldGroups = (Get-ADPrincipalGroupMembership $OldAccount).SamAccountName

$AdUser = Get-ADUser -Filter {UserPrincipalName -eq $UserPrincipalName}



foreach ($OldGroup in $OldGroups)
{
if (($OldGroup -like "Leroy.E*" -and $OldGroup -notlike "*Exchange*" -and $OldGroup -notlike "*Everyone*" -or $OldGroup -like "Leroy.A*" -and $OldGroup -notlike "*Administrators*" -and $OldGroup -notlike "*Application*" -and $OldGroup -notlike "*Alltifisk*" -or $OldGroup -like "Leroy.F*" -or $OldGroup -like "Leroy.I*" -or $OldGroup -like "Leroy.G.*" -or $OldGroup -like "Leroy.P*" -and $OldGroup -notlike "*Public*" -and $OldGroup -notlike "*Printer*" -or $OldGroup -like "*Windows.Folder*"))
{
Add-ADGroupMember $OldGroup -Members $AdUser.SamAccountName
}
}

}