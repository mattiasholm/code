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
}

$OldGroups = (Get-ADPrincipalGroupMembership $OldAccount).SamAccountName

$AdUser = Get-ADUser -Filter {UserPrincipalName -eq $UserPrincipalName}



foreach ($OldGroup in $OldGroups)
{
if ($OldGroup -like "*Printer*")
{

# Använd Excel-generator för att skapa nedanstående rader baserat på mappningslista!
switch ($OldGroup)
{
"Leroy.Gbg.Printers.Ricoh.C3502.Allow" {Add-ADGroupMember "Leroy.WO.Printer.Gbg.Gestetner.MPC3502" -Members $AdUser}
"Leroy.Gbg.Printers.Ricoh.C3502.Default.Allow" {Add-ADGroupMember "Leroy.WO.Printer.Gbg.Gestetner.MPC3502.Default" -Members $AdUser}
"Leroy.Gbg.Printers.Ricoh.C4502.Allow" {Add-ADGroupMember "Leroy.WO.Printer.Gbg.Gestetner.MPC4502" -Members $AdUser}
"Leroy.Gbg.Printers.Ricoh.C4502.Default.Allow" {Add-ADGroupMember "Leroy.WO.Printer.Gbg.Gestetner.MPC4502.Default" -Members $AdUser}
"Leroy.Gbg.Printers.Ricoh.C4502.Fraktsedel.Allow" {Add-ADGroupMember "Leroy.WO.Printer.Gbg.Gestetner.MPC4502.Fraktsedel" -Members $AdUser}
"Leroy.Gbg.Printers.HP.LaserJet4200.Allow" {Add-ADGroupMember "Leroy.WO.Printer.Gbg.HP.LaserJet.4200" -Members $AdUser}
"Leroy.Gbg.Printers.HP.LaserJet4200.Default.Allow" {Add-ADGroupMember "Leroy.WO.Printer.Gbg.HP.LaserJet.4200.Default" -Members $AdUser}
"Leroy.Gbg.Printers.Ricoh.MPC2500.Allow" {Add-ADGroupMember "Leroy.WO.Printer.Gbg.RICOH.Aficio.MPC2500" -Members $AdUser}
"Leroy.Gbg.Printers.Ricoh.MPC2500.Default.Allow" {Add-ADGroupMember "Leroy.WO.Printer.Gbg.RICOH.Aficio.MPC2500.SvartVitt.Default" -Members $AdUser}
"Leroy.Gbg.Printers.Ricoh.MPC2500.Default.Allow.Guest" {Add-ADGroupMember "Leroy.WO.Printer.Gbg.RICOH.Aficio.MPC2500.SV.Default.Guest" -Members $AdUser}
"Leroy.Gbg.Printers.Samsung.ML2580N.Allow" {Add-ADGroupMember "Leroy.WO.Printer.Gbg.Samsung.ML-2580N" -Members $AdUser}
"Leroy.Lomma.Printers.Ricoh.MPC2800.Lager.Allow" {Add-ADGroupMember "Leroy.WO.Printer.Lomma.RICOH.Aficio.MPC2800.Lagerkontor" -Members $AdUser}
"Leroy.Lomma.Printers.Ricoh.MPC2800.Lager.Default.Allow" {Add-ADGroupMember "Leroy.WO.Printer.Lomma.RICOH.Aficio.MPC2800.Lagerkontor.Default" -Members $AdUser}
"Leroy.Lomma.Printers.Ricoh.MPC2800.Allow" {Add-ADGroupMember "Leroy.WO.Printer.Lomma.RICOH.Aficio.MPC2800.Teknikrummet" -Members $AdUser}
"Leroy.Lomma.Printers.Ricoh.MPC2800.Default.Allow" {Add-ADGroupMember "Leroy.WO.Printer.Lomma.RICOH.Aficio.MPC2800.Teknikrummet.Default" -Members $AdUser}
"Leroy.Sthlm.Printers.HP.ColorLaserJet3600.Allow" {Add-ADGroupMember "Leroy.WO.Printer.Sthlm.Anders.HP_LJ3600" -Members $AdUser}
"Leroy.Sthlm.Printers.HP.ColorLaserJet3600.Default.Allow" {Add-ADGroupMember "Leroy.WO.Printer.Sthlm.Anders.HP_LJ3600.Default" -Members $AdUser}
"Leroy.Sthlm.Printers.Ricoh.AficioMP201_1.Allow" {Add-ADGroupMember "Leroy.WO.Printer.Sthlm.RICOH.Aficio.MP201_1" -Members $AdUser}
"Leroy.Sthlm.Printers.Ricoh.AficioMP201_1.Default.Allow" {Add-ADGroupMember "Leroy.WO.Printer.Sthlm.RICOH.Aficio.MP201_1.Default" -Members $AdUser}
"Leroy.Sthlm.Printers.Ricoh.AficioMP201_2.Allow" {Add-ADGroupMember "Leroy.WO.Printer.Sthlm.RICOH.Aficio.MP201_2" -Members $AdUser}
"Leroy.Sthlm.Printers.Ricoh.AficioMP201_2.Default.Allow" {Add-ADGroupMember "Leroy.WO.Printer.Sthlm.RICOH.Aficio.MP201_2.Default" -Members $AdUser}
"Leroy.Sthlm.Printers.Ricoh.AficioMP201_3.Default.Allow" {Add-ADGroupMember "Leroy.WO.Printer.Sthlm.RICOH.Aficio.MP201_3.Default" -Members $AdUser}
"Leroy.Sthlm.Printers.Ricoh.AficioMPC5501_1.Allow" {Add-ADGroupMember "Leroy.WO.Printer.Sthlm.RICOH.Aficio.MPC5501_1" -Members $AdUser}
"Leroy.Sthlm.Printers.Ricoh.AficioMPC5501_1.Default.Allow" {Add-ADGroupMember "Leroy.WO.Printer.Sthlm.RICOH.Aficio.MPC5501_1.Default" -Members $AdUser}
"Leroy.Sthlm.Printers.Ricoh.AficioMPC5501_2.Allow" {Add-ADGroupMember "Leroy.WO.Printer.Sthlm.RICOH.Aficio.MPC5501_2" -Members $AdUser}
"Leroy.Sthlm.Printers.Ricoh.AficioMPC5501_2.Default.Allow" {Add-ADGroupMember "Leroy.WO.Printer.Sthlm.RICOH.Aficio.MPC5501_2.Default" -Members $AdUser}
"Leroy.Sthlm.Printers.Ricoh.AficioMPC5501_2.Default.Allow.Guest" {Add-ADGroupMember "Leroy.WO.Printer.Sthlm.RICOH.Aficio.MPC5501_2.Default.Guest" -Members $AdUser}
}



}
}

}