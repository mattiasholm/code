$OU = "Itrim"
$EWSAccount = "QSI.Admin"



$Mailboxes = Get-Mailbox -OrganizationalUnit $OU -ResultSize Unlimited

# LÄGG TILL IMPERSONATION-RIGHTS PÅ SAMTLIGA KONTON:

foreach ($Mailbox in $Mailboxes)
{
Add-ADPermission -Identity $Mailbox.Identity -User $EWSAccount -ExtendedRight ms-Exch-EPI-May-Impersonate
}



# TILLÅT IMPERSONATION-CALLS PÅ CAS-SERVRAR:

Get-ExchangeServer | where {$_.IsClientAccessServer -eq $true} | foreach {Add-ADPermission -Identity $_.DistinguishedName -User $EWSAccount -ExtendedRight ms-Exch-EPI-Impersonation}