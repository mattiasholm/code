$Accounts = Get-ADUser -SearchBase "OU=Administration,OU=Donator,OU=Hosting,DC=emcat,DC=com" -Filter {SamAccountName -like "qwe*"}

Foreach ($Account in $Accounts)
{
Add-RoleGroupMember -Identity "Organization Management" -Member $Account.SamAccountName
}