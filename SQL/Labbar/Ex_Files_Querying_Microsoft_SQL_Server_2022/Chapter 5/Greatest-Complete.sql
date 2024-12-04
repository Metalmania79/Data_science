SELECT FirstName
	, LastName
	, GREATEST(FirstName, LastName) AS 'Highest Alphabetical'
	, LEAST(FirstName, LastName) AS 'Lowest Alphabetical'
FROM Person.Person
ORDER BY BusinessEntityID;

SELECT BusinessEntityID
	, VacationHours
	, SickLeaveHours
	, GREATEST(VacationHours, SickLeaveHours) AS 'Greatest'
	, LEAST(VacationHours, SickLeaveHours) AS 'Least'
	, IIF(GREATEST(VacationHours, SickLeaveHours) = VacationHours
		, 'Vacation', 'Sick') AS 'Which is higher?'
FROM HumanResources.Employee;