SELECT BusinessEntityID, PersonType, FirstName, LastName
FROM Person.Person;


SELECT BusinessEntityID, JobTitle
FROM HumanResources.Employee;


SELECT Person.BusinessEntityID
	, Person.PersonType
	, Person.FirstName
	, Person.LastName
	, Employee.JobTitle
FROM Person.Person JOIN HumanResources.Employee
	ON Person.BusinessEntityID = Employee.BusinessEntityID;