$OUname = "Donator"



if (!(Get-Module | where {$_.Name -match "ActiveDirectory"})) { Import-Module ActiveDirectory }
$ReturnValue = $null
$OUPath = "OU=Customers,OU=Hosting2,DC=emcat,DC=com"
$SubOU = "Applications"
$MigrationGroup = "$OUname.WO.ToBeMigrated"

$Users = Get-ADGroupMember $MigrationGroup
$Groups = Get-ADGroup -SearchBase "OU=$SubOU,OU=$OUname,$OUPath" -Filter {SamAccountName -like "*.WO.Application*"}

foreach ($User in $Users)
{
foreach ($Group in $Groups)
{
$ErrorActionPreference = "Stop"
Add-ADGroupMember -Identity $Group -Members $User -ErrorVariable ReturnValue
}
}