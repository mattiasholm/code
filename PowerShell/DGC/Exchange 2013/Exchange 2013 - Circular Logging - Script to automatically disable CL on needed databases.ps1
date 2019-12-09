Add-PSSnapin *exchange*
$ErrorActionPreference = "Stop"



$CLDatabases = Get-MailboxDatabase | Where-Object {$_.CircularLoggingEnabled -eq "True"}

$Answer = Read-Host "Detta skript kommer att st�nga ned databaser $CLDatabases. Anv�ndarna p� dessa databaser kommer att uppleva nedtid. �r du s�ker? (Y/N)"

if ($Answer -eq "Y" -or $Answer -eq "y")
{

foreach ($CLDatabase in $CLDatabases)
{


Set-MailboxDatabase $CLDatabase -CircularLoggingEnabled:$False
sleep 5
if ((Get-MailboxDatabase $CLDatabase).CircularLoggingEnabled -eq $False)
{
Write-Host -ForegroundColor Green "CL avst�ngt!"
}
else
{
Write-Host -ForegroundColor Red "Lyckades ej st�nga av CL!"
return
}


Dismount-Database $CLDatabase -Confirm:$False
sleep 5
if ((Get-MailboxDatabase $CLDatabase -Status).Mounted -eq $False)
{
Write-Host -ForegroundColor Green "Databas nedsl�ckt!"
}
else
{
Write-Host -ForegroundColor Red "Misslyckades att st�nga ned databas"
return
}


Mount-Database $CLDatabase -Confirm:$False
sleep 5
if ((Get-MailboxDatabase $CLDatabase -Status).Mounted -eq $True)
{
Write-Host -ForegroundColor Green "Databas uppe!"
}
else
{
Write-Host -ForegroundColor Red "Misslyckades att starta databas. Fels�k manuellt!"
return
}
}
Get-MailboxDatabase | select CircularLoggingEnabled,Name
}
else
{
Write-Host -ForegroundColor Yellow "Skript stoppat!"
return
}