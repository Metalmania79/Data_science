SELECT FirstName
	, LastName
	, UPPER(FirstName) AS UpperCase
	, LOWER(LastName) AS LowerCase
	, LEN(FirstName) AS LengthOfFirstName
	, LEFT(LastName, 3) AS FirstThreeLetters
	, RIGHT(LastName, 3) AS LastThreeLetters
	, TRIM(LastName) AS TrimmedName
FROM Person.Person;