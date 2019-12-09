$UserPrincipalName = "bosse.bagarsson@bossebagare.se"



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
if (!(Get-Mailbox $UserPrincipalName).ForwardingAddress)
{
$ExitDescription = "ERROR: Forwarding is not enabled on mailbox $UserPrincipalName."
$ExitCode = 2
Write-Host -Foregroundcolor Red $ExitDescription
}
}

if ($ExitCode -eq 0)
{
Write-Host -ForegroundColor Gray "Disabling forwarding on mailbox..."
Set-Mailbox $UserPrincipalName -ForwardingAddress $Null -DeliverToMailboxAndForward:$False
#sleep 15

if (!(Get-Mailbox $UserPrincipalName).ForwardingAddress -and (Get-Mailbox $UserPrincipalName).DeliverToMailboxAndForward -eq $False)
{
Write-Host -Foregroundcolor Green "SUCCESS: Forwarding disabled on mailbox $UserPrincipalName."
$ExitCode = 0
}
else
{
$ExitDescription = "ERROR: Failed to disable forwarding on mailbox $UserPrincipalName."
$ExitCode = 3
Write-Host -Foregroundcolor Red $ExitDescription
}
}