-- filter nulls with a WHERE clause
SELECT WorkOrderID,
	ScrappedQty,
	ScrapReasonID
FROM Production.WorkOrder
WHERE ScrapReasonID IS NOT NULL;


-- use the ISNULL function
SELECT WorkOrderID,
	ScrappedQty,
	ISNULL( ScrapReasonID, 99) AS ScrapReason
FROM Production.WorkOrder
;