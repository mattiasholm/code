$RetentionPolicy = "Archive all messages older than 3 months"
$Mailboxes = ("mattias@longdrink.se")



$ErrorActionPreference = "Stop"

if (!(Get-PSSnapin | where {$_.Name -match "Exchange.Management"})) { Add-PSSnapin Microsoft.Exchange.Management.* }

foreach ($Mailbox in $Mailboxes)
{
Set-Mailbox $Mailbox -RetentionPolicy $RetentionPolicy

<#
$ServerName = (Get-Mailbox $Mailbox).ServerName

$Username = "emcat\exmerge"
$Password = "AA11AAss" | ConvertTo-SecureString -asPlainText -Force
$UserCredential = New-Object System.Management.Automation.PSCredential($Username,$Password)
$MailboxServer = Get-MailboxServer $ServerName

$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri "http://$($MailboxServer.Name)/PowerShell/" -Authentication Kerberos -Credential $UserCredential -ErrorVariable ReturnValue
#Import-PSSession $Session -AllowClobber

Invoke-Command -Session $Session -ScriptBlock {
Param($Mailbox)
Start-ManagedFolderAssistant $Mailbox
} -ArgumentList ($Mailbox) -ErrorVariable ReturnValue
#>
}