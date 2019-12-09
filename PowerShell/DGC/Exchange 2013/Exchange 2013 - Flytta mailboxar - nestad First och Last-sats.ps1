$AllMailboxes = Get-Mailbox -Database DB05 | select -Last 50

$MailboxesBatch1 = $AllMailboxes | select -First 25
$MailboxesBatch2 = $AllMailboxes | select -Last 25


Foreach ($Mailbox in $MailboxesBatch1)
{
New-MoveRequest $Mailbox -TargetDatabase DB10v -BadItemLimit 1000
}

Foreach ($Mailbox in $MailboxesBatch2)
{
New-MoveRequest $Mailbox -TargetDatabase DB08v -BadItemLimit 1000
}