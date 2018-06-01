$ErrorActionPreference = "Stop"

Class Group
{
    [String]$DisplayName
    [String]$EmailAddresses
}


$Groups = Get-DynamicDistributionGroup
$ListOfGroups = @()


foreach ($Group in $Groups)
{
    $EmailAddresses = $Group.EmailAddresses
    foreach ($EmailAddress in $EmailAddresses)
    {
        if ($EmailAddress -like "smtp:*@b3it.se")
        {
            $NewEmailAddress = $EmailAddress.Replace("@b3it.se","@b3.se").Replace("SMTP:","smtp:")
            $EmailAddresses += $NewEmailAddress
        }
    }
    $EmailAddresses = $EmailAddresses | Sort-Object -Unique
    $MailboxRow = New-Object -TypeName Group
    $MailboxRow.DisplayName = $Group.DisplayName
    $MailboxRow.EmailAddresses = $EmailAddresses
    $ListOfGroups += $MailboxRow
}


$AllEmailAddresses = $ListOfGroups.EmailAddresses.Split(" ")
$Difference = ($AllEmailAddresses.Count - ($AllEmailAddresses | Sort-Object -Unique).Count)

Write-Host "`n$Difference dubbletter hittades!`n($($AllEmailAddresses.Count) respektive $(($AllEmailAddresses | Sort-Object -Unique).Count))"