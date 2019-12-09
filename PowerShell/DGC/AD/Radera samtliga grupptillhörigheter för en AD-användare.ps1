SAMAccountName = "adam.boll"

$user = Get-ADUser $SAMAccountName -Properties MemberOf;$userGroups = $user.MemberOf;$userGroups | %{get-ADGroup $_ | Remove-ADGroupMember -Confirm:$false -Member $SAMAccountName}