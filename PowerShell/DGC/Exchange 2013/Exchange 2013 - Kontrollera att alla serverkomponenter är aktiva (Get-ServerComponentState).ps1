### VERIFIERA ATT ALLA SERVERKOMPONENTER �R AKTIVA:

Add-PSSnapin Microsoft.Exchange*

$ExchangeServers = Get-ExchangeServer | where {$_.AdminDisplayVersion -like "*15*"}

foreach ($ExchangeServer in $ExchangeServers)
{
$ServerName = $ExchangeServer.Name
Get-ServerComponentState -Identity $ServerName | where {$_.State -ne "Active"}
}


### T�ND UPP ALLA SERVERKOMPONENTER I HELA MILJ�N!

Add-PSSnapin Microsoft.Exchange*

$ExchangeServers = Get-ExchangeServer | where {$_.AdminDisplayVersion -like "*15*"}

foreach ($ExchangeServer in $ExchangeServers)
{
$ServerName = $ExchangeServer.Name
$InactiveComponents = Get-ServerComponentState -Identity $ServerName | where {$_.State -ne "Active"}

foreach ($InactiveComponent in $InactiveComponents)
{
$ComponentName = $InactiveComponent.Component
Set-ServerComponentState -Component $ComponentName -Identity $ServerName -Requester HealthAPI -State Active
Set-ServerComponentState -Component $ComponentName -Identity $ServerName -Requester Maintenance -State Active
Set-ServerComponentState -Component $ComponentName -Identity $ServerName -Requester Sidelined -State Active
Set-ServerComponentState -Component $ComponentName -Identity $ServerName -Requester Functional -State Active
Set-ServerComponentState -Component $ComponentName -Identity $ServerName -Requester Deployment -State Active
}
}
