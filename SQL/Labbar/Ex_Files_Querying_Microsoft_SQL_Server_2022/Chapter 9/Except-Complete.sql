-- Select people without credit cards using EXCEPT
SELECT BusinessEntityID
FROM Person.Person
WHERE PersonType <> 'EM'

EXCEPT

SELECT BusinessEntityID
FROM Sales.PersonCreditCard;

-- Return the same results using a left join and WHERE conditions
SELECT Person.BusinessEntityID
FROM Person.Person LEFT JOIN Sales.PersonCreditCard
	ON Person.BusinessEntityID = PersonCreditCard.BusinessEntityID
WHERE Person.PersonType <> 'EM' AND
	PersonCreditCard.CreditCardID IS NULL;