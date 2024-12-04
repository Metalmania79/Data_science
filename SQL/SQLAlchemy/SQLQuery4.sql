/*Employees*/
SELECT [BusinessEntityID]
      ,[JobTitle]
      ,[Gender]
  FROM [AdventureWorks2022].[HumanResources].[Employee]
  GROUP BY JobTitle,[BusinessEntityID],Gender
  ORDER BY Gender;

SELECT COUNT(BusinessEntityID) AS Amount,
	Gender
FROM
    [AdventureWorks2022].[HumanResources].[Employee]
GROUP BY
    Gender;

SELECT
    COUNT(BusinessEntityID) AS Amount,
    JobTitle
FROM [AdventureWorks2022].[HumanResources].[Employee]
--WHERE Gender = 'F'
GROUP BY JobTitle;


/****** All products ******/
SELECT TOP (1000) [ProductID]
      ,[Name]
      ,[ProductNumber]
      ,[Color]
FROM [AdventureWorks2022].[Production].[Product]

SELECT COUNT(ProductID) AS [Amount of Products] FROM Production.Product;

SELECT TOP 10 
	ProductID, 
	[Name],
	NEWID() AS NewID
FROM Production.Product
ORDER BY NewID;

/* TOP 10 most sold products in Quantity*/
SELECT TOP 10
    A.Name AS Product,
    A.ProductID,
	ROUND(CAST(SUM(B.LineTotal - (B.OrderQty * A.StandardCost)) AS numeric(10, 2)), 2) AS RealProfit,
    SUM(B.OrderQty) AS TotalSoldQty
FROM Sales.SalesOrderDetail B
JOIN Production.Product A ON B.ProductID = A.ProductID
GROUP BY A.ProductID, A.Name
ORDER BY TotalSoldQty DESC;

SELECT TOP 10
    A.Name AS [Name of Product],
    SUM(B.OrderQty) AS TotalSoldQty
FROM Sales.SalesOrderDetail B
JOIN Production.Product A ON B.ProductID = A.ProductID
GROUP BY A.ProductID, A.Name
ORDER BY TotalSoldQty DESC;

/* TOP products that doesn't make a profit for Stores*/
SELECT
    A.Name AS Product,
    A.ProductID,
	A.StandardCost,
	A.ListPrice,
	ROUND(CAST(SUM(B.LineTotal - (B.OrderQty * A.StandardCost)) AS numeric(10, 2)), 2) AS RealProfit,
    SUM(B.OrderQty) AS TotalSoldQty
FROM Sales.SalesOrderDetail B
JOIN Production.Product A ON B.ProductID = A.ProductID
GROUP BY A.ProductID, A.Name,A.StandardCost,A.ListPrice
HAVING ROUND(CAST(SUM(B.LineTotal - (B.OrderQty * A.StandardCost)) AS numeric(10, 2)), 2) < 0
ORDER BY Product ASC;

SELECT
    A.Name AS Product,
    A.ProductID,
	A.StandardCost,
	A.ListPrice,
	ROUND(CAST(SUM(B.LineTotal) AS numeric(10, 2)), 2)  AS TotalSales,
	SUM(B.OrderQty) AS TotalSoldQty,
    ROUND(CAST(SUM(B.LineTotal - (B.OrderQty * A.StandardCost)) AS numeric(10, 2)), 2) AS RealProfit
FROM
    Sales.SalesOrderDetail B
JOIN
    Production.Product A ON B.ProductID = A.ProductID
GROUP BY
    A.ProductID, A.Name, A.StandardCost, A.ListPrice
HAVING
    ROUND(CAST(SUM(B.LineTotal - (B.OrderQty * A.StandardCost)) AS numeric(10, 2)), 2) < 0
ORDER BY
    Product ASC;

/*Unit price included which is vendors selling price to customers*/
WITH ProductProfitability AS (
    SELECT
        A.ProductID,
        A.Name AS Product,
        A.StandardCost,
        A.ListPrice,
        ROUND(CAST(SUM(B.LineTotal) AS numeric(10, 2)), 2) AS TotalSales,
        SUM(B.OrderQty) AS TotalSoldQty,
        ROUND(CAST(SUM(B.LineTotal - (B.OrderQty * A.StandardCost)) AS numeric(10, 2)), 2) AS RealProfit
    FROM
        Sales.SalesOrderDetail B
    JOIN
        Production.Product A ON B.ProductID = A.ProductID
    GROUP BY
        A.ProductID, A.Name, A.StandardCost, A.ListPrice
    HAVING
        ROUND(CAST(SUM(B.LineTotal - (B.OrderQty * A.StandardCost)) AS numeric(10, 2)), 2) < 0
)

SELECT
    pp.ProductID,
    pp.Product,
    pp.StandardCost,
    pp.ListPrice,
    pp.TotalSales,
    pp.TotalSoldQty,
    pp.RealProfit,
    pod.UnitPrice
FROM
    ProductProfitability pp
LEFT JOIN
    Purchasing.PurchaseOrderDetail pod ON pp.ProductID = pod.ProductID
    --Sales.SalesOrderDetail pod ON pp.ProductID = pod.ProductID

WHERE
    pod.ProductID IS NULL
ORDER BY
    pp.Product ASC;
/**/

---
WITH TopProductsWithRealProfitsCTE AS (
    SELECT TOP 10
        A.Name AS [Name of Product],
        SUM(B.OrderQty) AS TotalSoldQty
    FROM Sales.SalesOrderDetail B
    JOIN Production.Product A ON B.ProductID = A.ProductID
    GROUP BY A.ProductID, A.Name
    ORDER BY TotalSoldQty DESC
)

SELECT
    A.[Name of Product],
    ROUND(CAST(SUM(B.LineTotal - (B.OrderQty * C.StandardCost)) AS numeric(10, 2)), 2) AS RealProfit
FROM TopProductsWithRealProfitsCTE A
JOIN Sales.SalesOrderDetail B ON B.ProductID = (SELECT ProductID FROM Production.Product WHERE Name = A.[Name of Product])
JOIN Production.Product C ON B.ProductID = C.ProductID
GROUP BY A.[Name of Product]
ORDER BY RealProfit ASC;

---
/* Top 10 most profit based on quantity and cost*/
SELECT TOP 10
    A.ProductID,
	A.Name AS [Name of Product],
    ROUND(CAST(SUM(B.LineTotal - (B.OrderQty * A.StandardCost)) AS numeric(18, 2)), 2) AS TotalProfit,
    SUM(B.OrderQty) AS TotalQuantitySold
FROM Sales.SalesOrderDetail B
JOIN Production.Product A ON B.ProductID = A.ProductID
GROUP BY A.ProductID, A.Name
ORDER BY TotalProfit DESC;

/*Stores and what they sell the most*/
WITH VendorProductSales AS (
    SELECT
        pv.BusinessEntityID AS VendorID,
        p.ProductID,
        p.Name AS ProductName,
        COUNT(sod.SalesOrderDetailID) AS ProductCount
    FROM
        Purchasing.ProductVendor pv
        JOIN Production.Product p ON pv.ProductID = p.ProductID
        JOIN Sales.SalesOrderDetail sod ON p.ProductID = sod.ProductID
    GROUP BY
        pv.BusinessEntityID, p.ProductID, p.Name
)

SELECT 
    v.BusinessEntityID AS VendorID,
    v.Name AS VendorName,
    vp.ProductID,
    vp.ProductName,
    vp.ProductCount
FROM
    VendorProductSales vp
    JOIN Purchasing.Vendor v ON vp.VendorID = v.BusinessEntityID
ORDER BY
    ROW_NUMBER() OVER (PARTITION BY vp.VendorID ORDER BY vp.ProductCount DESC);

/* profit for vendor*/
WITH VendorProfitability AS (
    SELECT
        pv.BusinessEntityID AS VendorID,
        pod.ProductID,
        p.Name AS ProductName,
        SUM(pod.LineTotal) AS TotalPurchaseAmount,
        SUM(pod.OrderQty) AS TotalPurchasedQty,
        p.StandardCost AS VendorStandardCost,
        p.ListPrice AS VendorListPrice,
        ROUND(SUM(pod.LineTotal - (pod.OrderQty * p.StandardCost)), 2) AS VendorProfit
    FROM
        Purchasing.PurchaseOrderDetail pod
        JOIN Production.Product p ON pod.ProductID = p.ProductID
        JOIN Purchasing.ProductVendor pv ON p.ProductID = pv.ProductID
    GROUP BY
        pv.BusinessEntityID, pod.ProductID, p.Name, p.StandardCost, p.ListPrice
)

SELECT
    vp.VendorID,
    v.Name AS VendorName,
    vp.ProductID,
    vp.ProductName,
    vp.TotalPurchaseAmount,
    vp.TotalPurchasedQty,
    vp.VendorStandardCost,
    vp.VendorListPrice,
    vp.VendorProfit
FROM
    VendorProfitability vp
    JOIN Purchasing.Vendor v ON vp.VendorID = v.BusinessEntityID
ORDER BY
    VendorProfit DESC;

/**/
SELECT --TOP 10 
	A.Name, 
	B.LineTotal
FROM Production.Product A
JOIN Sales.SalesOrderDetail B 
ON A.ProductID = B.ProductID
ORDER BY B.LineTotal DESC;


/**/
WITH SalespersonSales AS (
    SELECT
        soh.SalesPersonID,
        sod.ProductID,
        p.Name AS ProductName,
        SUM(sod.OrderQty) AS TotalQuantitySold
    FROM
        Sales.SalesOrderDetail sod
    JOIN Sales.SalesOrderHeader soh ON sod.SalesOrderID = soh.SalesOrderID
    JOIN Production.Product p ON sod.ProductID = p.ProductID
    WHERE soh.SalesPersonID IS NOT NULL
    GROUP BY
        soh.SalesPersonID, sod.ProductID, p.Name
)

SELECT TOP 10
    SalesPersonID,
    TotalQuantitySold,
    ProductID,
    ProductName
FROM
    SalespersonSales
ORDER BY
    TotalQuantitySold DESC;
/**/

SELECT CONCAT(TABLE_SCHEMA, '.', TABLE_NAME) AS [TABLES] FROM information_schema.tables ORDER BY TABLE_SCHEMA;

SELECT CONCAT(TABLE_SCHEMA, '.', TABLE_NAME) AS [TABLES] 
FROM information_schema.tables 
WHERE TABLE_SCHEMA <> 'dbo'
ORDER BY TABLE_SCHEMA;

USE AdventureWorks2022
GO

