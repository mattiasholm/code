$ErrorActionPreference = "SilentlyContinue"

$UserProfiles = Get-ChildItem "C:\Users"


$OldProfile = $UserProfiles | Where-Object {$_.Name -eq "$env:USERNAME"}
$NewProfile = $UserProfiles | Where-Object {$_.Name -eq "$env:USERNAME.MERITMIND"}

if (!($OldProfile))
{
Write-Host -ForegroundColor Red "Hittar ej gammal profil!"
sleep 10
break
}

if (!($NewProfile))
{
Write-Host -ForegroundColor Red "Hittar ej ny profil!"
sleep 10
break
}


$OldAutoCompleteCache = Get-ChildItem "$($OldProfile.FullName)\AppData\Local\Microsoft\Outlook\RoamCache" | Where-Object {$_.Name -like "Stream_Autocomplete_0_*"} | Sort-Object -Property LastWriteTime -Descending | Select-Object -First 1

if (!($OldAutoCompleteCache))
{
Write-Host -ForegroundColor Red "Hittar ej gammal AutoComplete-cache!"
sleep 10
break
}


$NewAutoCompleteCache = Get-ChildItem "$($NewProfile.FullName)\AppData\Local\Microsoft\Outlook\RoamCache" | Where-Object {$_.Name -like "Stream_Autocomplete_0_*"} | Sort-Object -Property LastWriteTime -Descending | Select-Object -First 1

if (!($NewAutoCompleteCache))
{
Write-Host -ForegroundColor Red "Hittar ej ny AutoComplete-cache!"
sleep 10
break
}

Copy-Item -Path $OldAutoCompleteCache.FullName -Destination "$($NewProfile.FullName)\AppData\Local\Microsoft\Outlook\RoamCache"

$OldAutoCompleteCacheGuid = $OldAutoCompleteCache.Name -replace "Stream_Autocomplete_0_","" -replace ".dat",""
$NewAutoCompleteCacheGuid = $NewAutoCompleteCache.Name -replace "Stream_Autocomplete_0_","" -replace ".dat",""

if (Get-Process | Where-Object {$_.ProcessName -eq "outlook"})
{
Stop-Process -Name "outlook"
sleep 3
}

Remove-Item $NewAutoCompleteCache.FullName
Rename-Item -Path "$($NewProfile.FullName)\AppData\Local\Microsoft\Outlook\RoamCache\$OldAutoCompleteCache" -NewName "$NewAutoCompleteCache"

if (Test-Path "$($NewProfile.FullName)\AppData\Local\Microsoft\Outlook\RoamCache\$NewAutoCompleteCache")
{
Write-Host -ForegroundColor Green "AutoComplete överkopierad till ny profil!"
sleep 10
}
else
{
Write-Host -ForegroundColor Red "Kopiering misslyckades!"
sleep 10
}