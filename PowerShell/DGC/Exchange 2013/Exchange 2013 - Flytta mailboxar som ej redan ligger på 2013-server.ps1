$Mailboxes = Get-Mailbox -OrganizationalUnit "OU=Donator,OU=Hosting,DC=emcat,DC=com" | where {$_.AdminDisplayVersion -notlike "*15*"}

Foreach ($Mailbox in $Mailboxes)
{
Remove-MoveRequest $Mailbox.Identity -Confirm:$false # Gamla move requests m�ste rensas innan en ny kan startas!
$guid = Get-MailboxDatabase DB05 | select guid
$guid = $guid -Replace("@{Guid=", "") -Replace("}","")
New-MoveRequest $Mailbox.Identity -TargetDatabase $guid -Confirm:$false -BadItemLimit 1000 # BadItemLimit m�ste s�ttas om flytten tidigare Failat p.g.a. korrupta meddelanden
}