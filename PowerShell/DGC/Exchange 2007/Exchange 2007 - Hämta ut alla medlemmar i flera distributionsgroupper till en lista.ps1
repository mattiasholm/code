# Alla mailboxar som ligger under Itrim HQ:
Get-Mailbox -OrganizationalUnit "OU=HQ,OU=Itrim,OU=Hosting,DC=emcat,DC=com" | select PrimarySmtpAddress, LegacyExchangeDN | Out-String -Width 200 | Out-File C:\Temp\Get-Mailbox.txt

# Alla distributionsgrupper som ligger under Itrim HQ:
Get-DistributionGroup -OrganizationalUnit "OU=HQ,OU=Itrim,OU=Hosting,DC=emcat,DC=com" | select PrimarySmtpAddress, LegacyExchangeDN | Out-String -Width 200 | Out-File C:\Temp\Get-DistributionGroup.txt


# Alla medlemmar i respektive distributionsgrupp:
Remove-Item C:\Temp\Get-DistributionGroupMember.txt

$groups = Get-DistributionGroup -OrganizationalUnit "OU=HQ,OU=Itrim,OU=Hosting,DC=emcat,DC=com"

foreach ($group in $groups)
{
$groupname = $group.Name
$grouplegacydn = $group.LegacyExchangeDN
Get-DistributionGroupMember $group | select @{Name='Distribution Group'; Expression={[String]::join(";", $groupname)}},PrimarySmtpAddress >> C:\Temp\Get-DistributionGroupMember.txt
}