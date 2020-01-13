-- Lista samtliga ärenden
SELECT IssueID,Subject,Body,IssueDate FROM hdIssues;


-- Lista ärenden från en viss dag
SELECT IssueID,Subject,Body,IssueDate FROM hdIssues WHERE CONVERT(VARCHAR(10),IssueDate,121) = '2017-11-21';


-- Lista ärenden nyare än en viss dag
SELECT IssueID,Subject,Body,IssueDate FROM hdIssues WHERE IssueDate > '2017-10-01';


-- Lista öppna ärenden
SELECT IssueID,Subject,Body,IssueDate FROM hdIssues WHERE ResolvedDate IS NULL;


-- Lista 10 ärenden med högst prioritet:
SELECT TOP 10 IssueID,Subject,Body,IssueDate,Priority
FROM hdIssues
ORDER BY Priority DESC;


-- Lista totalt antal ärenden
SELECT COUNT(*) AS 'Antal ärenden' FROM hdIssues;


-- Lista längd på rubriker
SELECT Subject,LEN(Subject) AS 'Antal tecken' FROM hdIssues;


-- Lista medellängd på rubriker
SELECT AVG(LEN(Body)) 'Medellängd ärendetext' FROM hdIssues;


-- Lista alla ärende med Inskickat från och Tilldelat, samt korrekt Prioritet och Kategori
SELECT hdIssues.IssueID AS 'Ärendenummer', hdIssues.Subject AS 'Rubrik' ,hdIssues.Body AS 'Ärendetext',hdIssues.IssueDate AS 'Tid',t1.Email AS 'Inskickat från',t2.Email AS 'Tilldelat',t3.Name AS 'Kategori',
CASE
    WHEN hdIssues.Priority = 2 THEN 'Kritisk'
    WHEN hdIssues.Priority = 1 THEN 'Hög'
    WHEN hdIssues.Priority = 0 THEN 'Normal'
    WHEN hdIssues.Priority = -1 THEN 'Låg'
    ELSE 'Okänd prioritet'
    END AS Prioritet
FROM hdIssues
LEFT JOIN hdUsers t1 ON hdIssues.UserID=t1.UserID
LEFT JOIN hdUsers t2 ON hdIssues.AssignedToUserID=t2.UserID
LEFT JOIN hdCategories t3 ON hdIssues.CategoryID=t3.CategoryID
ORDER BY Priority DESC;


-- Lista ärenden assignade till Mattias, sorterat på prioritet:
SELECT hdIssues.IssueID AS 'Ärendenummer', hdIssues.Subject AS 'Rubrik' ,hdIssues.Body AS 'Ärendetext',hdIssues.IssueDate AS 'Tid',t1.Email AS 'Inskickat från',t2.Email AS 'Tilldelat',
CASE
    WHEN hdIssues.Priority = 2 THEN 'Kritisk'
    WHEN hdIssues.Priority = 1 THEN 'Hög'
    WHEN hdIssues.Priority = 0 THEN 'Normal'
    WHEN hdIssues.Priority = -1 THEN 'Låg'
    ELSE 'Okänd prioritet'
    END AS Prioritet
FROM hdIssues
LEFT JOIN hdUsers t1 ON hdIssues.UserID=t1.UserID
LEFT JOIN hdUsers t2 ON hdIssues.AssignedToUserID=t2.UserID
WHERE hdIssues.AssignedToUserID = (SELECT UserID FROM hdUsers WHERE Email = 'mattias.holm@b3it.se')
ORDER BY Priority DESC;


-- Lista ärenden inskickade av Tomas, sorterat på prioritet:
SELECT hdIssues.IssueID AS 'Ärendenummer', hdIssues.Subject AS 'Rubrik' ,hdIssues.Body AS 'Ärendetext',hdIssues.IssueDate AS 'Tid',t1.Email AS 'Inskickat från',t2.Email AS 'Tilldelat',
CASE
    WHEN hdIssues.Priority = 2 THEN 'Kritisk'
    WHEN hdIssues.Priority = 1 THEN 'Hög'
    WHEN hdIssues.Priority = 0 THEN 'Normal'
    WHEN hdIssues.Priority = -1 THEN 'Låg'
    ELSE 'Okänd prioritet'
    END AS Prioritet
FROM hdIssues
LEFT JOIN hdUsers t1 ON hdIssues.UserID=t1.UserID
LEFT JOIN hdUsers t2 ON hdIssues.AssignedToUserID=t2.UserID
WHERE hdIssues.UserID = (SELECT UserID FROM hdUsers WHERE Email = 'tomas.stene@b3it.se')
ORDER BY Priority DESC;


-- Lista alla ärenden grupperat efter prioritet
SELECT CASE
    WHEN Priority = 2 THEN 'Kritisk'
    WHEN Priority = 1 THEN 'Hög'
    WHEN Priority = 0 THEN 'Normal'
    WHEN Priority = -1 THEN 'Låg'
    END AS Prioritet
,COUNT(*) AS 'Antal ärenden'
FROM hdIssues GROUP BY Priority
ORDER BY COUNT(*);


-- Lista specifik tekniker
SELECT * FROM hdUsers WHERE Email = 'mattias.holm@b3it.se';


-- Lista alla användare och deras respektive företag/roll
SELECT hdUsers.FirstName,hdUsers.LastName,hdUsers.UserName,hdCompanies.Name AS 'Company',b3Roles.Role
FROM hdUsers
LEFT JOIN hdCompanies ON hdUsers.CompanyID = hdCompanies.CompanyID
LEFT JOIN b3Contact_Company ON hdUsers.UserID = b3Contact_Company.UserID
LEFT JOIN b3Roles ON b3Roles.RoleID = b3Contact_Company.RoleID
WHERE hdUsers.FirstName <> '';


-- Lista antal ärenden per dag
SELECT CONVERT(VARCHAR(10),IssueDate,121) AS 'Datum',COUNT(*) AS 'Antal ärenden'
FROM hdIssues
GROUP BY CONVERT(VARCHAR(10),IssueDate,121)
ORDER BY CONVERT(VARCHAR(10),IssueDate,121) DESC;


-- Lista alla ärenden, samt en kolumn med totalt antal ärenden från den dagen:
SELECT dbo.hdIssues.IssueID AS 'Ärendenummer', dbo.hdIssues.Subject AS 'Rubrik',
dbo.hdUsers.Email AS 'Tilldelad', dbo.hdIssues.IssueDate AS 'Startdatum',
COUNT(*) OVER (PARTITION BY CONVERT(date, IssueDate)) AS AntalPerDatum
FROM dbo.hdIssues
LEFT JOIN dbo.hdUsers ON dbo.hdIssues.AssignedToUserID = dbo.hdUsers.UserID
ORDER BY IssueDate DESC;


-- Exempel på SQL Sub query:
SELECT
    order_id,
    order_date,
    customer_id
FROM
    sales.orders
WHERE
    customer_id IN (
        SELECT
            customer_id
        FROM
            sales.customers
        WHERE
            city = 'New York'
    )
ORDER BY
    order_date DESC;