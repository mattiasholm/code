#!/usr/bin/env pwsh

param
(
    [Parameter(
        Mandatory,
        Position = 0,
        HelpMessage = 'Ange personnummer (YYMMDD-XXXX).')]
    [ValidatePattern('^[0-9]{6,8}[-+]?[0-9]{4}$')]
    [string] $Personnummer
)

$Kontrollsiffra = $Personnummer.Substring($Personnummer.Length - 2, 1)

if ($Kontrollsiffra % 2 -eq 0) {
    $Sex = 'Kvinna'
}
else {
    $Sex = 'Man'
}

Write-Host "Personen är en $($Sex.ToLower())."