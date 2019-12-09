$Domain = "precendo.se"
$CsvPath = "C:\Temp\Alias PRECENDO.csv"



# office365@[kundnamn]cloud.onmicrosoft.com
# a***6***

$ErrorActionPreference = "Stop"
$Credential = Get-Credential

$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell -Credential $Credential -Authentication Basic -AllowRedirection
Import-PSSession $Session

Connect-MsolService -Credential $Credential

$TenantId = (Get-MsolPartnerContract -DomainName $Domain).TenantId


$Users = (Import-Csv $CsvPath -Delimiter ";")

foreach ($User in $Users)
{
$ErrorActionPreference = "Stop"

Get-Mailbox $User.UserPrincipalName

$MsolUser = Get-MsolUser -TenantId $TenantId -UserPrincipalName $User.UserPrincipalName | select *id*

Get-Mailbox 06b97940-0fc0-41f7-abfb-c23d26b9f66a


}