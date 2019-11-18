-- Install SQL Server 2017 Express edition
-- Install Azure Data Studio
-- Connect to localhost\SQLEXPRESS



-- List all databases on server (including System Databases)
SELECT *
FROM sys.databases;


-- Create a new database
CREATE DATABASE DemoDB;


-- List all databases on server (excluding System Databases)
SELECT *
FROM sys.databases
WHERE database_id > 4;


-- Select database
USE DemoDB;


-- Create a new table
CREATE TABLE People (
PersonID int,
FirstName varchar(255),
LastName varchar(255),
Age int,
);


-- List all tables
SELECT *
FROM information_schema.tables;


-- Insert a row into the table
INSERT INTO People (FirstName, LastName)
VALUES ('Mattias', 'Holm');


-- List all rows in table
SELECT *
FROM People;


-- Update existing row
UPDATE People
SET PersonID = 1
WHERE FirstName = 'Mattias' AND LastName = 'Holm';


-- List specific row in table
SELECT *
FROM People
WHERE PersonID = 1;


-- Insert another row into the table
INSERT INTO People (PersonID, FirstName, LastName)
VALUES (1,'Mattias', 'Holm');


-- List all rows in table
SELECT *
FROM People;


-- Remove table
DROP TABLE People;


-- Create a more advanced table
CREATE TABLE People (
PersonID int IDENTITY(1,1) PRIMARY KEY,
FirstName varchar(255) NOT NULL,
LastName varchar(255) NOT NULL,
Age int
);


-- Insert a row into the table
INSERT INTO People (FirstName, LastName)
VALUES ('Mattias', 'Holm');


-- List all rows in table
SELECT *
FROM People;


-- Insert another row into the table
INSERT INTO People (FirstName, LastName)
VALUES ('Mattias', 'Holm');


-- Delete specific rows
DELETE FROM People
WHERE NOT PersonID = 1


-- Update existing row
UPDATE People
SET Age = 28
WHERE PersonID = 1;


-- List specific row
SELECT *
FROM People
WHERE PersonID = 1;


-- Insert another person into the table
INSERT INTO People (FirstName, LastName, Age)
VALUES ('Test', 'Testson', 35);


-- List all rows in table
SELECT *
FROM People;


-- Remove table
DROP TABLE People;


-- Remove database
USE master;
DROP DATABASE DemoDB;


-- List all databases on server (excluding System Databases)
SELECT *
FROM sys.databases
WHERE database_id > 4;





-- More examples - Relations table, JOIN example, VARIABLES, CASE, IF