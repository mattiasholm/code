$ErrorActionPreference = "SilentlyContinue"

$DomainAdmins = Get-ADGroupMember "Domain Admins"

foreach ($DomainAdmin in $DomainAdmins)
{
Get-ADUser $DomainAdmin -Properties * | Select-Object Name,Enabled,PasswordLastSet,whenCreated
Get-ADGroup $DomainAdmin -Properties * | Select-Object Name,Enabled,PasswordLastSet,whenCreated
}






$ErrorActionPreference = "SilentlyContinue"

$DomainAdmins = Get-ADGroupMember "Donator Domain Admins"

foreach ($DomainAdmin in $DomainAdmins)
{
Get-ADUser $DomainAdmin -Properties * | Select-Object Name,Enabled,PasswordLastSet,whenCreated
Get-ADGroup $DomainAdmin -Properties * | Select-Object Name,Enabled,PasswordLastSet,whenCreated
}