# Identifiera korrupt sökindex (ContentIndexState står som FailedAndSuspended):

$DBs = Get-MailboxDatabase | Sort-Object -Property Name

foreach ($DB in $DBs)
{
Get-MailboxDatabaseCopyStatus $DB | Select-Object Name,ContentIndexState
}



# Åtgärda genom att köra följande LOKALT på den server som strular!

Stop-Service MSExchangeFastSearch
Stop-Service HostControllerService

Radera hela huvudmappen [DatabaseGuid]12.1.Single där indexet lagras:
D:\Exchange Server\Databases\

Start-Service MSExchangeFastSearch
Start-Service HostControllerService



# Kontrollera index-status:
# Kan dröja ett tag innan den ändras från Failed. Står då initialt som Unknown, därefter Crawling och till slut Healthy. Sökningen kan börja fungera intermittent under Crawling, men det är först när den står som Healthy som allt fungerar 100% igen.

$DBs = Get-MailboxDatabase | Sort-Object -Property Name

foreach ($DB in $DBs)
{
Get-MailboxDatabaseCopyStatus $DB | Select-Object Name,ContentIndexState
}



# Håll koll på crawlningen:

Kontrollera att en ny index-mapp skapats i databasens path. Index-mappen heter något i stil med "BC90665C-1144-45E4-AFB7-C5C1BC5F919612.1.Single"

D:\Exchange Server\Databases

Kolla Properties och verifiera att mappens storlek successivt ökar. Det betyder att den crawlar och bygger upp ett nytt content index.
Totala storleken på ett content index beror förstås på databasens storlek och antal objekt, men runt 10 GB är normalt på våra 400 GB-databaser (ca 2,5% av DB)

Går även att kontrollera crawl-status med:
Get-MailboxDatabasecopystatus -ContentIndexMailboxesToCrawl -ContentIndexSeedingPercent