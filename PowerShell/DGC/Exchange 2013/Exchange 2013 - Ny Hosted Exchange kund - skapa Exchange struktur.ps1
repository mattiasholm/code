$Kundnamn = "Isoterm"
$Domain = "isoterm.se"


New-AcceptedDomain -Name $Domain -DomainName $Domain -DomainType Authoritative

New-EmailAddressPolicy "$Kundnamn.RP" -RecipientFilter {((CustomAttribute1 -eq "$Domain") -and (RecipientType -eq 'UserMailbox'))} -EnabledPrimarySMTPAddressTemplate "SMTP:%m@$Domain"

New-GlobalAddressList -RecipientFilter {(CustomAttribute1 -eq '$Domain' -and Alias -ne $null)} -Name $Kundnamn.GAL

New-AddressList -RecipientFilter {(CustomAttribute1 -eq '$Domain' -and Alias -ne $null)} -Name $Kundnamn.AL -DisplayName $Kundnamn.AL

New-AddressList -RecipientFilter {((CustomAttribute1 -eq '$Domain') -and (((RecipientType -eq 'UserMailbox') -and (ResourceMetaData -like 'ResourceType:*') -and (ResourceSearchProperties -ne $null))))} -Name $Kundnamn.RL -DisplayName $Kundnamn.RL

New-OfflineAddressBook -Name $Kundnamn.OAB -GlobalWebDistributionEnabled:$True -AddressLists $Kundnamn.AL

New-AddressBookPolicy -RoomList $Kundnamn.RL -Name $Kundnamn.ABP -GlobalAddressList $Kundnamn.GAL -AddressLists $Kundnamn.AL -OfflineAddressBook $Kundnamn.OAB