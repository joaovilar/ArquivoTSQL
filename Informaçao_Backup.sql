
/*******************************************

Script: Backup and Restore Sequence
Author: Manohar Punna

Version 1.0
	Provies backup sequence with the shortest restore time. 
	This script only works if the backup history is available till the oldest restorable file needed for the shortest restore.

*******************************************/
DECLARE @backup_history TABLE(server_name SYSNAME,
            database_name SYSNAME,
            backup_start_date DATETIME,
            backup_finish_date DATETIME, 
            backup_type NVARCHAR(15),           
            backup_size DECIMAL(10,2),
            compressed_size DECIMAL(10,2),
            duration_seconds INT,
            database_creation_date DATETIME,
            recovery_model NVARCHAR(10),
            physical_device_name NVARCHAR(500),
            user_name SYSNAME)

DECLARE cur CURSOR FOR
SELECT DISTINCT(name) FROM sys.databases WHERE name <> 'tempdb'
DECLARE @DBName NVARCHAR(1000)

OPEN cur
FETCH NEXT FROM cur
INTO @DBName

WHILE(@@FETCH_STATUS = 0)
BEGIN
;with D AS
(
select b.server_name,
            b.database_name,
            b.backup_start_date,
            b.backup_finish_date, 
            'FULL' AS backup_type,        
            b.backup_size/1024/1024 AS backup_size,
            b.compressed_backup_size/1024/1024 AS compressed_size,            
            DATEDIFF(SECOND,b.backup_start_date, b.backup_finish_date) AS duration_seconds,
            b.database_creation_date,
            b.recovery_model,
            f.physical_device_name,
            b.user_name
from msdb.dbo.backupmediafamily f
inner join msdb.dbo.backupset b
on b.media_set_id = f.media_set_id
WHERE b.database_name = @DBName
AND b.backup_finish_date = (SELECT MAX(backup_finish_date) 
                  FROM msdb.dbo.backupset 
                  WHERE database_name = @DBName AND type = 'D' AND is_copy_only = 0)
AND b.type = 'D')
,I AS
(
select b.server_name,
            b.database_name,
            b.backup_start_date,
            b.backup_finish_date, 
            'Differential' AS backup_type,            
            b.backup_size/1024/1024 AS backup_size,
            b.compressed_backup_size/1024/1024 AS compressed_size,            
            DATEDIFF(SECOND,b.backup_start_date, b.backup_finish_date) AS duration_seconds,
            b.database_creation_date,
            b.recovery_model,
            f.physical_device_name,
            b.user_name
from msdb.dbo.backupmediafamily f
inner join msdb.dbo.backupset b
on b.media_set_id = f.media_set_id
WHERE b.database_name = @DBName
AND b.type = 'I'
AND b.backup_finish_date = (SELECT MAX(backup_finish_date) 
                  FROM msdb.dbo.backupset 
                  WHERE database_name = @DBName AND type = 'I' AND is_copy_only = 0
                  AND backup_finish_date > (SELECT backup_finish_date FROM D))),
L AS
(
select b.server_name,
            b.database_name,
            b.backup_start_date,
            b.backup_finish_date, 
            'Log' AS backup_type,         
            b.backup_size/1024/1024 AS backup_size,
            b.compressed_backup_size/1024/1024 AS compressed_size,            
            DATEDIFF(SECOND,b.backup_start_date, b.backup_finish_date) AS duration_seconds,
            b.database_creation_date,
            b.recovery_model,
            f.physical_device_name,
            b.user_name
from msdb.dbo.backupmediafamily f
inner join msdb.dbo.backupset b
on b.media_set_id = f.media_set_id
WHERE b.database_name = @DBName
AND b.type = 'L'
AND b.backup_finish_date > (CASE WHEN (SELECT COUNT(1) FROM I) <> 0 THEN (SELECT backup_finish_date FROM I) ELSE (SELECT backup_finish_date FROM D) END))

INSERT @backup_history
SELECT * FROM L
UNION ALL
SELECT * FROM I
UNION ALL
SELECT * FROM D
ORDER BY backup_finish_date

FETCH NEXT FROM cur
INTO @DBName

END

CLOSE cur
DEALLOCATE cur

SELECT server_name AS Instance,
	database_name AS DBName,	
	backup_type AS bkptype,
	--backup_size,
	--compressed_size,
	--duration_seconds,
	--database_creation_date,
	--recovery_model,
	--backup_start_date,
	physical_device_name AS bkpfile,
	backup_finish_date AS bkptime,
	user_name AS bkpuser
FROM @backup_history