SELECT FirstName
	, LastName
	, CONCAT(FirstName, ' ', MiddleName, ' ', LastName) AS FullName
	, CONCAT_WS(' ', FirstName, MiddleName, LastName) AS WithSeparator
FROM Person.Person;