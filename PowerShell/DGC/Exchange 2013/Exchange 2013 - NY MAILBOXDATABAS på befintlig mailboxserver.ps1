# ANGE VARIABLER:
$Server = "donaor-w-mta02"
$dbName = "DB05_temp_don-mb02"
$Datadisk = "D"

New-MailboxDatabase -Name $dbName -Server $Server -LogFolderPath "E:\Exchange Server\Logs\$dbName" -EdbFilePath "$($Datadisk):\Exchange Server\Databases\$dbName.edb" -PublicFolderDatabase $Null
Set-MailboxDatabase -Identity $dbName -ProhibitSendReceiveQuota Unlimited -IssueWarningQuota Unlimited -ProhibitSendQuota Unlimited -DeletedItemRetention 90.00:00:00 -Confirm:$False

### WARNING: Please restart the Microsoft Exchange Information Store service on server DON-EX-MB03 after adding new mailbox databases. - Verkar dock ej beh�vas!



### OBS ENDAST VID MASS�VERFLYTT AV DATA TILL MASKIN F�R ATT UNDVIKA ATT TRANSAKTIONSLOGGSPARTITION FYLLS UPP:

Set-MailboxDatabase $dbName -CircularLoggingEnabled:$True
Dismount-Database $dbName -Confirm:$False
Mount-Database $dbName



### Flytta �ver _Airbag p� 10GB till disken d�r den nya databasen ligger.

<#
# VIKTIGT: Rensa obsolet DefaultPublicFolderDatabase-attribut!!!
http://exchangeserverpro.com/remove-default-public-folder-database-exchange-mailbox-database/

ADSIEdit

CN=Services -> CN=Microsoft Exchange -> CN=(your organization name) -> CN=Administrative Groups -> CN=Exchange Administrative Group (FYDIBOHF23SPDLT) -> CN=Databases.

Markera den nyskapade databasen och RENSA f�ljande attribut:

msExchHomePublicMDB = CN=Public Folder Database,CN=First Storage Group,CN=InformationStore,CN=EX-MB1,CN=Servers,CN=Exchange Administrative Group (FYDIBOHF23SPDLT),CN=Administrative Groups,CN=Donator,CN=Microsoft Exchange,CN=Services,CN=Configuration,DC=emcat,DC=com

#>