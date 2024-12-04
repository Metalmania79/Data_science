-- Verify the current compatability level of the AdventureWorks database
USE AdventureWorks2019;  
GO  
SELECT compatibility_level  
FROM sys.databases WHERE name = 'AdventureWorks2019';  
GO  

-- Change the database compatability to 160 to match SQL Server 2022
ALTER DATABASE AdventureWorks2019  
SET COMPATIBILITY_LEVEL = 160;  
GO


-- Use GENERATE_SERIES to create a list of 10 sequential numbers
SELECT Value
FROM GENERATE_SERIES(1, 10);

-- Generate a list that starts at 0 and increments by 5 up to 50
SELECT Value
FROM GENERATE_SERIES(0, 50, 5);

-- Set variables to create a list from 0.0 to 1.0 incrementing by 0.1
DECLARE @start decimal(2, 1) = 0.0;
DECLARE @stop decimal(2, 1) = 1.0;
DECLARE @increment decimal(2, 1) = 0.1;
SELECT value
FROM GENERATE_SERIES(@start, @stop, @increment);

-- Use GENERATE_SERIES in a WHERE clause to select every third person's ID
SELECT BusinessEntityID
	, FirstName
	, LastName
FROM Person.Person
WHERE BusinessEntityID IN(SELECT value FROM GENERATE_SERIES(3, 100, 3))
ORDER BY BusinessEntityID;