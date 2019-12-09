Add-PSSnapin *Exchange*
$ActiveSyncUsers = Get-CASMailbox -Filter {HasActiveSyncDevicePartnership -eq $True}
$ActiveSyncUsers | Select-Object DisplayName,@{Name="Device";Expression={(Get-MobileDevice -Mailbox $_.Identity).DeviceType}},@{Name="MailboxSize";Expression={(Get-MailboxStatistics -Identity $_.Identity).TotalItemSize}}





# ENKLARE IDIOT-EXEMPEL FÖR ATT LÄTTARE SE SYNTAX:

Get-Process | Select-Object Name,@{Name="File";Expression={Get-ChildItem | Select-Object -Last 1}}