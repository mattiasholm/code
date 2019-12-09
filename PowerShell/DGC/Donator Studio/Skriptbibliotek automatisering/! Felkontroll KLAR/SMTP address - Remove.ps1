$UserPrincipalName = "anisse.hult@nissehult.se"
$Alias = "nisse@nissehult.se"



$ReturnValue = $null
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
$ReturnValue = "$UserPrincipalName not found."
return
}


if ($ExitCode -eq 0)
{
if ((Get-Recipient $Alias -ErrorAction SilentlyContinue).PrimarySMTPAddress.Local+"@"+(Get-Recipient $Alias -ErrorAction SilentlyContinue).PrimarySMTPAddress.Domain -ne $UserPrincipalName)
{
$ExitDescription = "ERROR: SMTP address $Alias is not present on $UserPrincipalName"
$ExitCode = 2
Write-Host -Foregroundcolor Red $ExitDescription
}
}


if ($ExitCode -eq 0)
{
if ($Alias -eq (Get-Recipient $UserPrincipalName -ErrorAction SilentlyContinue).PrimarySMTPAddress.Local+"@"+(Get-Recipient $UserPrincipalName -ErrorAction SilentlyContinue).PrimarySMTPAddress.Domain)
{
$ExitDescription = "ERROR: Cannot remove primary SMTP address."
$ExitCode = 3
Write-Host -Foregroundcolor Red $ExitDescription
}
}


if ($ExitCode -eq 0)
{
switch ($Type)
{
Mailbox
{
Write-Host -ForegroundColor Gray "Removing SMTP address..."
Set-Mailbox $UserPrincipalName -EmailAddresses @{remove=$Alias}
sleep 15
if ((Get-Recipient $Alias -ErrorAction SilentlyContinue).PrimarySMTPAddress.Local+"@"+(Get-Recipient $Alias -ErrorAction SilentlyContinue).PrimarySMTPAddress.Domain -ne $UserPrincipalName)
{
Write-Host -Foregroundcolor Green "SUCCESS: SMTP address $Alias removed from $UserPrincipalName."
$ExitCode = 0
}
else
{
$ExitDescription = "ERROR: Failed to remove SMTP address $Alias from $UserPrincipalName."
$ExitCode = 4
Write-Host -Foregroundcolor Red $ExitDescription
}
}
DistributionGroup
{
Write-Host -ForegroundColor Gray "Removing SMTP address..."
Set-DistributionGroup $UserPrincipalName -EmailAddresses @{remove=$Alias}
sleep 15
if ((Get-Recipient $Alias -ErrorAction SilentlyContinue).PrimarySMTPAddress.Local+"@"+(Get-Recipient $Alias -ErrorAction SilentlyContinue).PrimarySMTPAddress.Domain -ne $UserPrincipalName)
{
Write-Host -Foregroundcolor Green "SUCCESS: SMTP address $Alias removed from $UserPrincipalName."
$ExitCode = 0
}
else
{
$ExitDescription = "ERROR: Failed to remove SMTP address $Alias from $UserPrincipalName."
$ExitCode = 4
Write-Host -Foregroundcolor Red $ExitDescription
}
}
MailContact
{
Write-Host -ForegroundColor Gray "Removing SMTP address..."
Set-MailContact $UserPrincipalName -EmailAddresses @{remove=$Alias}
sleep 15
if ((Get-Recipient $Alias -ErrorAction SilentlyContinue).PrimarySMTPAddress.Local+"@"+(Get-Recipient $Alias -ErrorAction SilentlyContinue).PrimarySMTPAddress.Domain -ne $UserPrincipalName)
{
Write-Host -Foregroundcolor Green "SUCCESS: SMTP address $Alias removed from $UserPrincipalName."
$ExitCode = 0
}
else
{
$ExitDescription = "ERROR: Failed to remove SMTP address $Alias from $UserPrincipalName."
$ExitCode = 4
Write-Host -Foregroundcolor Red $ExitDescription
}
}
}
}