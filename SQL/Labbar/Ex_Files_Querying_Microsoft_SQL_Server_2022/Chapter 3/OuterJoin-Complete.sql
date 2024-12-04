SELECT BusinessEntityID, PersonType, FirstName, LastName
FROM Person.Person;


SELECT BusinessEntityID, JobTitle
FROM HumanResources.Employee;


SELECT Person.BusinessEntityID
	, Person.PersonType
	, Person.FirstName
	, Person.LastName
	, Employee.JobTitle
FROM Person.Person LEFT OUTER JOIN HumanResources.Employee  -- can also use RIGHT OUTER or FULL OUTER
	ON Person.BusinessEntityID = Employee.BusinessEntityID;