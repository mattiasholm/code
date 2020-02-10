#!/usr/bin/env pwsh

$Personnummer = Read-Host -Prompt 'Ange personnummer (YYMMDD-XXXX)'

if ($Personnummer -notmatch '^[0-9]{6,8}-?[0-9]{4}$') {
    Throw "Ogiltigt format: $Personnummer. Använd format YYMMDD-XXXX."
}

$Kontrollsiffra = $Personnummer.Substring($Personnummer.Length - 2, 1)

if ($Kontrollsiffra % 2 -eq 0) {
    $Sex = 'Kvinna'
}
else {
    $Sex = 'Man'
}

Write-Host "Personen är en $($Sex.ToLower())."