# Egen class för personnummer??? Hur verifiera indata endast nummer och streck? Regex?

$Personnummer = '910324-3391'
$Personnummer = '9103243391'
$Personnummer = '19910324-3391'
$Personnummer = '199103243391'

$Kontrollsiffra = $Personnummer.Substring($Personnummer.Length - 4).Substring(2,1)

if ($Kontrollsiffra % 2 -eq 0) {
    $Sex = 'Kvinna'
}
else {
    $Sex = 'Man'
}

$Sex