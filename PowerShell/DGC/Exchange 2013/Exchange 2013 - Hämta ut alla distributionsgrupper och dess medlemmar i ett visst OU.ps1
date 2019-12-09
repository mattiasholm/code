$OuName = "emcat.com/hosting/mollerstrommedical"



Add-PSSnapin Microsoft.Exchange*
$Groups = Get-DistributionGroup -OrganizationalUnit $OuName

foreach ($Group in $Groups)
{
Write-Host -ForegroundColor Green "$($Group.SamAccountName)"
$Members = (Get-DistributionGroupMember $Group).Name

foreach ($Member in $Members)
{
Write-Host "- $($Member)"
}
Write-Host ""
}