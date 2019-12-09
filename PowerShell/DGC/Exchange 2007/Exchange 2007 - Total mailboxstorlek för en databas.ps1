Get-MailboxDatabase "MSX-CCR-MB1\First Storage Group\First Mailbox Database" | Get-Mailbox -ResultSize Unlimited | Get-MailboxStatistics | Select-Object TotalItemSize

Get-MailboxDatabase "MSX-CCR-MB1\First Storage Group\First Mailbox Database" | Get-Mailbox -ResultSize Unlimited | Get-MailboxStatistics | Select-Object TotalDeletedItemSize