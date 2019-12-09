### VARIABLES
# Get today's date
$today = "{0:yyyy-MM-dd}" -f (Get-Date)

# Get date 1 month back
$past = "{0:yyyy-MM-dd}" -f (Get-Date).AddMonths(-1)

# Get current month
$currentmonth =  "{0:yyyy-MM}" -f (Get-Date)

# Get month two months back
$removemonth = "{0:yyyy-MM}" -f (Get-Date).AddMonths(-2)

$startPath = "E:\PST\$currentmonth\"

# Add PS Snapin for Exchange
Add-PSSnapin Microsoft.Exchange.Management.PowerShell.Admin

# Get permission to access all mailboxes
Get-Mailbox | Add-MailboxPermission -User "emcat\ExMerge" -AccessRights "FullAccess"


# Create folder if it does not already exist
if ((Test-Path -Path $startPath) -ne $True)
{
New-Item $startPath -ItemType Directory
}

#Export mailbox to PST
$MailBoxes = Get-Mailbox -ResultSize Unlimited
foreach($MailBox in $MailBoxes)
{
	$OU = $Mailbox | Select OrganizationalUnit
	$OU = $OU -Replace("@{OrganizationalUnit=emcat.com/Hosting/", "") -Replace("}","")
	$OU = $OU -Replace("/", "\") 

	$currPath = $startPath + $OU

	# Create folder if it does not already exist
	if ((Test-Path -Path $currPath) -ne $True)
	{
		New-Item $currPath -ItemType Directory
	}

	if ((Test-Path -Path $currPath\Contacts_Calendars) -ne $True)
	{
		New-Item $currPath\Contacts_Calendars -ItemType Directory
	}
	
	$Mailbox | Export-Mailbox -ExcludeFolders "\Contacts","\Kontakter","\Calendar","\Kalender" -StartDate "$past" -EndDate "$today" -PSTFolderPath $currPath -Confirm:$False
	$Mailbox | Export-Mailbox -IncludeFolders "\Contacts","\Kontakter","\Calendar","\Kalender" -PSTFolderPath $currPath\Contacts_Calendars -Confirm:$False
}

# Remove PST files from 2 months back (if it exists)
if ((Test-Path -Path "E:\PST\$removemonth") -eq $True)
{
Remove-Item "E:\PST\$removemonth" -Recurse
}