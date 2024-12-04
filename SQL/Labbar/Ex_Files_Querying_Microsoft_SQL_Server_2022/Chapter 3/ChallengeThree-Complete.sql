SELECT * FROM Person.Address;
SELECT * FROM Person.StateProvince;
SELECT * FROM Person.CountryRegion;


SELECT Address.AddressID,
	Address.AddressLine1,
	Address.AddressLine2,
	Address.City,
	StateProvince.Name AS 'State or Province Name',
	CountryRegion.Name AS 'Country or Region Name'
FROM Person.Address INNER JOIN Person.StateProvince
	ON Address.StateProvinceID = StateProvince.StateProvinceID
	INNER JOIN Person.CountryRegion
	ON StateProvince.CountryRegionCode = CountryRegion.CountryRegionCode
ORDER BY AddressID;