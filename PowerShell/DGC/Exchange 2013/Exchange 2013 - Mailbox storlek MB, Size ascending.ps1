Get-Mailbox -Server ex-mb1 | Get-MailboxStatistics | Sort "TotalItemSize" | select displayname,{$_.TotalItemSize.Value.ToMB()} -first 10
