Connect-EXOPSSession

$ErrorActionPreference = "Stop"

Class Mailbox
{
    [String]$DisplayName
    [String]$UPN
}


$Mailboxes = Get-Mailbox
$ListOfMailboxes = @()


foreach ($Mailbox in $Mailboxes)
{
    $UserPrincipalName = $Mailbox.UserPrincipalName
    $NewUPN = $UserPrincipalName.Replace("@b3it.se","@b3.se")

$MailboxRow = New-Object Mailbox
$MailboxRow.DisplayName = $Mailbox.DisplayName
$MailboxRow.UPN = $NewUPN
$ListOfMailboxes += $MailboxRow
}


$AllUPNs = $ListOfMailboxes.UPN.Split(" ")
$Difference = $AllUPNs.Count - ($AllUPNs | Sort-Object -Unique).Count

Write-Host "`n$Difference dubbletter hittades!`n($($AllUPNs.Count) respektive $(($AllUPNs | Sort-Object -Unique).Count)"