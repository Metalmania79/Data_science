DECLARE @NumberToReturn INT = 3;
DECLARE @StartID INT = 260;

SELECT TOP (@NumberToReturn) BusinessEntityID
	, FirstName
	, LastName
FROM Person.Person
WHERE BusinessEntityID >= @StartID
ORDER BY BusinessEntityID;