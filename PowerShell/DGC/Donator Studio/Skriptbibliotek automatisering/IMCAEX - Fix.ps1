$UserPrincipalName = "mattias@longdrink.se"
$IMCEAEX = "IMCEAEX-_o=Donator_ou=Exchange+20Administrative+20Group+20+28FYDIBOHF23SPDLT+29_cn=Recipients_cn=mattias+2Elongdrink@msxcustomer.donator.se"



if (!(Get-PSSnapin | where {$_.Name -match "Exchange.Management"})) { Add-PSSnapin Microsoft.Exchange.Management.* }
$ReturnValue = $null
$Mailbox = Get-Mailbox $UserPrincipalName

$X500 = "X500:"+$($IMCEAEX -replace "IMCEAEX-" -replace "_","/" -replace "\+20"," " -replace "\+28","(" -replace "\+29",")" -replace "\+2E","." -replace "@.*" -replace "\+40","@" -replace "\+2C","," -replace "\+5F","_")

$ErrorActionPreference = "Stop"
Set-Mailbox $Mailbox -EmailAddresses @{add=$X500} -ErrorVariable ReturnValue