SELECT * FROM Sales.SalesOrderHeader

SELECT SOH.CustomerID
	, P.FirstName
	, P.LastName
	, SUM(SOH.TotalDue) AS TotalPurchaseAmount
	, AVG(SOH.TotalDue) AS AveragePurchaseAmount
	, MIN(SOH.TotalDue) AS LowestPurchaseAmount
	, MAX(SOH.TotalDue) AS HighestPurchaseAmount
	, MIN(SOH.OrderDate) AS FirstOrder
	, SUM(SOH.Freight) AS TotalFreightCharges
FROM Sales.SalesOrderHeader AS SOH
	INNER JOIN Person.Person AS P
		ON SOH.CustomerID = P.BusinessEntityID
GROUP BY SOH.CustomerID, P.FirstName, P.LastName
ORDER BY SUM(SOH.TotalDue) DESC;