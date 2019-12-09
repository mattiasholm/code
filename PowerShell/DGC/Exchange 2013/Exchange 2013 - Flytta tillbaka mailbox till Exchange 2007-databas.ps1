# TA BORT ABP OCH SÄTT OBSOLETA AD-ATTRIBUT:

$Mailboxes = Get-Mailbox test.inm@inmalmo.se
$OAB = "CN=INM.OAB,CN=Offline Address Lists,CN=Address Lists Container,CN=Donator,CN=Microsoft Exchange,CN=Services,CN=Configuration,DC=emcat,DC=com"
$QueryBaseDN = "OU=INM,OU=Hosting,DC=emcat,DC=com"

Foreach ($Mailbox in $Mailboxes)
{
Set-Mailbox $Mailbox.Identity -AddressBookPolicy $Null
$mailbox = Get-Mailbox $Mailbox.Identity 
$aduser = Get-ADUser $mailbox.distinguishedname -Properties *
Set-ADUser $aduser -Add @{msexchUseOAB=$OAB}
Set-ADUser $aduser -Add @{msexchQueryBaseDN=$QueryBaseDN}
}





# FLYTTA TILLBAKA MAILBOXAR TILL EXCHANGE 2007

$Mailboxes = Get-Mailbox test.inm@inmalmo.se

Foreach ($Mailbox in $Mailboxes)
{
Remove-MoveRequest $Mailbox.Identity -Confirm:$False
New-MoveRequest $Mailbox.Identity -TargetDatabase 45f11c96-4064-416c-b228-84d4fdb88951 -Confirm:$False -BadItemLimit 1000
}