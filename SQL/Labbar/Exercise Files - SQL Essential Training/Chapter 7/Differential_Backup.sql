USE Red30Tech;
GO

INSERT INTO Customers (FirstName, LastName, Address, City, State)
	VALUES ('Emily','Hayes','9 South Crossing','Cleveland','OH'),
		('Dennis','Bishop','33 Victoria Circle','El Paso','TX'),
		('Frank','Rogers','9 Tomscot Place','Dallas','TX'),
		('Dorothy','Tucker','7715 Havey Center','Los Angeles','CA'),
		('Steven','Jenkins','772 Eagle Crest Court','Seattle','WA')
;

SELECT *
FROM Customers;
