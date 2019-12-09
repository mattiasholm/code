$ErrorActionPreference = "Stop"

$ImportUsers = Import-Csv C:\temp\LeroyImportUsers.txt



foreach ($ImportUser in $ImportUsers)
{
$UserPrincipalName = $ImportUser.UserPrincipalName
$AdUser = Get-ADUser -Filter {UserPrincipalName -eq $UserPrincipalName} -Properties *

if (!(Get-PSSnapin | where {$_.Name -match "Exchange.Management"})) { Add-PSSnapin Microsoft.Exchange.Management.* }
$OldUPN = $UserPrincipalName -replace ".test@","@"
$OldAccount = Get-ADUser -Filter {UserPrincipalName -eq $OldUPN} -Properties *
if ($OldAccount -eq $null)
{
$Recipient = Get-Recipient $OldUPN
if (!($Recipient -eq $null))
{
$Sam = $Recipient.SamAccountName
$OldUPN = (Get-ADUser $Sam).UserPrincipalName
$OldAccount = Get-ADUser -Filter {UserPrincipalName -eq $OldUPN} -Properties *
}
else
{
Write-Host "$UserPrincipalName finns ej sedan tidigare! Lägg upp manuellt!" -ForegroundColor Red
return
}
}

$OldAccount.legacyExchangeDN
$ProxyAddresses = $OldAccount.proxyAddresses

foreach ($ProxyAddress in $ProxyAddresses)
{
if (!($ProxyAddress -like "*hostingcustomer*" -or $ProxyAddress -like "*msxcustomer*" -or $ProxyAddress -like "X400:*"))
{
Set-ADUser $AdUser -Add @{proxyAddresses=$ProxyAddress}
}
$X500 = "X500:$($OldAccount.legacyExchangeDN)"
Set-ADUser $AdUser -Add @{proxyAddresses=$X500}
}
}





### Kontroll:
<#


# Kolla samtliga proxyadresser för användarna från CSV-filen:
foreach ($ImportUser in $ImportUsers)
{
$UserPrincipalName = $ImportUser.UserPrincipalName
Write-Host -ForegroundColor Green $UserPrincipalName
(Get-ADUser -Filter {UserPrincipalName -eq $UserPrincipalName} -Properties *).ProxyAddresses
}


# Kolla alla i ett kundens OU som saknar proxyaddresses:
$OUname = "Leroy"
Get-ADUser -SearchBase "OU=$OUname,OU=Customers,OU=Hosting2,DC=emcat,DC=com" -Filter * -Properties * | select proxyaddresses,displayname | findstr "{}"


#>