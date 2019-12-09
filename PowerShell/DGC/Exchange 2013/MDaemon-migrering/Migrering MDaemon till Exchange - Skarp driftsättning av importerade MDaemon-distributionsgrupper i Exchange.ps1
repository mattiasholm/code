$Groups = Get-DistributionGroup -OrganizationalUnit Maklarhuset | where {$_.EmailAddresses -like "*.tmp*"}

foreach ($Group in $Groups)
{
$NewAddresses = $Group.EmailAddresses -replace ".tmp"

### Bortkommenterad tills dags att köra skarpt (annars blir det väldigt jobbigt städjobb om man måste reversera förändringen..)
#Set-DistributionGroup $Group -EmailAddresses $NewAddresses -HiddenFromAddressListsEnabled:$False
###
}