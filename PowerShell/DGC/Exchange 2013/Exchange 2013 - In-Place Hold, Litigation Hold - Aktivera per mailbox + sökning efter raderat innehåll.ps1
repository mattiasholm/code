$Mailbox = db01@ondonator.se

# Litigation Hold (HELA mailboxen)
Set-Mailbox $Mailbox -LitigationHoldEnabled $true


# In-Place Hold (baserat på sökfilter)
New-MailboxSearch <sökfilter> -InPlaceHoldEnabled $true


# Exportera innehåll som har raderats/purgats av användaren, antingen till TargetMailbox eller till PST-fil:
Search-Mailbox $Mailbox -SearchDumpsterOnly -TargetMailbox qwe464 -TargetFolder "Search-Mailbox"


# OBS: Search-Mailbox kräver att adminkontot har Discovery-RBAC-rollen tillagd!




# Kontrollera vilka mailboxar i miljön som har Litigation aktiverat (skall isåfall debiteras för detta!):
Get-Mailbox -ResultSize unlimited | where {$_.litigationholdenabled -eq "True"}