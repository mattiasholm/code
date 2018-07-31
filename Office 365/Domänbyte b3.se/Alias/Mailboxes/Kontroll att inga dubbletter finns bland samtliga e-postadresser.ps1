Connect-EXOPSSession

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
    foreach ($EmailAddress in $EmailAddresses)
    {
        if ($EmailAddress -like "smtp:*@b3it.se")
        {
            $NewEmailAddress = $EmailAddress.Replace("@b3it.se","@b3.se").Replace("SMTP:","smtp:")
            $EmailAddresses += $NewEmailAddress
        }
    }
    $EmailAddresses = $EmailAddresses | Sort-Object -Unique
    $MailboxRow = New-Object -TypeName Mailbox
    $MailboxRow.DisplayName = $Mailbox.DisplayName
    $MailboxRow.EmailAddresses = $EmailAddresses
    $ListOfMailboxes += $MailboxRow
}


$AllEmailAddresses = $ListOfMailboxes.EmailAddresses.Split(" ")
$Difference = ($AllEmailAddresses.Count - ($AllEmailAddresses | Sort-Object -Unique).Count)

Write-Host "`n$Difference dubbletter hittades!`n($($AllEmailAddresses.Count) respektive $(($AllEmailAddresses | Sort-Object -Unique).Count))"