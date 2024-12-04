SELECT TOP 10 WorkOrderID
	, NEWID() AS NewID
FROM Production.WorkOrder
ORDER BY NewID;