Connect-EXOPSSession

$ErrorActionPreference = "Stop"

Class Mailbox
{
    [String]$DisplayName
    [String]$PrimarySmtpAddress
    [String]$Aliases
}


$Mailboxes = Get-Mailbox | Where-Object {$_.EmailAddresses -like "*@b3it.se*"}
$ListOfMailboxes = @()


foreach ($Mailbox in $Mailboxes)
{
    $EmailAddresses = $Mailbox.EmailAddresses
    foreach ($EmailAddress in $EmailAddresses)
    {
        if ($EmailAddress -like "smtp:*@b3it.se")
        {
            $NewEmailAddress = $EmailAddress.Replace("@b3it.se","@b3.se").Replace("SMTP:","smtp:")
            $EmailAddresses += $NewEmailAddress
        }
    }
    $EmailAddresses = $EmailAddresses | Sort-Object -Unique
    $EmailAddressesSerialized = $EmailAddresses -clike "smtp:*" -notlike "*@b3it.onmicrosoft.com" -creplace "smtp:","" -join ", "
    $MailboxRow = New-Object Mailbox
    $MailboxRow.DisplayName = $Mailbox.DisplayName
    $MailboxRow.PrimarySmtpAddress = $Mailbox.PrimarySmtpAddress
    $MailboxRow.Aliases = $EmailAddressesSerialized
    $ListOfMailboxes += $MailboxRow
}


$ListOfMailboxes | Export-Csv -Path "C:\Temp\Alias b3.se lista.csv" -Encoding Unicode -Delimiter "," -NoTypeInformation