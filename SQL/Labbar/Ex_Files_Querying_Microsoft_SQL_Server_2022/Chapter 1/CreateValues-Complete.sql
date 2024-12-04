SELECT Name,
	ProductNumber,
	'AdventureWorks' AS Manufacturer,
	ListPrice,
	ListPrice * .85 AS SalePrice
FROM Production.Product
WHERE ListPrice > 0;