$OUname = "Donator"

$ReturnValue = $null
$OUPath = "OU=Customers,OU=Hosting2,DC=emcat,DC=com"

if (!(Get-Module | where {$_.Name -match "ActiveDirectory"})) { Import-Module ActiveDirectory }

$GroupName = "WO.ToBeMigrated"

$SamAccountName = "$OUname.$GroupName"
$SubOU = "Functions"

$ErrorActionPreference = "Stop"
New-ADGroup -GroupCategory Security -GroupScope Global -Name $SamAccountName -DisplayName $SamAccountName -SamAccountName $SamAccountName -Path "OU=$SubOU,OU=$OUname,$OUPath" -ErrorVariable ReturnValue

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
}
until ([ADSI]::Exists("LDAP://CN=$SamAccountName,OU=$SubOU,OU=$OUname,$OUPath") -eq $True -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired during creation of ADGroup $SamAccountName."
return
}