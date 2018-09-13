Connect-EXOPSSession

$ErrorActionPreference = "Stop"

Class Mailbox
{
    [String]$DisplayName
    [Int]$NumberOfAddresses
    [String]$EmailAddresses    
}


$Mailboxes = Get-Mailbox
$ListOfMailboxes = @()


foreach ($Mailbox in $Mailboxes)
{
    $EmailAddresses = $Mailbox.EmailAddresses -match "smtp:"
    $DisallowedEmailAddresses = @()

    foreach ($EmailAddress in $EmailAddresses)
    {        
        $LocalPart = $EmailAddress -replace "@.*$" -replace "^.*:"
        if ($LocalPart -notmatch "\.")
        {
            $DisallowedEmailAddresses += $EmailAddress -replace "^.*:"
        }
    }

    if ($DisallowedEmailAddresses)
    {
        $MailboxRow = New-Object Mailbox
        $MailboxRow.DisplayName = $Mailbox.DisplayName
        $MailboxRow.NumberOfAddresses = $DisallowedEmailAddresses.Count
        $MailboxRow.EmailAddresses = $DisallowedEmailAddresses
        $ListOfMailboxes += $MailboxRow
    }
}

$ListOfMailboxes | Export-Csv -Path "C:\Temp\Disallowed proxyAddresses.csv" -Encoding Unicode -Delimiter "," -NoTypeInformation