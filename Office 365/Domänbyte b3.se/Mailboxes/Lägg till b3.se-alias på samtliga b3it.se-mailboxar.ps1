$Mailboxes = Get-Mailbox | Where-Object {$_.EmailAddresses -like "*@b3it.se*"}

foreach ($Mailbox in $Mailboxes)
{
    $EmailAddresses = $Mailbox.EmailAddresses
    foreach ($EmailAddress in $EmailAddresses)
    {
        if ($EmailAddress -like "smtp:*@b3it.se")
        {
            $NewEmailAddress = $EmailAddress.Replace("@b3it.se","@b3.se").Replace("SMTP:","smtp:")
            if ($EmailAddresses -notcontains $NewEmailAddress)
            {
                $EmailAddresses += $NewEmailAddress
            }
        }
    }
    $EmailAddresses = $EmailAddresses | Sort-Object -Unique
    
    Set-Mailbox -Identity $Mailbox.Identity -EmailAddresses $EmailAddresses 
    Write-Host "$($Mailbox.DisplayName) - updated!"
}