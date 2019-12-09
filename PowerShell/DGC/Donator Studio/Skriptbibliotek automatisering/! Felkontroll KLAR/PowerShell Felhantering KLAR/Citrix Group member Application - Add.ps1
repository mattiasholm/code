$OUname = "Mollerst"
$GlobalGroup = "WO.Application.Office2013.STD"
$SamAccountName = "Test.Mollerst"



if (!(Get-Module | where {$_.Name -match "ActiveDirectory"})) { Import-Module ActiveDirectory }
$ErrorActionPreference = "Stop"
$ReturnValue = $null
$OUPath = "OU=Customers,OU=Hosting2,DC=emcat,DC=com"
$SubOU = "Applications"
$CustomersPath = "\\emcat.com\wo\customers"


$ErrorActionPreference = "Stop"
Add-ADGroupMember -Identity "$OUname.$GlobalGroup" -Members $SamAccountName -ErrorVariable ReturnValue


$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
$ErrorActionPreference = "SilentlyContinue"
}
until ((Get-ADUser $SamAccountName -Properties *).MemberOf -like "*CN=$OUname.$GlobalGroup,OU=$SubOU,OU=$OUname,$OUPath*" -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired while adding ADUser $SamAccountName to ADGroup $OUname.$GlobalGroup"
return
}