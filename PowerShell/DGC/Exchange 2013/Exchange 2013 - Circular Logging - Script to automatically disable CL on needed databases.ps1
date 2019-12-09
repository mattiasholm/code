Add-PSSnapin *exchange*
$ErrorActionPreference = "Stop"



$CLDatabases = Get-MailboxDatabase | Where-Object {$_.CircularLoggingEnabled -eq "True"}

$Answer = Read-Host "Detta skript kommer att stänga ned databaser $CLDatabases. Användarna på dessa databaser kommer att uppleva nedtid. Är du säker? (Y/N)"

if ($Answer -eq "Y" -or $Answer -eq "y")
{

foreach ($CLDatabase in $CLDatabases)
{


Set-MailboxDatabase $CLDatabase -CircularLoggingEnabled:$False
sleep 5
if ((Get-MailboxDatabase $CLDatabase).CircularLoggingEnabled -eq $False)
{
Write-Host -ForegroundColor Green "CL avstängt!"
}
else
{
Write-Host -ForegroundColor Red "Lyckades ej stänga av CL!"
return
}


Dismount-Database $CLDatabase -Confirm:$False
sleep 5
if ((Get-MailboxDatabase $CLDatabase -Status).Mounted -eq $False)
{
Write-Host -ForegroundColor Green "Databas nedsläckt!"
}
else
{
Write-Host -ForegroundColor Red "Misslyckades att stänga ned databas"
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
Write-Host -ForegroundColor Red "Misslyckades att starta databas. Felsök manuellt!"
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