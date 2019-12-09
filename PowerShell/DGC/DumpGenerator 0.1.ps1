$Damer = "Malin", "Marica", "Isabell"

$UtvaldDam = Get-Random $Damer

foreach ($Dam in $Damer) {
    if ($Dam -eq $UtvaldDam) {
        Write-Host "Ask $Dam out"
    }
    else {
        Write-Host "Break up with $Dam"
    }
}