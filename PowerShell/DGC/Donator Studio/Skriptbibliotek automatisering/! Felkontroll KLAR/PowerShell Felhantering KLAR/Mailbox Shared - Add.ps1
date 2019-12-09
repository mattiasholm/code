$UserPrincipalName = "gemensam@nissehult.se"
$Name = "Gemensam NisseHult"
$OU = "NisseHult"
#$Database = ""
#$Session = ""



$ReturnValue = $null
$ABP = "$OU.ABP"
$OUPath = "OU=Customers,OU=Hosting2,DC=emcat,DC=com"

$wsDS = New-WebServiceProxy 'http://donator-app1.emcat.com/DSSupportWS/DS.asmx?WSDL'
$SamAccountName = $wsDS.GetNextSamAccountName();

if (!(Get-PSSnapin | where {$_.Name -match "Exchange.Management"})) { Add-PSSnapin Microsoft.Exchange.Management.* }

$ErrorActionPreference = "Stop"
Invoke-Command -Session $Session -ScriptBlock {
Param($UserPrincipalName,$Name,$SamAccountName,$OU,$OUPath,$Database)
New-Mailbox -Shared -Name $Name -DisplayName $Name -Alias ($UserPrincipalName -replace "@.*", "") -SamAccountName $SamAccountName -UserPrincipalName $UserPrincipalName -OrganizationalUnit "OU=Functions,OU=$OU,$OUPath" -Database $Database -AddressBookPolicy "$OU.ABP"
} -ArgumentList ($UserPrincipalName,$Name,$SamAccountName,$OU,$OUPath,$Database) -ErrorVariable ReturnValue

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
$ErrorActionPreference = "SilentlyContinue"
}
until ((Get-Mailbox $UserPrincipalName) -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired during creation of Shared Mailbox $UserPrincipalName"
return
}


$ErrorActionPreference = "Stop"
Invoke-Command -Session $Session -ScriptBlock {
Param($UserPrincipalName)
Set-Mailbox $UserPrincipalName -CustomAttribute1 ($UserPrincipalName -replace ".*@", "") -EmailAddressPolicyEnabled:$True
} -ArgumentList ($UserPrincipalName) -ErrorVariable ReturnValue

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
$ErrorActionPreference = "SilentlyContinue"
}
until ((Get-Mailbox $UserPrincipalName).CustomAttribute1 -eq ($UserPrincipalName -replace ".*@", "") -and (Get-Mailbox $UserPrincipalName).EmailAddressPolicyEnabled -eq $True -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired while setting parameters on Shared Mailbox $UserPrincipalName"
return
}