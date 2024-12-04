-- Use INTERSECT to find all products with a photo and review
SELECT ProductID
FROM Production.ProductProductPhoto

INTERSECT

SELECT ProductID
FROM Production.ProductReview;

-- Use an INNER JOIN to arrive at the same result with SELECT DISTINCT
SELECT DISTINCT ProductProductPhoto.ProductID
FROM Production.ProductProductPhoto INNER JOIN
	Production.ProductReview
	ON ProductProductPhoto.ProductID = ProductReview.ProductID;