DECLARE @MyFirstVariable INT;
SET @MyFirstVariable = 10;

SELECT @MyFirstVariable AS MyValue
	, @MyFirstVariable * 5 AS Multiplication
	, @MyFirstVariable + 10 AS Addition;

DECLARE @Color VARCHAR(20) = 'Red';

SELECT ProductID
	, Name
	, ProductNumber
	, Color
	, ListPrice
FROM Production.Product
WHERE Color = @Color;