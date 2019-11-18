$Personnummer = '196805221281'
$Personnummer = '19680522-1281'
$Personnummer = '6805221281'
$Personnummer = '680522-1281'
$Personnummer = '680522-12812'
$Personnummer = Read-Host -Prompt 'Please enter Personnummer'

if ($Personnummer -notmatch '^[0-9]{6,8}-?[0-9]{4}$') {
    Throw "Invalid format: $Personnummer. Please use the format YYMMDD-XXXX."
}

$Kontrollsiffra = $Personnummer.Substring($Personnummer.Length - 2,1)

if ($Kontrollsiffra % 2 -eq 0) {
    $Sex = 'Kvinna'
}
else {
    $Sex = 'Man'
}

$Sex