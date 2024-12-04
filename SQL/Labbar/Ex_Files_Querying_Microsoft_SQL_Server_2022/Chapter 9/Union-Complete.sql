SELECT ProductCategoryID
	, NULL AS ProductSubcategoryID
	, Name
FROM Production.ProductCategory

UNION ALL

SELECT ProductCategoryID 
	, ProductSubcategoryID
	, Name
FROM Production.ProductSubcategory;