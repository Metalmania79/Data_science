/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [BusinessEntityID]
      ,[JobTitle]
      ,[BirthDate]
      ,[Gender]
      ,[HireDate]
      ,[VacationHours]/8 AS VacationDays
      ,[SickLeaveHours]/8 AS SickDays
  FROM [AdventureWorks2022].[HumanResources].[Employee]
  Order by SickDays DESC;

  SELECT TOP (1000) [BusinessEntityID]
      ,[JobTitle]
      ,[BirthDate]
      ,[Gender]
      ,[HireDate]
      ,[VacationHours]/8 AS VacationDays
      ,[SickLeaveHours]/8 AS SickDays
  FROM [AdventureWorks2022].[HumanResources].[Employee]
  Order by VacationDays DESC;

  USE AdventureWorks2022
  GO

  SELECT 
	A.Jobtitle,
	B.Rate
  FROM HumanResources.Employee A
  INNER JOIN HumanResources.EmployeePayhistory B
  ON A.BusinessEntityID = B.BusinessEntityID
  ORDER BY Rate DESC;

  SELECT 
  A.BusinessEntityID,
  A.JobTitle,
  B.FirstName,
  B.LastName,
  A.HireDate, 
  YEAR(HireDate) AS HireYear, 
--  MONTH(HireDate) AS HireMonth, 
--  DAY(HireDate) AS HireDay, 
--  DATEDIFF(day, HireDate, GETDATE()) AS DaysSinceHire, 
--  DATEADD(year, 10, HireDate) AS Anniversary,
  DATEDIFF(year, HireDate, GETDATE()) AS YearsSinceHire
FROM HumanResources.Employee A
JOIN Person.Person B
ON A.BusinessEntityID = B.BusinessEntityID
ORDER BY YearsSinceHire DESC;

USE AdventureWorks2022
GO
WITH WorkingYearsCTE
AS (
	SELECT 
	  A.JobTitle,
	  A.HireDate, 
	  DATEDIFF(YEAR, HireDate, GETDATE()) AS [Years in the Company]
	FROM HumanResources.Employee A
	JOIN Person.Person B
	ON A.BusinessEntityID = B.BusinessEntityID
	--ORDER BY [Years in the Company] DESC
 )
 SELECT
  MAX([Years in the Company]) AS [MAX Years in the Company],
  MIN([Years in the Company]) AS [MIN Years in the Company],
  AVG([Years in the Company]) AS [AVG Years in the Company]
 FROM WorkingYearsCTE


WITH EmployeeYearsCTE
AS (
	SELECT 
	  A.JobTitle,
	  A.BirthDate, 
	  DATEDIFF(YEAR, BirthDate, GETDATE()) AS [Years Old]
	FROM HumanResources.Employee A
	JOIN Person.Person B
	ON A.BusinessEntityID = B.BusinessEntityID
	--ORDER BY [Years in the Company] DESC
 )
 SELECT
  MAX([Years Old]) AS [Oldest Employee],
  MIN([Years Old]) AS [Youngest Employee],
  AVG([Years Old]) AS [Avg age for Employees]
 FROM EmployeeYearsCTE

 SELECT TOP (1000) [BusinessEntityID]
      ,[JobTitle]
      ,[BirthDate]
      ,[Gender]
      ,[HireDate]
  FROM [AdventureWorks2022].[HumanResources].[Employee]
  Order by [BirthDate] ASC;

  SELECT TOP 10 CONCAT(LastName, ' ', FirstName) AS [Customer Name], SUM(SalesAmount) AS [Total Sales]
FROM FactInternetSales F
INNER JOIN DimCustomer D
ON F.CustomerKey = D.CustomerKey
GROUP BY CONCAT(D.LastName, ' ', D.FirstName)
ORDER BY [Total Sales] DESC;