$Mailboxes = "adam.goodman@twochefs.com","bao@twochefs.com","karon@twochefs.com","kata@twochefs.com","katacenter@twochefs.com","office@twochefs.com","phnompenh@cambodia.twochefs.com","sales@twochefs.com","sales1@twochefs.com","sales2@twochefs.com"

foreach ($Mailbox in $Mailboxes)
{
Set-Mailbox $Mailbox -Languages "en-US"
Set-MailboxRegionalConfiguration $Mailbox -Language "en-US" -LocalizeDefaultFolderName
}