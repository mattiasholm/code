$UserPrincipalName = "allusers.laif@leroy.se"
$OU = "Leroy"
#$Session = ""



$ReturnValue = $null
$OUPath = "OU=Customers,OU=Hosting2,DC=emcat,DC=com"

$wsDS = New-WebServiceProxy 'http://donator-app1.emcat.com/DSSupportWS/DS.asmx?WSDL'
$SamAccountName = $wsDS.GetNextSamAccountName();


if (!(Get-PSSnapin | where {$_.Name -match "Exchange.Management"})) { Add-PSSnapin Microsoft.Exchange.Management.* }

$ErrorActionPreference = "Stop"
Invoke-Command -Session $Session -ScriptBlock {
Param($UserPrincipalName,$OU,$OUPath,$SamAccountName)
New-DistributionGroup -DisplayName $UserPrincipalName -Name $UserPrincipalName -Alias ($UserPrincipalName -replace "@.*", "") -Type Distribution -OrganizationalUnit "OU=Distribution Groups,OU=$OU,$OUPath" -SamAccountName $SamAccountName
} -ArgumentList ($UserPrincipalName,$OU,$OUPath,$SamAccountName) -ErrorVariable ReturnValue

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
$ErrorActionPreference = "SilentlyContinue"
}
until ((Get-DistributionGroup $UserPrincipalName -ErrorAction SilentlyContinue) -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired during creation of DistributionGroup $UserPrincipalName"
return
}


$ErrorActionPreference = "Stop"
Set-DistributionGroup $UserPrincipalName -RequireSenderAuthenticationEnabled:$False -CustomAttribute1 ($UserPrincipalName -replace ".*@", "") -EmailAddressPolicyEnabled:$True -ErrorVariable ReturnValue

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
$ErrorActionPreference = "SilentlyContinue"
}
until ((Get-DistributionGroup $UserPrincipalName).CustomAttribute1 -eq ($UserPrincipalName -replace ".*@", "") -and (Get-DistributionGroup $UserPrincipalName).EmailAddressPolicyEnabled -eq $True -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired while setting parameters on DistributionGroup $UserPrincipalName"
return
}