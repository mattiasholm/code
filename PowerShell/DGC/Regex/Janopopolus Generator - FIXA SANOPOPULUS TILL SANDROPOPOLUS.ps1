$FirstName = "Sandra"

$Remove = $FirstName -replace "^[bcdfghjklmnpqrstvwxz]*[bcdfghjklmnpqrstvwxz][aeiouyåäö][bcdfghjklmnpqrstvwxz]+"
$FirstSyllable = $FirstName -replace $Remove

$Suffix = "opopolus"
$ResultName = "$FirstSyllable$Suffix"

$ResultName