SELECT Person.BusinessEntityID
	, Person.FirstName
	, Person.LastName
	, Employee.JobTitle
FROM Person.Person
	INNER JOIN HumanResources.Employee
		ON Person.BusinessEntityID = Employee.BusinessEntityID;

-- Retrieve the same records with a correlated subquery
SELECT BusinessEntityID
	, FirstName
	, LastName
	, (SELECT JobTitle
		FROM HumanResources.Employee
		WHERE BusinessEntityID = MyPerson.BusinessEntityID) AS JobTitle
FROM Person.Person AS MyPerson
WHERE EXISTS (SELECT JobTitle
				FROM HumanResources.Employee
				WHERE BusinessEntityID = MyPerson.BusinessEntityID);