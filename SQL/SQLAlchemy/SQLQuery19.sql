SELECT
    sr.Name AS Country,
    COUNT(sd.SalesOrderID) AS TotalOrders,
    SUM(sd.OrderQty) AS TotalSoldProducts
FROM
    Sales.SalesOrderDetail sd
JOIN
    Sales.SalesOrderHeader soh ON sd.SalesOrderID = soh.SalesOrderID
JOIN
    Person.Address a ON soh.ShipToAddressID = a.AddressID
JOIN
    Person.StateProvince sp ON a.StateProvinceID = sp.StateProvinceID
JOIN
    Person.CountryRegion sr ON sp.CountryRegionCode = sr.CountryRegionCode
GROUP BY
    sr.Name
	--Country
ORDER BY
    TotalSoldProducts DESC;
---------
USE AdventureWorks2022
Go
-----
SELECT
    E.Name AS Country,
    --COUNT(A.SalesOrderID) AS [All Orders in Total],
    SUM(A.OrderQty) AS [Sold Products in Total]
FROM
    Sales.SalesOrderDetail A
JOIN Sales.SalesOrderHeader B ON A.SalesOrderID = B.SalesOrderID
JOIN Person.Address C ON B.ShipToAddressID = C.AddressID
JOIN Person.StateProvince D ON C.StateProvinceID = D.StateProvinceID
JOIN Person.CountryRegion E ON D.CountryRegionCode = E.CountryRegionCode
GROUP BY E.Name
ORDER BY [Sold Products in Total] DESC;

SELECT TOP 10
	A.Name AS [Name of Product],
    ROUND(CAST(SUM(B.LineTotal - (B.OrderQty * A.StandardCost)) AS numeric(18, 2)), 2) AS TotalProfit
    --SUM(B.OrderQty) AS TotalQuantitySold
FROM Sales.SalesOrderDetail B
JOIN Production.Product A ON B.ProductID = A.ProductID
GROUP BY A.ProductID, A.Name
ORDER BY TotalProfit DESC;
-------
WITH productSalesCTE 
AS (
	SELECT
		E.Name AS Country,
		--A.ProductID,
		P.Name,
		A.OrderQty AS [Sold Quantity],
		A.UnitPrice,
		--A.UnitPriceDiscount,
		A.LineTotal AS [Price of Sales]
	FROM
		Sales.SalesOrderDetail A
	JOIN Sales.SalesOrderHeader B ON A.SalesOrderID = B.SalesOrderID
	JOIN Person.Address C ON B.ShipToAddressID = C.AddressID
	JOIN Person.StateProvince D ON C.StateProvinceID = D.StateProvinceID
	JOIN Person.CountryRegion E ON D.CountryRegionCode = E.CountryRegionCode
	JOIN Production.Product P ON A.ProductID = P.ProductID
	WHERE
		P.Name LIKE 'Mountain-200 Black%'
		AND (E.Name = 'France' OR E.Name = 'United Kingdom')

)
SELECT
	Name,
    AVG(UnitPrice) AS AveragePrice,
    SUM([Sold Quantity] ) AS TotalQuantity
FROM productSalesCTE
WHERE Country = 'France'
GROUP BY Name;
---

WITH productSalesCTE 
AS (
    SELECT
    E.Name AS Country,
    P.Name,
    A.OrderQty AS [Sold Quantity],
    A.UnitPrice,
    A.LineTotal AS [Price of Sales]
FROM
    Sales.SalesOrderDetail A
JOIN Sales.SalesOrderHeader B ON A.SalesOrderID = B.SalesOrderID
JOIN Person.Address C ON B.ShipToAddressID = C.AddressID
JOIN Person.StateProvince D ON C.StateProvinceID = D.StateProvinceID
JOIN Person.CountryRegion E ON D.CountryRegionCode = E.CountryRegionCode
JOIN Production.Product P ON A.ProductID = P.ProductID
WHERE
    P.Name LIKE 'Mountain-200 Black, 42%'
    AND (E.Name = 'France' OR E.Name = 'United Kingdom')
)
SELECT 
    SUM([Sold Quantity])
FROM productSalesCTE
WHERE Country = 'United Kingdom'; 
--
SELECT 
    [Sold Quantity] AS Quantity,
    UnitPrice
FROM productSalesCTE
WHERE Country = 'France'; 
--
SELECT
    AVG([Price of Sales]) AS AveragePrice
FROM productSalesCTE
WHERE Country = 'France'; 
