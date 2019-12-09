# NY KUND EXCHANGE 2013:

# OBS: S�k och ers�tt i Notepad:
# S�k efter: $Kundnamn
# Ers�tt med: [Kundens namn]
$Domain = "isoterm.se"


New-AcceptedDomain -Name $Domain -DomainName $Domain -DomainType Authoritative

New-EmailAddressPolicy "$Kundnamn.RP" -RecipientFilter {(CustomAttribute1 -eq '$Domain' -and Alias -ne $null)} -EnabledPrimarySMTPAddressTemplate "SMTP:%m@$Domain"

New-GlobalAddressList -RecipientFilter {(CustomAttribute1 -eq '$Domain' -and Alias -ne $null)} -Name $Kundnamn.GAL

New-OfflineAddressBook -Name $Kundnamn.OAB -GlobalWebDistributionEnabled:$True -AddressLists $Kundnamn.AL

New-AddressList -RecipientFilter {(CustomAttribute1 -eq '$Domain' -and Alias -ne $null)} -Name $Kundnamn.AL -DisplayName $Kundnamn.AL

New-AddressList -RecipientFilter {((CustomAttribute1 -eq '$Domain') -and (((RecipientType -eq 'UserMailbox') -and (ResourceMetaData -like 'ResourceType:*') -and (ResourceSearchProperties -ne $null))))} -Name $Kundnamn.RL -DisplayName $Kundnamn.RL

New-AddressBookPolicy -RoomList $Kundnamn.RL -Name $Kundnamn.ABP -GlobalAddressList $Kundnamn.GAL -AddressLists $Kundnamn.AL -OfflineAddressBook $Kundnamn.OAB






# K�rs f�r varje konto som skall konfigureras:

$Emailaddress = "test.testsson@vulkanresor.se"
$Alias = "test.testsson"
$DisplayName = "Test Testsson"
$Database = "DB10v"
$Domain = "vulkanresor.se"
$ABP= "Vulkanresor.ABP"

Enable-Mailbox -Identity $Emailaddress -DisplayName $DisplayName -Database $Database -PrimarySmtpAddress $Emailaddress -Alias $Alias -AddressBookPolicy $ABP
Set-Mailbox $Emailaddress -CustomAttribute1 "$Domain"