$Mailbox = db01@ondonator.se

# Litigation Hold (HELA mailboxen)
Set-Mailbox $Mailbox -LitigationHoldEnabled $true


# In-Place Hold (baserat p� s�kfilter)
New-MailboxSearch <s�kfilter> -InPlaceHoldEnabled $true


# Exportera inneh�ll som har raderats/purgats av anv�ndaren, antingen till TargetMailbox eller till PST-fil:
Search-Mailbox $Mailbox -SearchDumpsterOnly -TargetMailbox qwe464 -TargetFolder "Search-Mailbox"


# OBS: Search-Mailbox kr�ver att adminkontot har Discovery-RBAC-rollen tillagd!




# Kontrollera vilka mailboxar i milj�n som har Litigation aktiverat (skall is�fall debiteras f�r detta!):
Get-Mailbox -ResultSize unlimited | where {$_.litigationholdenabled -eq "True"}