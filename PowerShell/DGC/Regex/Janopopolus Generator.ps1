# FIXA FLER KONSONANTER - NU EXEMPELVIS SANDRA BLIR SANOPOPOLUS OCH INTE SANDROPOPOLUS!!!


$FirstName = Read-Host "Ange förnamn"

$Mode = Read-Host "Ange mode [Grekland, Polen, Ryssland]"

if ($Mode -ne "Grekland" -and $Mode -ne "Polen" -and $Mode -ne "Ryssland")
{
Write-Host -ForegroundColor Red "Felaktigt mode"
break
}

$Remove = $FirstName -replace "^[bcdfghjklmnpqrstvwxz]*[bcdfghjklmnpqrstvwxz][aeiouyåäö][bcdfghjklmnpqrstvwxz]"
$FirstSyllable = $FirstName -replace $Remove

switch ($Mode)
{
"Grekland" {$Suffix = "opopolus"}
"Polen" {$Suffix = "inowski"}
"Ryssland" {$Suffix = "atjov"}
}

$ResultName = "$FirstSyllable$Suffix"

Write-Host -ForegroundColor Green "$ResultName`n"

Pause