$OuName = "Kvarters"
$FolderPath = "C:\temp\aliasexport"



$ErrorActionPreference = "Stop"
if (!(Get-PSSnapin | where {$_.Name -match "Exchange.Management"})) { Add-PSSnapin Microsoft.Exchange.Management.* }
$SearchBase = Get-ADOrganizationalUnit -Filter {Name -eq $OuName}
$Mailboxes = Get-Mailbox -OrganizationalUnit $SearchBase.DistinguishedName

foreach ($Mailbox in $Mailboxes)
{

if (Test-Path "$FolderPath\$($Mailbox.UserPrincipalName)*")
{
$OriginalSMTPAddresses = @()
$OriginalSMTPAddresses += (Get-Item "$FolderPath\$($Mailbox.UserPrincipalName)*" | select -First 1 | Get-Content)

$CurrentSMTPAddresses = @()
$CurrentSMTPAddresses = (Get-Mailbox $Mailbox).Emailaddresses.ProxyAddressString

foreach ($CurrentSMTPAddress in $CurrentSMTPAddresses)
{
$OriginalSMTPAddresses = $OriginalSMTPAddresses -replace "$CurrentSMTPAddress",$null
}
$OriginalSMTPAddresses = $OriginalSMTPAddresses -notlike ""

$OriginalSMTPAddresses = $OriginalSMTPAddresses -replace "ProxyAddressString",$null
$OriginalSMTPAddresses = $OriginalSMTPAddresses -replace "------------------",$null
$OriginalSMTPAddresses = $OriginalSMTPAddresses -replace " ",""
$OriginalSMTPAddresses = $OriginalSMTPAddresses -notlike ""

if ((Get-Mailbox $Mailbox).EmailAddresses | where {$_.ProxyAddressString -like "X500:*"})
{
$OriginalSMTPAddresses = $OriginalSMTPAddresses -notlike "X500:*"
}

foreach ($OriginalSMTPAddress in $OriginalSMTPAddresses)
{
$ErrorActionPreference = "Stop"
$Mailbox.EmailAddresses += $OriginalSMTPAddress
}
Set-Mailbox $Mailbox -EmailAddresses $Mailbox.EmailAddresses -EmailAddressPolicyEnabled:$false
Set-Mailbox $Mailbox -EmailAddressPolicyEnabled:$true
}
else
{
Write-Host "COULDN'T FIND CORRESPONDING ALIAS FILE FOR: $($Mailbox.UserPrincipalName)"
}
}