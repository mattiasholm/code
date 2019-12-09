$OUname = "Kvarters"
$Domain = "kvarterskliniken.se"



$ReturnValue = $null
if (!(Get-PSSnapin | where {$_.Name -match "Exchange.Management"})) { Add-PSSnapin Microsoft.Exchange.Management.* }

$ErrorActionPreference = "Stop"
New-GlobalAddressList -Name $OUname".GAL" -ConditionalCustomAttribute1 $Domain -IncludedRecipients "AllRecipients" -ErrorVariable ReturnValue

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
$ErrorActionPreference = "SilentlyContinue"
}
until ((Get-GlobalAddressList "$OUname.GAL") -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired during creation of GlobalAddressList $OUname.GAL."
return
}

$ErrorActionPreference = "Stop"
Update-GlobalAddressList $OUname".GAL" -ErrorVariable ReturnValue


$ErrorActionPreference = "Stop"
New-AddressList -Name $OUname".AL" -DisplayName $OUname".AL" -ConditionalCustomAttribute1 $Domain -IncludedRecipients "AllRecipients" -ErrorVariable ReturnValue

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
$ErrorActionPreference = "SilentlyContinue"
}
until ((Get-AddressList "$OUname.AL") -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired during creation of AddressList $OUname.AL."
return
}

$ErrorActionPreference = "Stop"
Update-AddressList $OUname".AL" -ErrorVariable ReturnValue


$ErrorActionPreference = "Stop"
New-AddressList -Name $OUname".RL" -DisplayName $OUname".RL" -ConditionalCustomAttribute1 $Domain -IncludedRecipients "Resources" -ErrorVariable ReturnValue

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
$ErrorActionPreference = "SilentlyContinue"
}
until ((Get-AddressList "$OUname.RL") -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired during creation of AddressList $OUname.RL."
return
}

$ErrorActionPreference = "Stop"
Update-AddressList $OUname".RL" -ErrorVariable ReturnValue


$ErrorActionPreference = "Stop"
New-OfflineAddressBook -Name $OUname".OAB" -GlobalWebDistributionEnabled:$True -AddressLists $OUname".AL" -ErrorVariable ReturnValue

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
$ErrorActionPreference = "SilentlyContinue"
}
until ((Get-OfflineAddressBook "$OUname.OAB") -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired during creation of OfflineAddressBook $OUname.OAB."
return
}

$ErrorActionPreference = "Stop"
Update-OfflineAddressBook $OUname".OAB" -ErrorVariable ReturnValue


$ErrorActionPreference = "Stop"
New-AddressBookPolicy -Name $OUname".ABP" -RoomList $OUname".RL" -GlobalAddressList $OUname".GAL" -AddressLists $OUname".AL" -OfflineAddressBook $OUname".OAB" -ErrorVariable ReturnValue

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
$ErrorActionPreference = "SilentlyContinue"
}
until ((Get-AddressBookPolicy "$OUname.ABP") -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired during creation of AddressBookPolicy $OUname.ABP."
return
}

Write-Host $ReturnValue