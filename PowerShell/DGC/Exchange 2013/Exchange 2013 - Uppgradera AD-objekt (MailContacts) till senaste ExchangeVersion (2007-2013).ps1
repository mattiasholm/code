### UPPDATERA OBJEKT TILL SENASTE EXCHANGEVERSION:

$Contacts = Get-MailContact -ResultSize Unlimited | Where-Object {$_.ExchangeVersion -notlike "*15*"}

ForEach ($Contact in $Contacts)
{
$Alias = $Contact.Alias
Set-MailContact -Identity $Contact -Alias $Alias -Confirm:$false -ForceUpgrade
}


### VERIFIERA:
Get-MailContact -ResultSize Unlimited | Where-Object {$_.ExchangeVersion -notlike "*15*"}