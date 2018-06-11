Connect-EXOPSSession
Connect-MsolService


$DynGroup = Get-DynamicDistributionGroup 'Alla anställda B3IT Dalarna AB'

$Mailboxes = Get-Recipient -RecipientPreviewFilter ($DynGroup.RecipientFilter)

foreach ($Mailbox in $Mailboxes)
{
    if ($Mailbox.RecipientType -eq 'UserMailbox')
    {
        $Mailbox = Get-Mailbox $Mailbox.Identity
        $UserPrincipalName = $Mailbox.UserPrincipalName
        $NewUserPrincipalName = $UserPrincipalName.Replace("@b3it.se","@b3.se")

        if ($NewUserPrincipalName -ne $Mailbox.UserPrincipalName)
        {
            Set-MsolUserPrincipalName -UserPrincipalName $Mailbox.UserPrincipalName -NewUserPrincipalName $NewUserPrincipalName
            Write-Host "$($Mailbox.DisplayName) - updated to: $NewUserPrincipalName"
        }
        else
        {
            Write-Host -ForegroundColor Yellow "Skipping $($Mailbox.DisplayName)"
        }
        
    }
}