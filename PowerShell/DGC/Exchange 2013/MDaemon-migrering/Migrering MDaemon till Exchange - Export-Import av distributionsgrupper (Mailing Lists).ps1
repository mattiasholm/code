$UserPrincipalNames = (Get-ChildItem C:\temp\MH_MailingLists).Name -replace ".grp"
$OU = "MH.StagingOU"



$ReturnValue = $null
$OUPath = "OU=Maklarhuset,OU=Hosting,DC=emcat,DC=com"
if (!(Get-PSSnapin | where {$_.Name -match "Exchange.Management"})) { Add-PSSnapin Microsoft.Exchange.Management.* }

foreach ($UserPrincipalName in $UserPrincipalNames)
{
$ErrorActionPreference = "Stop"
New-DistributionGroup -DisplayName $UserPrincipalName -Name $UserPrincipalName -Alias ($UserPrincipalName -replace "@.*", "") -Type Distribution -OrganizationalUnit "OU=$OU,$OUPath" -ErrorVariable ReturnValue

$Timeout = 60
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
Set-DistributionGroup $UserPrincipalName -RequireSenderAuthenticationEnabled:$False -CustomAttribute1 ($UserPrincipalName -replace ".*@", "") -EmailAddressPolicyEnabled:$False -PrimarySmtpAddress "$UserPrincipalName.tmp" -ErrorVariable ReturnValue
}