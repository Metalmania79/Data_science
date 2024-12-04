SELECT BusinessEntityID
	, HireDate
	, YEAR(HireDate) AS HireYear
	, MONTH(HireDate) AS HireMonth
	, DAY(HireDate) AS HireDay
	, DATEDIFF(day, HireDate, GETDATE()) AS DaysSinceHire
	, DATEDIFF(year, HireDate, GETDATE()) AS YearsSinceHire
	, DATEADD(year, 10, HireDate) AS Anniversary
FROM HumanResources.Employee;

SELECT YEAR(HireDate)
	, COUNT(*) AS NewHires
FROM HumanResources.Employee
GROUP BY YEAR(HireDate);

SELECT GETDATE();
SELECT GETUTCDATE();