-- Use square brackets around any object name or alias that includes
--  spaces or other special characters that can confuse SQL Server.

SELECT FirstName AS [Person First Name]
	, LastName AS [Person Last Name]
FROM Person.Person;