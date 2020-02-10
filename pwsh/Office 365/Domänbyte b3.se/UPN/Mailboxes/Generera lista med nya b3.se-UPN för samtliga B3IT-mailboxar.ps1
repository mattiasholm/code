Connect-EXOPSSession

$ErrorActionPreference = "Stop"

Class Mailbox
{
    [String]$DisplayName
    [String]$UPN
}


$Mailboxes = Get-Mailbox | Where-Object {$_.UserPrincipalName -like "*@b3it.se"}
$ListOfMailboxes = @()


foreach ($Mailbox in $Mailboxes)
{
    $UserPrincipalName = $Mailbox.UserPrincipalName
    $NewUPN = $UserPrincipalName.Replace("@b3it.se","@b3.se")

$MailboxRow = New-Object Mailbox
$MailboxRow.DisplayName = $Mailbox.DisplayName
$MailboxRow.UPN = $NewUPN
$ListOfMailboxes += $MailboxRow
}


$ListOfMailboxes | Export-Csv -Path "C:\Temp\UPN b3.se lista.csv" -Encoding Unicode -Delimiter "," -NoTypeInformation