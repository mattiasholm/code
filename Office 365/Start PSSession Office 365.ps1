$Domain = "storsafe.se"



$ErrorActionPreference = "Stop"
$Credential = Get-Credential

$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell -Credential $Credential -Authentication Basic -AllowRedirection
Import-PSSession $Session

Connect-MsolService -Credential $Credential

$TenantId = (Get-MsolPartnerContract -DomainName $Domain).TenantId









# office365@DonatorAB.onmicrosoft.com
# a***6***