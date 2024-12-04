DECLARE @Counter INT = 1;
WHILE @Counter <= 3
	BEGIN
		SELECT @Counter AS CurrentValue
		SET @Counter += 1
	END;

-- Select 3 products with a WHILE loop
DECLARE @Counter INT = 1;
DECLARE @Product INT = 710;

WHILE @Counter <= 3
	BEGIN
		SELECT ProductID
			, Name
			, ProductNumber
			, Color
			, ListPrice
		FROM Production.Product
		WHERE ProductID = @Product;
		SET @Counter += 1
		SET @Product += 10
	END;