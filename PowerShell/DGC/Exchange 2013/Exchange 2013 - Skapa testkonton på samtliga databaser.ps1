$Names = ("DB01","DB02","DB03","DB04","DB05","DB06","DB07v","DB08v","DB09v","DB10v")

Foreach ($Name in $Names)
{
$Password = "aa55TT"
$OU = "OU=Donator,OU=Hosting,DC=emcat,DC=com"
$SamAccountName = $Name
$UserPrincipalName = "$Name@ondonator.se"
$Alias = "$Name"
$ABP = "Donator.ABP"
$CustomAttribute1 = "donator.se"
$Kundnamn = "Donator"
$Everyone = "Donator.Everyone"
$ExchangeAllow = "Donator.Exchange.Allow"

New-Mailbox -Password (ConvertTo-SecureString -AsPlainText $Password -Force) -Database $Name -OrganizationalUnit $OU -SamAccountName $SamAccountName -UserPrincipalName $UserPrincipalName -Alias $Alias -Name $Name -DisplayName $Name -Confirm:$false;sleep 5;Set-Mailbox $UserPrincipalName -AddressBookPolicy $ABP -EmailAddressPolicyEnabled:$True -CustomAttribute1 $CustomAttribute1;Set-ADUSer $SamAccountName -PasswordNeverExpires:$True -Enabled:$True;Add-ADGroupMember $Everyone $SamAccountName;Add-ADGroupMember $ExchangeAllow $SamAccountName
}