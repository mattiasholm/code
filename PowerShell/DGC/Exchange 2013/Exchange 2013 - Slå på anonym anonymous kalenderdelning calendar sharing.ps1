$Mailbox = "andreas.olmarker@maklarhuset.se"
$CalendarName = "Kalender"
$FullDetails = $true



$CalendarPath = "$($Mailbox):\$CalendarName"
$DetailLevel = "AvailabilityOnly"

if ($FullDetails -eq $true)
{
$DetailLevel = "FullDetails"
}





# SL� P�:

Set-Mailbox $Mailbox -SharingPolicy "Share calendar Full details"
Set-MailboxCalendarFolder $CalendarPath -PublishEnabled:$true -PublishDateRangeFrom OneYear -PublishDateRangeTo OneYear -DetailLevel $DetailLevel

Get-MailboxCalendarFolder $CalendarPath | select -ExpandProperty PublishedCalendarUrl > "C:\Temp\$($Mailbox) - URL f�r anonym kalenderdelning.txt"
Get-MailboxCalendarFolder $CalendarPath | select -ExpandProperty PublishedICalUrl >> "C:\Temp\$($Mailbox) - URL f�r anonym kalenderdelning.txt"




<#

# SL� AV:

Set-Mailbox $Mailbox -SharingPolicy "Default Sharing Policy"
Set-MailboxCalendarFolder $CalendarPath -PublishEnabled:$False

#>