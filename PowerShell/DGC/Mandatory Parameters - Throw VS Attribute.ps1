### ALT 1 MED MANDATORY-ATTRIBUT: 

Function Get-DiskInformation
{
 Param(
   [Parameter(Mandatory=$true)]
   [string]$drive,
   [string]$computerName = $env:computerName
)
 Get-WmiObject -class Win32_volume -computername $computername -filter "DriveLetter = '$drive'"
}



Get-DiskInformation
Get-DiskInformation -drive C:

#####################################################





### ALT 2 MED THROW:

Function Get-DiskInformation
{
 Param(
   [string]$drive,
   [string]$computerName = $env:computerName
)
if(-not($drive)) { Throw "You must supply a value for -drive" }
 Get-WmiObject -class Win32_volume -computername $computername -filter "DriveLetter = '$drive'"
}



Get-DiskInformation
Get-DiskInformation -drive C:

#####################################################