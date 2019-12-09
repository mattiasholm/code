$Identity = "webbkontakt@vulkanresor.se"
$Users = (Get-Mailbox $Identity | Get-MailboxPermission | where {$_.AccessRights -eq "FullAccess" -and $_.User -like "*@vulkanresor.se" -and $_.User -ne "ulf.nordstrom@vulkanresor.se"}).User

foreach ($User in $Users)
{
Remove-MailboxPermission -Identity $Identity -User $User -AccessRights FullAccess -Confirm:$False
Add-MailboxPermission -Identity $Identity -User $User -AccessRights ReadPermission -Confirm:$False
}

Get-MailboxPermission -Identity $Identity
