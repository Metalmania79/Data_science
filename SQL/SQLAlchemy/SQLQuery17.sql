/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [ProductID]
      ,[Name]
      ,[TotQtySold]
  FROM [AdventureWorks2022].[Sales].[VProductQtySold]

  ORDER BY [TotQtySold] DESC;