SELECT Department.Name
FROM HumanResources.Department;

SELECT AddressType.Name
FROM Person.AddressType;

SELECT Department.Name AS 'DepartmentName',
	AddressType.Name AS 'AddressName'
FROM HumanResources.Department CROSS JOIN Person.AddressType;

SELECT A.Name AS 'HomeTeam'
 , B.Name AS 'AwayTeam'
FROM HumanResources.Department AS A CROSS JOIN
	HumanResources.Department AS B
WHERE A.Name <> B.Name;