# Identifiera korrupt s�kindex (ContentIndexState st�r som FailedAndSuspended):

$DBs = Get-MailboxDatabase | Sort-Object -Property Name

foreach ($DB in $DBs)
{
Get-MailboxDatabaseCopyStatus $DB | Select-Object Name,ContentIndexState
}



# �tg�rda genom att k�ra f�ljande LOKALT p� den server som strular!

Stop-Service MSExchangeFastSearch
Stop-Service HostControllerService

Radera hela huvudmappen [DatabaseGuid]12.1.Single d�r indexet lagras:
D:\Exchange Server\Databases\

Start-Service MSExchangeFastSearch
Start-Service HostControllerService



# Kontrollera index-status:
# Kan dr�ja ett tag innan den �ndras fr�n Failed. St�r d� initialt som Unknown, d�refter Crawling och till slut Healthy. S�kningen kan b�rja fungera intermittent under Crawling, men det �r f�rst n�r den st�r som Healthy som allt fungerar 100% igen.

$DBs = Get-MailboxDatabase | Sort-Object -Property Name

foreach ($DB in $DBs)
{
Get-MailboxDatabaseCopyStatus $DB | Select-Object Name,ContentIndexState
}



# H�ll koll p� crawlningen:

Kontrollera att en ny index-mapp skapats i databasens path. Index-mappen heter n�got i stil med "BC90665C-1144-45E4-AFB7-C5C1BC5F919612.1.Single"

D:\Exchange Server\Databases

Kolla Properties och verifiera att mappens storlek successivt �kar. Det betyder att den crawlar och bygger upp ett nytt content index.
Totala storleken p� ett content index beror f�rst�s p� databasens storlek och antal objekt, men runt 10 GB �r normalt p� v�ra 400 GB-databaser (ca 2,5% av DB)

G�r �ven att kontrollera crawl-status med:
Get-MailboxDatabasecopystatus -ContentIndexMailboxesToCrawl -ContentIndexSeedingPercent