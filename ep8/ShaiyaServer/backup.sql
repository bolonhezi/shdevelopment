DECLARE @pfad varchar(512);SET @pfad = 'C:\Backup\Database\Shaiya\'

DECLARE @date varchar(64);SET @date = REPLACE(CONVERT(varchar, GETDATE(), 120), ':', '.')
DECLARE @datei varchar(512);DECLARE @name varchar(128)
SET @datei = @pfad + N'PS_Billing ' + @date + N'.bak'
SET @name = N'PS_Billing ' + @date
BACKUP DATABASE [PS_Billing] TO DISK = @datei WITH NOFORMAT, NOINIT, NAME = @name, SKIP, NOREWIND, NOUNLOAD, STATS = 10
GO

DECLARE @pfad varchar(512);SET @pfad = 'C:\Backup\Database\Shaiya\'

DECLARE @date varchar(64);SET @date = REPLACE(CONVERT(varchar, GETDATE(), 120), ':', '.')
DECLARE @datei varchar(512);DECLARE @name varchar(128)
SET @datei = @pfad + N'PS_Chatlog ' + @date + N'.bak'
SET @name = N'PS_Chatlog ' + @date
BACKUP DATABASE [PS_Chatlog] TO DISK = @datei WITH NOFORMAT, NOINIT, NAME = @name, SKIP, NOREWIND, NOUNLOAD, STATS = 10
GO

DECLARE @pfad varchar(512);SET @pfad = 'C:\Backup\Database\Shaiya\'

DECLARE @date varchar(64);SET @date = REPLACE(CONVERT(varchar, GETDATE(), 120), ':', '.')
DECLARE @datei varchar(512);DECLARE @name varchar(128)
SET @datei = @pfad + N'PS_GameData ' + @date + N'.bak'
SET @name = N'PS_GameData ' + @date
BACKUP DATABASE [PS_GameData] TO DISK = @datei WITH NOFORMAT, NOINIT, NAME = @name, SKIP, NOREWIND, NOUNLOAD, STATS = 10
GO

DECLARE @pfad varchar(512);SET @pfad = 'C:\Backup\Database\Shaiya\'

DECLARE @date varchar(64);SET @date = REPLACE(CONVERT(varchar, GETDATE(), 120), ':', '.')
DECLARE @datei varchar(512);DECLARE @name varchar(128)
SET @datei = @pfad + N'PS_GameDefs ' + @date + N'.bak'
SET @name = N'PS_GameDefs ' + @date
BACKUP DATABASE [PS_GameDefs] TO DISK = @datei WITH NOFORMAT, NOINIT, NAME = @name, SKIP, NOREWIND, NOUNLOAD, STATS = 10
GO

DECLARE @pfad varchar(512);SET @pfad = 'C:\Backup\Database\Shaiya\'

DECLARE @date varchar(64);SET @date = REPLACE(CONVERT(varchar, GETDATE(), 120), ':', '.')
DECLARE @datei varchar(512);DECLARE @name varchar(128)
SET @datei = @pfad + N'PS_GameLog ' + @date + N'.bak'
SET @name = N'PS_GameLog ' + @date
BACKUP DATABASE [PS_GameLog] TO DISK = @datei WITH NOFORMAT, NOINIT, NAME = @name, SKIP, NOREWIND, NOUNLOAD, STATS = 10
GO

DECLARE @pfad varchar(512);SET @pfad = 'C:\Backup\Database\Shaiya\'

DECLARE @date varchar(64);SET @date = REPLACE(CONVERT(varchar, GETDATE(), 120), ':', '.')
DECLARE @datei varchar(512);DECLARE @name varchar(128)
SET @datei = @pfad + N'PS_GMTool ' + @date + N'.bak'
SET @name = N'PS_GMTool ' + @date
BACKUP DATABASE [PS_GMTool] TO DISK = @datei WITH NOFORMAT, NOINIT, NAME = @name, SKIP, NOREWIND, NOUNLOAD, STATS = 10
GO

DECLARE @pfad varchar(512);SET @pfad = 'C:\Backup\Database\Shaiya\'

DECLARE @date varchar(64);SET @date = REPLACE(CONVERT(varchar, GETDATE(), 120), ':', '.')
DECLARE @datei varchar(512);DECLARE @name varchar(128)
SET @datei = @pfad + N'PS_StatData ' + @date + N'.bak'
SET @name = N'PS_StatData ' + @date
BACKUP DATABASE [PS_StatData] TO DISK = @datei WITH NOFORMAT, NOINIT, NAME = @name, SKIP, NOREWIND, NOUNLOAD, STATS = 10
GO

DECLARE @pfad varchar(512);SET @pfad = 'C:\Backup\Database\Shaiya\'

DECLARE @date varchar(64);SET @date = REPLACE(CONVERT(varchar, GETDATE(), 120), ':', '.')
DECLARE @datei varchar(512);DECLARE @name varchar(128)
SET @datei = @pfad + N'PS_STATICS ' + @date + N'.bak'
SET @name = N'PS_STATICS ' + @date
BACKUP DATABASE [PS_STATICS] TO DISK = @datei WITH NOFORMAT, NOINIT, NAME = @name, SKIP, NOREWIND, NOUNLOAD, STATS = 10
GO

DECLARE @pfad varchar(512);SET @pfad = 'C:\Backup\Database\Shaiya\'

DECLARE @date varchar(64);SET @date = REPLACE(CONVERT(varchar, GETDATE(), 120), ':', '.')
DECLARE @datei varchar(512);DECLARE @name varchar(128)
SET @datei = @pfad + N'PS_UserData ' + @date + N'.bak'
SET @name = N'PS_UserData ' + @date
BACKUP DATABASE [PS_UserData] TO DISK = @datei WITH NOFORMAT, NOINIT, NAME = @name, SKIP, NOREWIND, NOUNLOAD, STATS = 10
GO


DECLARE @pfad varchar(512);SET @pfad = 'C:\Backup\Database\Shaiya\'

DECLARE @date varchar(64);SET @date = REPLACE(CONVERT(varchar, GETDATE(), 120), ':', '.')
DECLARE @datei varchar(512);DECLARE @name varchar(128)
SET @datei = @pfad + N'Board ' + @date + N'.bak'
SET @name = N'Board ' + @date
BACKUP DATABASE [Board] TO DISK = @datei WITH NOFORMAT, NOINIT, NAME = @name, SKIP, NOREWIND, NOUNLOAD, STATS = 10
GO


DECLARE @pfad varchar(512);SET @pfad = 'C:\Backup\Database\Shaiya\'

DECLARE @date varchar(64);SET @date = REPLACE(CONVERT(varchar, GETDATE(), 120), ':', '.')
DECLARE @datei varchar(512);DECLARE @name varchar(128)
SET @datei = @pfad + N'Gameweb ' + @date + N'.bak'
SET @name = N'Gameweb ' + @date
BACKUP DATABASE [Gameweb] TO DISK = @datei WITH NOFORMAT, NOINIT, NAME = @name, SKIP, NOREWIND, NOUNLOAD, STATS = 10
GO


DECLARE @pfad varchar(512);SET @pfad = 'C:\Backup\Database\Shaiya\'

DECLARE @date varchar(64);SET @date = REPLACE(CONVERT(varchar, GETDATE(), 120), ':', '.')
DECLARE @datei varchar(512);DECLARE @name varchar(128)
SET @datei = @pfad + N'OMG_GameWEB ' + @date + N'.bak'
SET @name = N'OMG_GameWEB ' + @date
BACKUP DATABASE [OMG_GameWEB] TO DISK = @datei WITH NOFORMAT, NOINIT, NAME = @name, SKIP, NOREWIND, NOUNLOAD, STATS = 10
GO

