$UserPrincipalName = "bosse.bagarsson@bossebagare.se"
$Forward = "mattias.holm@live.com"



$ExitCode = 0
$ExitDescription = "No errors."

if (!(Get-PSSnapin | where {$_.Name -match "Exchange.Management"})) { Add-PSSnapin Microsoft.Exchange.Management.* }

if (!(Get-Mailbox $UserPrincipalName -ErrorAction SilentlyContinue))
{
$ExitDescription = "ERROR: Mailbox $UserPrincipalName does not exist."
$ExitCode = 1
Write-Host -Foregroundcolor Red $ExitDescription
}
else
{
if ((Get-Mailbox $UserPrincipalName).ForwardingAddress)
{
$ExitDescription = "ERROR: Forwarding is already enabled on mailbox $UserPrincipalName."
$ExitCode = 2
Write-Host -Foregroundcolor Red $ExitDescription
}
}

if ($ExitCode -eq 0)
{
Write-Host -ForegroundColor Gray "Enabling forwarding on mailbox..."
Set-Mailbox $UserPrincipalName -ForwardingAddress $Forward -DeliverToMailboxAndForward:$True
#sleep 15

if ((Get-Mailbox $UserPrincipalName).ForwardingAddress -and (Get-Mailbox $UserPrincipalName).DeliverToMailboxAndForward -eq $True)
{
Write-Host -Foregroundcolor Green "SUCCESS: Forwarding enabled on mailbox $UserPrincipalName."
$ExitCode = 0
}
else
{
$ExitDescription = "ERROR: Failed to enable forwarding on mailbox $UserPrincipalName."
$ExitCode = 3
Write-Host -Foregroundcolor Red $ExitDescription
}
}