$FilePath = $FilePath = "\\evs01\EnterpriseVault\ScriptImport\"
$FilePath = "\\don-arkiv1\EnterpriseVault\Evakuering\ScriptImport\"

$RetentionPolicy = "Default MRM Policy"
#$RetentionPolicy = "Archive all messages older than 3 months"



$ErrorActionPreference = "Stop"
$ReturnValue = $null

if (!(Get-PSSnapin | where {$_.Name -match "Exchange.Management"})) { Add-PSSnapin Microsoft.Exchange.Management.* }

$Pattern = "*.cfg"
$Files = Get-ChildItem $($FilePath)$($Pattern)

foreach ($File in $Files)
{
$LegacyExchangeDN = (Get-Content "$($FilePath)$($File)" | findstr "MAILBOXDN") -replace "MAILBOXDN = "

$Mailbox = Get-Mailbox $LegacyExchangeDN -ErrorVariable $ReturnValue
if ($Mailbox.ArchiveDatabase -eq $null)
{

if ($Mailbox.ManagedFolderMailboxPolicy -ne $null)
{
Set-Mailbox $Mailbox -ManagedFolderMailboxPolicy $null -Confirm:$False
}


### OBS: VERIFIERA ATT POLICYN INTE ÄR SATT NÄR ARKIVET LÄGGS PÅ - ISÅFALL FINNS POTENTIELL RISK FÖR DATAFÖRLUST NÄR ARKIVET TAS BORT!!!
Set-Mailbox $Mailbox -RetentionPolicy $RetentionPolicy
###

Start-ManagedFolderAssistant $Mailbox.DistinguishedName


$objUser = New-Object DirectoryServices.DirectoryEntry "LDAP://$($Mailbox.DistinguishedName)"

if ($objUser.msExchELCMailboxFlags)
{
$objUser.msExchELCMailboxFlags.Remove("$($objUser.msExchELCMailboxFlags)")
$objUser.SetInfo()
}

if ($objUser.msExchMailboxTemplateLink)
{
$objUser.msExchMailboxTemplateLink.Remove("$($objUser.msExchMailboxTemplateLink)")
$objUser.SetInfo()
}


Start-ManagedFolderAssistant $Mailbox.DistinguishedName

Set-Mailbox -Identity $Mailbox –RemoveManagedFolderAndPolicy

<#
if (Get-MoveRequest $Mailbox -ErrorAction SilentlyContinue)
{
Get-MoveRequest $Mailbox | Remove-MoveRequest -Confirm:$False
}

New-MoveRequest $Mailbox -ArchiveOnly -ArchiveTargetDatabase Archive01 -BadItemLimit 10000

$ErrorActionPreference = "Continue"

do
{
sleep 1
}
until ((Get-MoveRequest $Mailbox).Status -eq "Completed")
#>

$ErrorActionPreference = "Stop"
Start-ManagedFolderAssistant $Mailbox.DistinguishedName

Set-Mailbox $Mailbox -RetentionPolicy $RetentionPolicy

Enable-Mailbox $Mailbox -Archive -ArchiveDatabase Archive01 -ErrorVariable $ReturnValue

Set-Mailbox $Mailbox -RetentionPolicy $RetentionPolicy

#Start-ManagedFolderAssistant $Mailbox.DistinguishedName
}

else
{
"Mailbox $($Mailbox.UserPrincipalName) already has an In-Place Archive enabled on database $($Mailbox.ArchiveDatabase)."
}
}