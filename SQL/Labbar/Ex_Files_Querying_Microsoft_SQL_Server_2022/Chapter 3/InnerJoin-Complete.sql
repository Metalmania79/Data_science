SELECT BusinessEntityID, FirstName, LastName
FROM Person.Person;

SELECT BusinessEntityID, PhoneNumber
FROM Person.PersonPhone
WHERE BusinessEntityID = 293;

SELECT A.BusinessEntityID
	, A.FirstName
	, A.LastName
	, B.PhoneNumber
FROM Person.Person AS A INNER JOIN Person.PersonPhone AS B
	ON A.BusinessEntityID = B.BusinessEntityID;