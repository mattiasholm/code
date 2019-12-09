# Saxat från: http://blogs.technet.com/b/mikehall/archive/2012/09/13/distributing-offline-address-books-to-multiple-generation-servers.aspx
# Modifierat för att hämta alla OABs och skicka dem till Exchange 2013-MBservrar.

Write-Host "Getting all Exchange 2007 address books."
[array]$OABs=Get-OfflineAddressBook
 foreach ($OAB in $OABs)
 {
 $OABName = $OAB.Name
 $OABGenServer = Get-MailboxServer | ?{$_.AdminDisplayVersion.Major -ge 15} | Get-Random -Count 1
 Write-Host "Moving Offline Address Book $OABName to $OABGenServer"
 Move-OfflineAddressBook "$OABName" -Server $OABGenServer -Confirm:$false
 }















EGET SKRIPT (EJ SLUTFÖRT):

# Get number of OABs for previosly used mailbox servers:
$LeastUsedMailboxServer = Get-OfflineAddressBook | Group-Object Server | Sort-Object Count | Select -First 1

$OABGenSrv = $LeastUsedMailboxServer.Name



# Get a list of new mailbox servers that has not yet been used to generate OABs:

$a = Get-OfflineAddressBook | Group-Object Server | Select Name
$b = Get-MailboxServer | Select Name

$UnusedMailboxServer = Compare-Object $a1 $a2 -PassThru | Select -First 1

If $UnusedMailboxServer = 


# Compare whether a used server 



$LeastUsedMailboxServer.Count





$differences = 0
$a = Get-OfflineAddressBook | Group-Object Server | Select Name
$b = Get-MailboxServer | Select Name
diff $a $b  | % {$differences+=1}
write-host $differences








$differences = 0
$a = @(1,4,5,3)
$b = @(1,3,4)
diff $a $b  | % {$differences+=1}
write-host $differences








$OABGenSrv = $UnusedMailboxServer.Name