Connect-EXOPSSession

$ErrorActionPreference = "Stop"

Class Mailbox
{
    [String]$DisplayName
    [String]$UPN
}


$Mailboxes = Get-Mailbox
$ListOfMailboxes = @()


foreach ($Mailbox in $Mailboxes)
{
    $UPN = $Mailbox.EmailAddresses
    $MailboxRow = New-Object Mailbox
    $MailboxRow.DisplayName = $Mailbox.DisplayName
    $MailboxRow.UPN = $Mailbox.UserPrincipalName
    $ListOfMailboxes += $MailboxRow
}


$ListOfMailboxes | Export-Csv -Path "C:\Temp\Baseline samtliga adresser_UPN.csv" -Encoding Unicode -Delimiter "," -NoTypeInformation