$OUname = "Longdrink"
$Domain = "longdrink.se"
$OldOuDN = "OU=Longdrink,OU=Hosting,DC=emcat,DC=com"



if (!(Get-Module | where {$_.Name -match "ActiveDirectory"})) { Import-Module ActiveDirectory }
if (!(Get-PSSnapin | where {$_.Name -match "Exchange.Management"})) { Add-PSSnapin Microsoft.Exchange.Management.* }
$ErrorActionPreference = "Stop"
$ReturnValue = $null
$OUPath = "OU=Customers,OU=Hosting2,DC=emcat,DC=com"
$OU = Get-ADOrganizationalUnit "OU=$OUname,$OUPath"

$Contacts = Get-MailContact -OrganizationalUnit $OldOuDN

foreach ($Contact in $Contacts)
{
$ErrorActionPreference = "Stop"
Get-ADObject $Contact.DistinguishedName | Move-ADObject -TargetPath "OU=Functions,OU=$OUname,$OUPath" -ErrorVariable ReturnValue
}

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
$ErrorActionPreference = "SilentlyContinue"
}
until ((Get-MailContact -OrganizationalUnit "OU=Functions,OU=$OUname,$OUPath") -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired while moving MailContacts."
return
}

$ErrorActionPreference = "Stop"
$Contacts = Get-MailContact -OrganizationalUnit "OU=Functions,OU=$OUname,$OUPath"

foreach ($Contact in $Contacts)
{
$EmailAddress = (Get-MailContact $Contact).PrimarySmtpAddress.ToString().ToLower()
$WarningPreference = "Continue"
Set-MailContact $Contact -DisplayName $EmailAddress -Name $EmailAddress -ExternalEmailAddress $EmailAddress -PrimarySMTPAddress $EmailAddress -Alias ($EmailAddress -replace "@.*", "") -CustomAttribute1 $Domain -EmailAddressPolicyEnabled:$True -ErrorVariable ReturnValue
}