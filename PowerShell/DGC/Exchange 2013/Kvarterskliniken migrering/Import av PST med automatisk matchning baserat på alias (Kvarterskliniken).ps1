$FilePath = "C:\Temp\vht.local_unicode.csv"
$Delimiter = ","
$PstFolderPath = "F:\kk_pst"
$OuName = "Kvarters"



$ErrorActionPreference = "Continue"
if (!(Get-PSSnapin | where {$_.Name -match "Exchange.Management"})) { Add-PSSnapin Microsoft.Exchange.Management.* }
$CsvUsers = Import-CSV $FilePath -Delimiter "$Delimiter"
$SearchBase = Get-ADOrganizationalUnit -Filter {Name -eq $OuName}

if (!(Test-Path "$PstFolderPath\ImportStarted"))
{
$ImportStartedPath = New-Item -ItemType Directory "$PstFolderPath\ImportStarted"
}


$ADUsers = Get-ADUser -SearchBase $SearchBase -Filter *

foreach ($ADUser in $ADUsers)
{

if ($CsvUsers | where {$_.PrimarySmtpAddress -eq $ADUser.UserPrincipalName})
{
$CsvUser = $CsvUsers | where {$_.PrimarySmtpAddress -eq $ADUser.UserPrincipalName}

$Alias = $CsvUser.Alias

if (Get-ChildItem $PstFolderPath | where {$_.Name -like "*$Alias*"})
{
$PstFile = Get-ChildItem $PstFolderPath | where {$_.Name -like "*$Alias*"}

$NewPstFilePath = Move-Item $PstFile.FullName -Destination $ImportStartedPath -PassThru

$NewPstUNCPath = "\\$env:computername\$($NewPstFilePath -replace ":","$")"

New-MailboxImportRequest $ADUser.UserPrincipalName -FilePath $NewPstUNCPath -BadItemLimit 10000 -LargeItemLimit 10000 -AcceptLargeDataLoss
}
else
{
Write-host "DOES NOT HAVE A CORRESPONDING PST FILE: $($ADUser.UserPrincipalName)"
}
}
else
{
Write-host "DOES NOT EXIST IN CSV FILE: $($ADUser.UserPrincipalName)"
}
}