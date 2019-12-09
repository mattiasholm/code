$Group = "WO.TestFunction"



if (!(Get-Module | where {$_.Name -match "ActiveDirectory"})) { Import-Module ActiveDirectory }
$ReturnValue = $null
$OUPath = "OU=Hosting2,DC=emcat,DC=com"
$SubOU = "Functions"


$ErrorActionPreference = "Stop"
New-ADGroup -GroupCategory Security -GroupScope Global -Name $Group -DisplayName $Group -Path "OU=$SubOU,$OUPath" -ErrorVariable ReturnValue

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
$ErrorActionPreference = "SilentlyContinue"
}
until ([adsi]::Exists("LDAP://CN=$Group,OU=$SubOU,$OUPath") -eq $True -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired while creating group $Group"
return
}