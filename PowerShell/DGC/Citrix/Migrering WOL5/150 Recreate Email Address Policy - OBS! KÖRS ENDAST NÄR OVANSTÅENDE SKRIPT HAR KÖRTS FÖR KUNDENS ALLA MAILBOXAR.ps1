$OU = "Donator"
$Domain = "donator.se"
$RecipientPolicy = "Donator.RP"



$ReturnValue = $null
if (!(Get-PSSnapin | where {$_.Name -match "Exchange.Management"})) { Add-PSSnapin Microsoft.Exchange.Management.* }

$ErrorActionPreference = "Stop"
Remove-EmailAddressPolicy $RecipientPolicy -Confirm:$False -ErrorVariable ReturnValue

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
$ErrorActionPreference = "SilentlyContinue"
}
until (!(Get-EmailAddressPolicy "$OU.EAP" -or $Timeout -le 0))

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired during deletion of EmailAddressPolicy $OUname.EAP."
return
}


$ErrorActionPreference = "Stop"
New-EmailAddressPolicy -Name $OU".EAP" -EnabledPrimarySMTPAddressTemplate "SMTP:%m@$Domain" -ConditionalCustomAttribute1 $Domain -IncludedRecipients "AllRecipients" -ErrorVariable ReturnValue

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
$ErrorActionPreference = "SilentlyContinue"
}
until ((Get-EmailAddressPolicy "$OU.EAP") -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired during creation of EmailAddressPolicy $OUname.EAP."
return
}


$ErrorActionPreference = "Stop"
Update-EmailAddressPolicy $OU".EAP" -ErrorVariable ReturnValue

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
$ErrorActionPreference = "SilentlyContinue"
}
until ((Get-EmailAddressPolicy "$OU.EAP").RecipientFilterApplied -eq $True -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired while applying EmailAddressPolicy $OUname.EAP."
return
}