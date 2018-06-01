$ErrorActionPreference = "Stop"

Class Group
{
    [String]$DisplayName
    [String]$PrimarySmtpAddress
    [String]$Aliases
}


$Groups = Get-DistributionGroup | Where-Object {$_.EmailAddresses -like "*@b3it.se"}
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
    $EmailAddressesSerialized = $EmailAddresses -clike "smtp:*" -notlike "*@b3it.onmicrosoft.com" -creplace "smtp:","" -join ", "
    $MailboxRow = New-Object Group
    $MailboxRow.DisplayName = $Group.DisplayName
    $MailboxRow.PrimarySmtpAddress = $Group.PrimarySmtpAddress
    $MailboxRow.Aliases = $EmailAddressesSerialized
    $ListOfGroups += $MailboxRow
}


$ListOfGroups | Export-Csv -Path "C:\Temp\Alias b3.se lista_GROUPS.csv" -Encoding Unicode -Delimiter "," -NoTypeInformation