Add-PSSnapin Microsoft.Exchange.*
$ErrorActionPreference = "Stop"



$LegacyOABs = Get-OfflineAddressBook | Where-Object {$_.ExchangeVersion -like "*0.1*"}

foreach ($LegacyOAB in $LegacyOABs)
{
Set-OfflineAddressBook $LegacyOAB -Name "$($LegacyOAB.Name).TOBEREMOVED"
$NewOAB = New-OfflineAddressBook -Name $LegacyOAB.Name -GlobalWebDistributionEnabled:$true -AddressLists $LegacyOAB.AddressLists.Name

if (Get-AddressBookPolicy $($LegacyOAB.Name -replace ".OAB",".ABP") -ErrorAction SilentlyContinue)
{
Set-AddressBookPolicy $($LegacyOAB.Name -replace ".OAB",".ABP") -OfflineAddressBook $NewOAB.Name
}

Remove-OfflineAddressBook "$($LegacyOAB.Name).TOBEREMOVED" -Confirm:$false
Write-Host -ForegroundColor Green "Done with $($LegacyOAB.Name -replace ".OAB")"
}