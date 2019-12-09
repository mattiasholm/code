$OUname = "Donator"



$ErrorActionPreference = "Stop"
if (!(Get-Module | where {$_.Name -match "ActiveDirectory"})) { Import-Module ActiveDirectory }
if (!(Get-PSSnapin | where {$_.Name -match "Exchange.Management"})) { Add-PSSnapin Microsoft.Exchange.Management.* }
$ReturnValue = $null
$OUPath = "OU=Customers,OU=Hosting2,DC=emcat,DC=com"
$MigrationGroup = "$OUname.WO.ToBeMigrated"
$Users = Get-ADGroupMember $MigrationGroup


foreach ($User in $Users)
{
$Mailbox = Get-Mailbox $User.SamAccountName

(Get-Mailbox $Mailbox).PrimarySmtpAddress.ToString().ToLower()
}