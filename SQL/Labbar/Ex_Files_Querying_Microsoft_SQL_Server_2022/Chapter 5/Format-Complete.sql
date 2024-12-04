SELECT BusinessEntityID
	, HireDate
	, FORMAT(HireDate, 'ddd') AS AbbreviatedDayOfWeek
	, FORMAT(HireDate, 'dddd, MMMM dd, yyyy') AS VerboseDate
	, FORMAT(HireDate, 'd-MMM-yy') AS SimpleDate
FROM HumanResources.Employee;