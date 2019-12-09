$FolderPath = "C:\temp\aliasexport"



if (!(Get-PSSnapin | where {$_.Name -match "Exchange.Management"})) { Add-PSSnapin Microsoft.Exchange.Management.* }
$ErrorActionPreference = "Stop"

$Mailboxes = Get-Mailbox -ResultSize Unlimited

foreach ($Mailbox in $Mailboxes)
{
$OriginalSMTPAddresses = (Get-Mailbox $Mailbox).Emailaddresses | select ProxyAddressString
$FileName = "$($Mailbox.PrimarySmtpAddress).txt"
$OriginalSMTPAddresses > "$FolderPath\$FileName"
}