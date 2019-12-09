$Name = "Archive all messages older than 3 months"



$ErrorActionPreference = "Stop"

if (!(Get-PSSnapin | where {$_.Name -match "Exchange.Management"})) { Add-PSSnapin Microsoft.Exchange.Management.* }

New-RetentionPolicyTag -Name $Name -Type All -RetentionAction MoveToArchive -AgeLimitForRetention 90

New-RetentionPolicy -Name $Name -RetentionPolicyTagLinks $Name