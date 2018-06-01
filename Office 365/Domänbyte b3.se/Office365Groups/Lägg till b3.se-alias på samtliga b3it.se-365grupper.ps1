$Groups = Get-UnifiedGroup | Where-Object {$_.EmailAddresses -like "*@b3it.se*"}

foreach ($Group in $Groups)
{
    $EmailAddresses = $Group.EmailAddresses
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
    
    Set-UnifiedGroup -Identity $Group.PrimarySmtpAddress -EmailAddresses $EmailAddresses 
    Write-Host "$($Group.DisplayName) - updated!"
}