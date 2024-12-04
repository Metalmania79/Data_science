CREATE TABLE ProductCategories (
	CategoryID int IDENTITY(1,1) NOT NULL,
	CategoryName varchar(25) NOT NULL,
	CategoryAbbreviation char(2) NOT NULL
);

INSERT INTO ProductCategories(CategoryName,CategoryAbbreviation)
	VALUES ('BluePrints','BP'),
		('Drone Kits','DK'),
		('Drones','DS'),
		('EBooks','EB'),
		('Robot Kits','RK'),
		('Robots','RS'),
		('Training Videos','TV')
;