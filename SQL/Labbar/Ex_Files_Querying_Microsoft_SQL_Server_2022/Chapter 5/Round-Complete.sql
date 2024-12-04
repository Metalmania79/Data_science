SELECT BusinessEntityID
	, SalesYTD
	, ROUND(SalesYTD, 2) AS Round2
	, ROUND(SalesYTD, -2) AS RoundHundreds
	, CEILING(SalesYTD) AS RoundCeiling
	, FLOOR(SalesYTD) AS RoundFloor
FROM Sales.SalesPerson;