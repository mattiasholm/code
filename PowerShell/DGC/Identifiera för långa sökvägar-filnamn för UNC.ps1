$SourceFolderPath = Read-Host "Ange sökväg till source-folder som skall kopieras"
$DestinationFolderPath = Read-Host "Ange sökväg till destionation-folder dit filerna skall kopieras"

$CopyReady = $true
$PathLengthDifference = $DestinationFolderPath.Length - $SourceFolderPath.Length

$ChildItems = Get-ChildItem $SourceFolderPath -Recurse

foreach ($ChildItem in $ChildItems)
{
$OldLength = $ChildItem.FullName.Length
$NewLength = $OldLength + $PathLengthDifference

if ($NewLength -ge 260)
{
$CopyReady = $false
Write-Host -NoNewline -ForegroundColor Red "$($NewLength-259) TECKEN FÖR LÅNGT NAMN: "
Write-Host $ChildItem.FullName
}
}

if ($CopyReady -eq $true)
{
$Confirm = Read-Host "Inga filnamn är för långa för destinationsmappen. Starta kopiering? (y/n)"
if ($Confirm -eq "y")
{
Robocopy.exe $SourceFolderPath $DestinationFolderPath /z /e /R:10
Write-Host -ForegroundColor Green "Kopiering slutförd!"
pause
}
}