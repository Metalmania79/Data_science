SELECT BusinessEntityID
	, SalesYTD
	, (SELECT MAX(SalesYTD)
		FROM Sales.SalesPerson) AS HigestSalesYTD
	, (SELECT MAX(SalesYTD)
		FROM Sales.SalesPerson) - SalesYTD AS SalesGap
FROM Sales.SalesPerson
ORDER BY SalesYTD DESC;

-- Two options for finding the current highest Sales Year To Date number
SELECT TOP 1 SalesYTD
FROM Sales.SalesPerson
ORDER BY SalesYTD DESC;

SELECT MAX(SalesYTD)
FROM Sales.SalesPerson;