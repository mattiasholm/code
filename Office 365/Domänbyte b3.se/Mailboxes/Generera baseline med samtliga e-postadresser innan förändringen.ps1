$ErrorActionPreference = "Stop"

Class Mailbox
{
    [String]$DisplayName
    [String]$EmailAddresses
}


$Mailboxes = Get-Mailbox
$ListOfMailboxes = @()


foreach ($Mailbox in $Mailboxes)
{
    $EmailAddresses = $Mailbox.EmailAddresses
    $MailboxRow = New-Object Mailbox
    $MailboxRow.DisplayName = $Mailbox.DisplayName
    $MailboxRow.EmailAddresses = $EmailAddresses
    $ListOfMailboxes += $MailboxRow
}


$ListOfMailboxes | Export-Csv -Path "C:\Temp\Baseline samtliga adresser.csv" -Encoding Unicode -Delimiter "," -NoTypeInformation