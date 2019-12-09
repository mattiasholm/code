$Mailboxes = Get-MailboxDatabase DB01 | Get-Mailbox | where {$_.PrimarySmtpAddress -like "*donator.se"}

Foreach ($Mailbox in $Mailboxes)
{
Remove-MoveRequest $Mailbox.Identity -Confirm:$false # Gamla move requests måste rensas innan en ny kan startas!
$guid = Get-MailboxDatabase DB04 | select guid
$guid = $guid -Replace("@{Guid=", "") -Replace("}","")
New-MoveRequest $Mailbox.Identity -TargetDatabase $guid -Confirm:$false -BadItemLimit 1000 # BadItemLimit måste sättas om flytten tidigare Failat p.g.a. korrupta meddelanden
}