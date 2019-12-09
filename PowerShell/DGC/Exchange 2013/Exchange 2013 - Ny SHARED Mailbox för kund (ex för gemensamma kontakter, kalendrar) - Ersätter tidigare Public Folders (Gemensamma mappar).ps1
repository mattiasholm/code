#Skapa Shared Mailbox:

$Kundnamn = "Vulkanresor"
$DisplayName = "Vulkanresor Info SE"
$Alias = "vulkanresor.info.se"
$Domain = "vulkanresor.se"
$Emailaddress = "info.tmp@vulkanresor.se"
$OU = "OU=Vulkanresor,OU=Hosting,DC=emcat,DC=com"
$DB = "DB10v"
$ABP = "Vulkanresor.ABP"

New-Mailbox -Shared -Name $DisplayName -DisplayName $DisplayName -Alias $Alias -SamAccountName gemensam.$Kundnamn -PrimarySmtpAddress $Emailaddress -UserPrincipalName $Emailaddress -OrganizationalUnit $OU -Database $DB -AddressBookPolicy $ABP
Set-Mailbox $Emailaddress -CustomAttribute1 $Domain



# Lägg till fullständiga behörigheter:

$Users = Get-Mailbox -OrganizationalUnit $OU

Foreach ($User in $Users)
{
Add-MailboxPermission $Emailaddress -User $User -AccessRights FullAccess
}



# Lägg till Send As behörigheter:

$Users = Get-Mailbox -OrganizationalUnit $OU
$Mailbox = Get-Mailbox $EmailAddress
$DistinguishedName = Get-ADUser $Mailbox.SamAccountname | select DistinguishedName


Foreach ($User in $Users)
{
Add-ADPermission -Identity $DistinguishedName.DistinguishedName -User $User -AccessRight ExtendedRight -ExtendedRights "Send As"
Add-ADPermission -Identity $DistinguishedName.DistinguishedName -User $User -AccessRight ExtendedRight -ExtendedRights "Receive As"
}