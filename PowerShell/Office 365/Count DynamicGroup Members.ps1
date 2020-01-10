$DisplayName = 'Alla anställda B3IT'

$Group = Get-DistributionGroup -Identity $DisplayName

$Members = Get-DistributionGroupMember -Identity $Group.Identity

$Count = 0

foreach ($Member in $Members)
{
	switch ($Member.RecipientType)
		{
		UserMailbox {$Count++}
		MailUniversalDistributionGroup {$Count = $Count + (Get-DistributionGroupMember -Identity $Member.Identity).Count}
		DynamicDistributionGroup {$DynGroup = Get-DynamicDistributionGroup -Identity $Member.Identity;$Count = $Count + (Get-Recipient -RecipientPreviewFilter $DynGroup.RecipientFilter).Count}
		default {Write-Host -ForegroundColor Red "Okänd RecipientType: $Member.RecipientType"}
		}
}

Write-Host "Totalt antal medlemmar: $Count"