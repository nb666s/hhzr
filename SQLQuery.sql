Use EduBase
BACKUP DATABASE EduBase		
	TO DISK ='C:\EduBase.Backup'

EXEC msdb.dbo.sp_add_job		
	@job_name = 'jb_EduBase_FullBackup_Weekly'	
		
		
EXEC msdb.dbo.sp_add_jobstep		
	@job_name = 'jb_EduBase_FullBackup_Weekly'	
	,@step_name = 'js_EduBase_FullBackup'	
	,@step_id = 1	
	,@database_name = 'EduBase'	
	,@subsystem = 'TSQL'	
	,@command = 	
		'BACKUP DATABASE EduBase TO DISK =  ''C:\EduBase.Backup'''	

EXEC msdb.dbo.sp_add_jobschedule		
	@job_name = 'jb_EduBase_FullBackup_Weekly'	
	,@name = 'jc_EduBase_FullBackup_Sunday2200'	
	,@freq_type = 8	
	,@freq_interval = 1	
	,@freq_recurrence_factor = 1			
	,@active_start_time = 220000	
		
EXEC msdb.dbo.sp_add_jobserver		
	@job_name = 'jb_EduBase_FullBackup_Weekly'	
	,@server_name = @@SERVERNAME;

CREATE NONCLUSTERED INDEX ni_Course_PinYin			
	ON tb_Course	
		(PinYin ASC);	


UPDATE STATISTICS tb_Course ni_Course_PinYin		
	WITH FULLSCAN;			

