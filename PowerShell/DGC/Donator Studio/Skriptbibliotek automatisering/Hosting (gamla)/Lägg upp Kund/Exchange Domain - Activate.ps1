$OUname = "Kvarters"
$Domain = "kvarterskliniken.se"
#$Session = ""



$ReturnValue = $null
if (!(Get-PSSnapin | where {$_.Name -match "Exchange.Management"})) { Add-PSSnapin Microsoft.Exchange.Management.* }

$ErrorActionPreference = "Stop"
New-AcceptedDomain -Name $Domain -DomainName $Domain -DomainType Authoritative -ErrorVariable ReturnValue 

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
$ErrorActionPreference = "SilentlyContinue"
}
until ((Get-AcceptedDomain "$Domain") -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired during creation of AcceptedDomain $Domain."
return
}

$ErrorActionPreference = "Stop"
Invoke-Command -Session $Session -ScriptBlock {
Param($OUname,$Domain)
New-EmailAddressPolicy -Name $OUname".EAP" -EnabledPrimarySMTPAddressTemplate "SMTP:%m@$Domain" -ConditionalCustomAttribute1 $Domain -IncludedRecipients "AllRecipients"
} -ArgumentList ($OUname,$Domain) -ErrorVariable ReturnValue

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
$ErrorActionPreference = "SilentlyContinue"
}
until ((Get-EmailAddressPolicy "$OUname.EAP") -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired during creation of EmailAddressPolicy $OUnamename.EAP."
return
}


$ErrorActionPreference = "Stop"
Update-EmailAddressPolicy $OUname".EAP" -ErrorVariable ReturnValue

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
$ErrorActionPreference = "SilentlyContinue"
}
until ((Get-EmailAddressPolicy "$OUname.EAP").RecipientFilterApplied -eq $True -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired while applying EmailAddressPolicy $OUnamename.EAP."
return
}

Write-Host $ReturnValue