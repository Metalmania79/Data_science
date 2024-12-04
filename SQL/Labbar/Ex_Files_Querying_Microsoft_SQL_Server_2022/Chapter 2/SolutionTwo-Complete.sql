SELECT Name
FROM Purchasing.Vendor
WHERE (Name LIKE 'C%') AND ((Name LIKE '%Bike%') OR (Name LIKE '%Bicycle%'))

SELECT Name
FROM Purchasing.Vendor
WHERE Name LIKE 'C%' AND Name LIKE '%Bike%'
   OR Name LIKE 'C%' AND Name LIKE '%Bicycle%'