$OUname = "Donator"
$Domain = "donator.se"
$ABPName = "Donator.ABP"
$OldOuDN = "OU=Donator,OU=Hosting,DC=emcat,DC=com"



$ReturnValue = $null
if (!(Get-PSSnapin | where {$_.Name -match "Exchange.Management"})) { Add-PSSnapin Microsoft.Exchange.Management.* }

$OUPath = "OU=Customers,OU=Hosting2,DC=emcat,DC=com"
$ABP = Get-AddressBookPolicy $ABPName
$OAB = $ABP.OfflineAddressBook
$AL = $ABP.AddressLists
$RL = $ABP.RoomList
$GAL = $ABP.GlobalAddressList


$ErrorActionPreference = "Stop"
Get-Mailbox -ResultSize Unlimited | where {$_.AddressBookPolicy -eq $ABPName} | Set-Mailbox -AddressBookPolicy $null -ErrorVariable ReturnValue

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
$ErrorActionPreference = "SilentlyContinue"
}
until (!(((Get-Mailbox -OrganizationalUnit $OldOuDN).AddressBookPolicy).Name -eq "$OUname.ABP") -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired during deletion of AddressBookPolicy $OUname.ABP."
return
}

$ErrorActionPreference = "Stop"
Remove-AddressBookPolicy $ABP -Confirm:$False -ErrorVariable ReturnValue

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
$ErrorActionPreference = "SilentlyContinue"
}
until (!(Get-AddressBookPolicy $ABP) -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired during deletion of AddressBookPolicy $OUname.ABP."
return
}

$ErrorActionPreference = "Stop"
Remove-OfflineAddressBook $OAB -Confirm:$False -ErrorVariable ReturnValue

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
$ErrorActionPreference = "SilentlyContinue"
}
until (!(Get-OfflineAddressBook $OAB) -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired during deletion of OfflineAddressBook $OUname.OAB."
return
}


$ErrorActionPreference = "Stop"
Remove-AddressList $RL -Confirm:$False -ErrorVariable ReturnValue

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
Remove-AddressList $AL.Name -Confirm:$False -ErrorVariable ReturnValue

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
$ErrorActionPreference = "SilentlyContinue"
}
until (!(Get-AddressList $AL) -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired during deletion of AddressList $OUname.AL."
return
}


$ErrorActionPreference = "Stop"
Remove-GlobalAddressList $GAL -Confirm:$False

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
$ErrorActionPreference = "SilentlyContinue"
}
until (!(Get-GlobalAddressList $GAL) -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired during deletion of GlobalAddressList $OUname.GAL."
return
}



$ErrorActionPreference = "Stop"
New-GlobalAddressList -Name "$OUname.GAL" -ConditionalCustomAttribute1 $Domain -IncludedRecipients "AllRecipients" -ErrorVariable ReturnValue

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
Update-GlobalAddressList "$OUname.GAL" -ErrorVariable ReturnValue


$ErrorActionPreference = "Stop"
New-AddressList -Name "$OUname.AL" -DisplayName "$OUname.AL" -ConditionalCustomAttribute1 $Domain -IncludedRecipients "AllRecipients" -ErrorVariable ReturnValue

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
Update-AddressList "$OUname.AL" -ErrorVariable ReturnValue


$ErrorActionPreference = "Stop"
New-AddressList -Name "$OUname.RL" -DisplayName "$OUname.RL" -ConditionalCustomAttribute1 $Domain -IncludedRecipients "Resources" -ErrorVariable ReturnValue

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
Update-AddressList "$OUname.RL" -ErrorVariable ReturnValue


$ErrorActionPreference = "Stop"
New-OfflineAddressBook -Name "$OUname.OAB" -GlobalWebDistributionEnabled:$True -AddressLists "$OUname.AL" -ErrorVariable ReturnValue -GeneratingMailbox "CN=SystemMailbox{bb558c35-97f1-4cb9-8ff7-d53741dc928c},CN=Users,DC=emcat,DC=com"

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
New-AddressBookPolicy -Name "$OUname.ABP" -RoomList "$OUname.RL" -GlobalAddressList "$OUname.GAL" -AddressLists "$OUname.AL" -OfflineAddressBook "$OUname.OAB" -ErrorVariable ReturnValue

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

$ErrorActionPreference = "Stop"
Get-Mailbox -OrganizationalUnit $OldOuDN | where {$_.AdminDisplayVersion -like "*15*"} | Set-Mailbox -AddressBookPolicy "$OUname.ABP" -ErrorVariable ReturnValue


$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
$ErrorActionPreference = "SilentlyContinue"
}
until (((Get-Mailbox -OrganizationalUnit $OldOuDN).AddressBookPolicy).Name -eq "$OUname.ABP" -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired during deletion of AddressBookPolicy $OUname.ABP."
return
}