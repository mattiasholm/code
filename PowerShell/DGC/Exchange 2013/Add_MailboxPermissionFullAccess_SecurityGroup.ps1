$EmailAddress = Read-Host "Ange mailbox som skall kommas åt"
$Deligate = Read-Host "Ange grupp som skall ha access till mailboxen"



if ((Get-PSSnapin | where {$_.Name -match "Exchange.Management"}) -eq $null) { Add-PSSnapin Microsoft.Exchange.Management.* }

Add-MailboxPermission $Emailaddress -User $Deligate -AccessRights FullAccess

PAUSE