-- Match a letter pattern
SELECT FirstName
FROM Person.Person
WHERE FirstName LIKE 'A%';


-- Match a specific number of letters
SELECT FirstName
FROM Person.Person
WHERE FirstName LIKE 'A___';


-- Match a set of letters
SELECT FirstName
FROM Person.Person
WHERE FirstName LIKE 'A[LMN]___';


-- Match a range of letters
SELECT FirstName
FROM Person.Person
WHERE FirstName LIKE 'A[L-N]___';