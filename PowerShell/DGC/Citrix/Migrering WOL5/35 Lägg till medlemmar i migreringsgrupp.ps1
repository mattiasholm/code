$OUname = "Donator"
$Members = "gustaf.merkander"


$ReturnValue = $null
$OUPath = "OU=Customers,OU=Hosting2,DC=emcat,DC=com"

if (!(Get-Module | where {$_.Name -match "ActiveDirectory"})) { Import-Module ActiveDirectory }

$GroupName = "WO.ToBeMigrated"

$SamAccountName = "$OUname.$GroupName"
$SubOU = "Functions"

$ErrorActionPreference = "Stop"
Add-ADGroupMember $SamAccountName -Members $Members