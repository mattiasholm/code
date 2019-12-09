$OUname = "bixtest"
$Domain = "bixtest.se"



$ReturnValue = $null
if (!(Get-PSSnapin | where {$_.Name -match "Exchange.Management"})) { Add-PSSnapin Microsoft.Exchange.Management.* }


$ErrorActionPreference = "Stop"
Remove-AddressBookPolicy "$OUname.ABP" -Confirm:$False -ErrorVariable ReturnValue

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
$ErrorActionPreference = "SilentlyContinue"
}
until (!(Get-AddressBookPolicy "$OUname.ABP") -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired during deletion of AddressBookPolicy $OUname.ABP."
return
}

$ErrorActionPreference = "Stop"
Remove-OfflineAddressBook "$OUname.OAB" -Confirm:$False -ErrorVariable ReturnValue

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
$ErrorActionPreference = "SilentlyContinue"
}
until (!(Get-OfflineAddressBook "$OUname.OAB") -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired during deletion of OfflineAddressBook $OUname.OAB."
return
}


$ErrorActionPreference = "Stop"
Remove-AddressList "$OUname.RL" -Confirm:$False -ErrorVariable ReturnValue

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
$ErrorActionPreference = "SilentlyContinue"
}
until (!(Get-AddressList "$OUname.RL") -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired during deletion of AddressList $OUname.RL."
return
}


$ErrorActionPreference = "Stop"
Remove-AddressList "$OUname.AL" -Confirm:$False -ErrorVariable ReturnValue

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
$ErrorActionPreference = "SilentlyContinue"
}
until (!(Get-AddressList "$OUname.AL") -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired during deletion of AddressList $OUname.AL."
return
}


$ErrorActionPreference = "Stop"
Remove-GlobalAddressList "$OUname.GAL" -Confirm:$False

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
$ErrorActionPreference = "SilentlyContinue"
}
until (!(Get-GlobalAddressList "$OUname.GAL") -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired during deletion of GlobalAddressList $OUname.GAL."
return
}

Write-Host $ReturnValue