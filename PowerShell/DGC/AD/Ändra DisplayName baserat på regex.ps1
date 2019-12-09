$Groups = Get-ADGroup -SearchBase "OU=Service Groups,OU=CidronGroups,DC=ad,DC=cidronpay,DC=com" -Filter {Name -like "*Slack*"} -Properties *

foreach ($Group in $Groups)
{
$Length = ($Group.Name.Length) -11

$w1 = ($Group.Name -replace "USERS","Users").Substring(0,11)
$w2 = ($Group.Name -replace "USERS","Users").Substring(11,$Length).ToLower() -replace "slack","Slack"
$Name = "$w1$w2"

Rename-ADObject $Group.ObjectGUID -NewName $Name
}