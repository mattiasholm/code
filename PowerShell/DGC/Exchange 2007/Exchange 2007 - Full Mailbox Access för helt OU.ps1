# Ge EWS-kontot Full Mailbox Access på alla mailboxar i angiven OU:
$OU = 'Maklarhuset'

$Mailboxes = Get-Mailbox -OrganizationalUnit $OU -ResultSize Unlimited

Foreach($Mailbox in $Mailboxes)
{
Add-MailboxPermission -Identity $Mailbox -User ews.svc -AccessRights FullAccess -InheritanceType All
}