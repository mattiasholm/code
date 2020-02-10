Connect-EXOPSSession

$Domain = "visab.se"

$Mailboxes = Get-Mailbox | Where-Object {$_.EmailAddresses -like "*@$Domain*"}

foreach ($Mailbox in $Mailboxes)
{
    $EmailAddresses = $Mailbox.EmailAddresses
    foreach ($EmailAddress in $EmailAddresses)
    {
        if ($EmailAddress -clike "SMTP:*@$Domain")
        {
            $NewEmailAddress = $EmailAddress.Replace("@$Domain","@b3.se").Replace("SMTP:","smtp:")
            if ($EmailAddresses -notcontains $NewEmailAddress)
            {
                $EmailAddresses += $NewEmailAddress
            }
        }
    }
    $EmailAddresses = $EmailAddresses | Sort-Object -Unique
    
    Set-Mailbox -Identity $Mailbox.Identity -EmailAddresses $EmailAddresses 
    Write-Host "$($Mailbox.DisplayName) - updated!"
    Get-Recipient $NewEmailAddress
}