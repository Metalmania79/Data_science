-- Using SQL Server dynamic management views


-- Returns space usage information for each file in the database.
SELECT *
FROM sys.dm_db_file_space_usage;


-- Returns information about the connections established to this instance of SQL Server
SELECT *
FROM sys.dm_exec_connections;


-- Returns counts of different types of index operations
-- and the time each type of operation was last performed.
SELECT DB_NAME(database_id) AS DatabaseName,
	OBJECT_NAME(object_id) AS ObjectName,
	* 
FROM sys.dm_db_index_usage_stats;

-- documentation on system dynamic management views:
-- https://docs.microsoft.com/sql/relational-databases/system-dynamic-management-views