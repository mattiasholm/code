# OBS: Obsolet tillvägagångssätt, använd separat modul och 'Connect-EXOPSSession' för att få MFA-stöd!

Set-ExecutionPolicy RemoteSigned -Force

$UserCredential = Get-Credential

$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection

Import-PSSession $Session