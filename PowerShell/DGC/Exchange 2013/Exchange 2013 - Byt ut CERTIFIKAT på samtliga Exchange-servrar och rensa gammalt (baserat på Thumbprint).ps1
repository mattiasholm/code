Get-ExchangeCertificate -Server $env:computername


### EJ VERIFIERAT! KOLLA OM MAN KAN SPARA CERTIFIKATET SOM VARIABEL OCH HÄMTA UT THUMBPRINT I SAMMA VEVA, SÅ SLIPPER MAN SPECA DETTA I VARIABELN NEDAN!
Import-ExchangeCertificate -FileData ([Byte[]]$(Get-Content -Path "C:\Temp\outlook_ondonator_se.pfx" -Encoding byte -ReadCount 0)) -Password:(Get-Credential).password -FriendlyName "outlook.ondonator.se"



$NewThumbprint = "D34E6E660A4A72E2B78C93E8B57335367127FDFE"
$OldThumbprint = "DAAF96EB9E7DF4ACF60C6DCA76404D7544B3597C"



# Mailbox-servrar:
Get-ExchangeCertificate -Server $env:computername | where {$_.Thumbprint -match $NewThumbprint} | Enable-ExchangeCertificate -Server $env:computername -Services SMTP
Get-ExchangeCertificate -Server $env:computername | where {$_.Thumbprint -match $OldThumbprint} | Remove-ExchangeCertificate -Server $env:computername



# CAS-servrar:
Get-ExchangeCertificate -Server $env:computername | where {$_.Thumbprint -match $NewThumbprint} | Enable-ExchangeCertificate -Server $env:computername -Services IMAP,POP,IIS
Get-ExchangeCertificate -Server $env:computername | where {$_.Thumbprint -match $OldThumbprint} | Remove-ExchangeCertificate -Server $env:computername