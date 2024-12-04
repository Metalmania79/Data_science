SELECT * FROM Production.ProductModelProductDescriptionCulture;

SELECT * FROM Production.Culture;


SELECT ProductModelID
    , ProductDescriptionID
    , CultureID
    , CASE CultureID
        WHEN 'ar' THEN 'Arabic'
        WHEN 'en' THEN 'English'
        WHEN 'es' THEN 'Spanish'
        WHEN 'fr' THEN 'French'
        WHEN 'he' THEN 'Hebrew'
        WHEN 'th' THEN 'Thai'
        WHEN 'zh-cht' THEN 'Chinese'
        ELSE 'Undefined'
    END AS CultureName
FROM Production.ProductModelProductDescriptionCulture;


SELECT BusinessEntityID
    , MaritalStatus
    , CASE MaritalStatus
        WHEN 'S' THEN 'Single'
        WHEN 'M' THEN 'Married'
    END AS MaritalStatusText
    , SalariedFlag
    , CASE SalariedFlag
        WHEN 0 THEN 'Paid Hourly Wage'
        WHEN 1 THEN 'Paid Annual Salary'
    END AS PaymentDescription
FROM HumanResources.Employee;