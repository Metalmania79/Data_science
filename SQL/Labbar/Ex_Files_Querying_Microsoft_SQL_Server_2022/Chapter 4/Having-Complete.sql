SELECT Color
	, COUNT(*) AS NumberOfProducts
FROM Production.Product
WHERE Color IS NOT NULL
GROUP BY Color
HAVING COUNT(*) > 25;