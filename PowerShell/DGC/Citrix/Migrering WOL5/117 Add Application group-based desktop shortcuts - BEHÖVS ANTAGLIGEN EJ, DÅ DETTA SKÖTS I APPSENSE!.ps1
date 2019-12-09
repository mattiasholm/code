$OUname = "Mollerst"



if (!(Get-Module | where {$_.Name -match "ActiveDirectory"})) { Import-Module ActiveDirectory }
$ReturnValue = $null
$OUPath = "OU=Customers,OU=Hosting2,DC=emcat,DC=com"
$SubOU = "Applications"
$CustomersPath = "\\emcat.com\wo\customers"

$Users = Get-ADGroupMember "CN=$OUname.WO.AllCitrixUsers,OU=Functions,OU=$OUname,$OUPath"

foreach ($User in $Users)
{

$Groups = (Get-ADUser $User -Properties *).MemberOf

$SamAccountName = $User.SamAccountName

foreach ($Group in $Groups)
{

$ADGroup = Get-ADGroup $Group

$ApplicationName = $ADGroup.SamAccountName -replace "$OUname.WO.Application.",""

switch ($ApplicationName)
{
Outlook2013 {$ShortcutNames = @("Outlook 2013")}
AdobeReader {$ShortcutNames = @("Adobe Reader XI")}
GoogleChrome {$ShortcutNames = @("Google Chrome")}
InternetExplorer {$ShortcutNames = @("Internet Explorer")}
Office2013.STD {$ShortcutNames = @("Excel 2013", "PowerPoint 2013", "Word 2013")}
Fraktexport {$ShortcutNames = @("FraktExport")}
NetLink {$ShortcutNames = @("NetLink")}
OpenOffice {$ShortcutNames = @("OpenOffice")}
SPCSAdmin2000 {$ShortcutNames = @("Visma Administration")}
SPCSAdmin2000.Norge {$ShortcutNames = @("Visma Administration Norge")}
LimeEasy {$ShortcutNames = @("LIME Easy")}
default {$ShortcutNames = $null}
}


if ($ShortcutNames)
{
foreach ($ShortcutName in $ShortcutNames)
{
Robocopy.exe "\\emcat.com\wo\System\StandardFolders\Desktop\" "$CustomersPath\$OUname\System\$SamAccountName\Desktop\" "$ShortcutName.lnk"
}
}

}
}