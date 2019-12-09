$Groups = Get-ADGroup -SearchBase "OU=Service Groups,OU=CidronGroups,DC=ad,DC=cidronpay,DC=com" -Filter {Name -like "*Slack*"} -Properties *

foreach ($Group in $Groups)
{

$City = $Group.Name -replace "SEC-Users-","" -replace "-Slack",""

$Members = Get-ADUser -Filter {Enabled -eq $True} -Properties * | Where-Object {$_.City -match $City}

if ($Members)
{
Add-ADGroupMember -Identity $Group -Members $Members
}
}