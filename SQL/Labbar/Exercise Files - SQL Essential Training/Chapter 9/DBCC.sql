-- Using SQL Server database console commands


-- Checks the logical and physical integrity of all objects in the specified database.
USE WideWorldImporters;
GO

DBCC CHECKDB;


-- if errors are identified, repair options are available
-- database must be in single user mode
DBCC CHECKDB ('WideWorldImporters', REPAIR_ALLOW_DATA_LOSS); -- REPAIR_FAST or REPAIR_REBUILD


DBCC CHECKFILEGROUP (0, NOINDEX)
    WITH PHYSICAL_ONLY,
         ESTIMATEONLY;
GO

-- documentation on DBCC:
-- https://docs.microsoft.com/sql/t-sql/database-console-commands/dbcc-transact-sql