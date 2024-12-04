SELECT WorkOrderID AS 'Work Order ID',
	ScrappedQty AS 'Scrapped Quantity',
	StartDate AS 'Start Date',
	EndDate AS 'End Date'
FROM Production.WorkOrder
WHERE ScrappedQty > 0
	AND StartDate >= '2013-12-01'
	AND EndDate <= '2013-12-31'
;