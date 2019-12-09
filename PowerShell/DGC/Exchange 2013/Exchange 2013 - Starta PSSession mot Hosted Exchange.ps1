$Username = "emcat\ds.svc"
$Password = "AA11AAss" | ConvertTo-SecureString -asPlainText -Force
$PowerShellURL = "https://outlook.ondonator.se/PowerShell/"
$PowerShellURL = "http://don-ex-ca01.emcat.com/PowerShell/"



$ErrorActionPreference = "Stop"
$UserCredential = New-Object System.Management.Automation.PSCredential($Username,$Password)

$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri $PowerShellURL -Authentication Kerberos -Credential $UserCredential -ErrorVariable ReturnValue
Import-PSSession $Session #-AllowClobber

$PowerShellURL = "http://don-ex-ca01.emcat.com/PowerShell/"



# Get-PsSession | Remove-PsSession