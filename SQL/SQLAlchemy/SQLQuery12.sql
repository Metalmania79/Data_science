/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [BusinessEntityID]
      ,[AccountNumber]
      ,[Name]
      ,[CreditRating]
      ,[PreferredVendorStatus]
      ,[ActiveFlag]
      ,[PurchasingWebServiceURL]
      ,[ModifiedDate]
  FROM [AdventureWorks2022].[Purchasing].[Vendor]

USE AdventureWorks2022
GO



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




