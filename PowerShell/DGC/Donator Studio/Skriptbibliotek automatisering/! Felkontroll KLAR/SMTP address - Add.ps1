$UserPrincipalName = "nisse.hult@nissehult.se"
$Alias = "bagarn@nissehult.se"



$ExitCode = 0
$ExitDescription = "No errors."
$Type = $null

if (!(Get-PSSnapin | where {$_.Name -match "Exchange.Management"})) { Add-PSSnapin Microsoft.Exchange.Management.* }

if ((Get-Mailbox $UserPrincipalName -ErrorAction SilentlyContinue))
{
$Type = "Mailbox"
}
elseif ((Get-DistributionGroup $UserPrincipalName -ErrorAction SilentlyContinue))
{
$Type = "DistributionGroup"
}
elseif ((Get-MailContact $UserPrincipalName -ErrorAction SilentlyContinue))
{
$Type = "MailContact"
}
else
{
$ExitDescription = "ERROR: $UserPrincipalName does not exist."
$ExitCode = 1
Write-Host -Foregroundcolor Red $ExitDescription
}


if ($ExitCode -eq 0)
{
if ((Get-Recipient $Alias -ErrorAction SilentlyContinue))
{
##### OBS FIXA NEDANSTÅENDE MED METOD .ToString() Istället!!!
#####
if ((Get-Recipient $Alias).PrimarySMTPAddress.Local+"@"+(Get-Recipient $Alias).PrimarySMTPAddress.Domain -eq $UserPrincipalName)
{
$ExitDescription = "INFO: SMTP address $Alias is already present on $UserPrincipalName."
$ExitCode = 2
Write-Host -Foregroundcolor Yellow $ExitDescription
}
else
{
$ExitDescription = "ERROR: SMTP address $Alias is already in use by "+(Get-Recipient $Alias).PrimarySMTPAddress.Local+"@"+(Get-Recipient $Alias).PrimarySMTPAddress.Domain
$ExitCode = 3
Write-Host -Foregroundcolor Red $ExitDescription
}
}
}


if ($ExitCode -eq 0)
{
switch ($Type)
{
Mailbox
{
Write-Host -ForegroundColor Gray "Adding SMTP address..."
Set-Mailbox $UserPrincipalName -EmailAddresses @{add=$Alias}
sleep 15
if ((Get-Recipient $Alias -ErrorAction SilentlyContinue).PrimarySMTPAddress.Local+"@"+(Get-Recipient $Alias -ErrorAction SilentlyContinue).PrimarySMTPAddress.Domain -eq $UserPrincipalName)
{
Write-Host -Foregroundcolor Green "SUCCESS: SMTP address $Alias added to $UserPrincipalName."
$ExitCode = 0
}
else
{
$ExitDescription = "ERROR: Failed to add SMTP address $Alias to $UserPrincipalName."
$ExitCode = 4
Write-Host -Foregroundcolor Red $ExitDescription
}
}
DistributionGroup
{
Write-Host -ForegroundColor Gray "Adding SMTP address..."
Set-DistributionGroup $UserPrincipalName -EmailAddresses @{add=$Alias}
sleep 15
if ((Get-Recipient $Alias -ErrorAction SilentlyContinue).PrimarySMTPAddress.Local+"@"+(Get-Recipient $Alias -ErrorAction SilentlyContinue).PrimarySMTPAddress.Domain -eq $UserPrincipalName)
{
Write-Host -Foregroundcolor Green "SUCCESS: SMTP address $Alias added to $UserPrincipalName."
$ExitCode = 0
}
else
{
$ExitDescription = "ERROR: Failed to add SMTP address $Alias to $UserPrincipalName."
$ExitCode = 4
Write-Host -Foregroundcolor Red $ExitDescription
}
}
MailContact
{
Write-Host -ForegroundColor Gray "Adding SMTP address..."
Set-MailContact $UserPrincipalName -EmailAddresses @{add=$Alias}
sleep 15
if ((Get-Recipient $Alias -ErrorAction SilentlyContinue).PrimarySMTPAddress.Local+"@"+(Get-Recipient $Alias -ErrorAction SilentlyContinue).PrimarySMTPAddress.Domain -eq $UserPrincipalName)
{
Write-Host -Foregroundcolor Green "SUCCESS: SMTP address $Alias added to $UserPrincipalName."
$ExitCode = 0
}
else
{
$ExitDescription = "ERROR: Failed to add SMTP address $Alias to $UserPrincipalName."
$ExitCode = 4
Write-Host -Foregroundcolor Red $ExitDescription
}
}
}
}