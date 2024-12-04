SELECT BusinessEntityID
	, SalesYTD
	, IIF(SalesYTD > 2000000, 'Met Sales Goal', 'Has not met goal') AS Status
FROM Sales.SalesPerson;

SELECT IIF(SalesYTD > 2000000, 'Met Sales Goal', 'Has not met goal') AS Status
	, COUNT(*) AS CountOfSalesPeople
FROM Sales.SalesPerson
GROUP BY IIF(SalesYTD > 2000000, 'Met Sales Goal', 'Has not met goal')