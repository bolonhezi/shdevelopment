USE [PS_UserData]
GO
/****** Object:  StoredProcedure [dbo].[usp_Try_GameLogout_R]    Script Date: 02/07/2012 19:10:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Stored Procedure dbo.usp_Try_GameLogout_R    Script Date: 2008-6-7 18:34:05 ******/
ALTER        Proc [dbo].[usp_Try_GameLogout_R]

@UserUID int,
@SessionID bigint,
@LogoutType smallint = 0,
@ErrType int = 0

AS

SET NOCOUNT ON

DECLARE @LogTime datetime
DECLARE @Sql nvarchar(4000)
DECLARE @yyyy varchar(4)
DECLARE @mm varchar(2)
DECLARE @dd varchar(2)
DECLARE @LogType bit	-- Login:0, Logout:1

SET @LogType = 1
SET @LogTime = GETDATE()
SET @yyyy = DATEPART(yyyy, @LogTime)
SET @mm = DATEPART(mm, @LogTime)
SET @dd = DATEPART(dd, @LogTime)

IF( LEN(@mm) = 1 )
BEGIN
	SET @mm = '0' + @mm
END

IF( LEN(@dd) = 1 )
BEGIN
	SET @dd = '0' + @dd
END

UPDATE Users_Master SET Leave = 0, LeaveDate = GETDATE() WHERE UserUID = @UserUID

UPDATE PS_GameLog.dbo.UserLog
SET LogoutTime=@LogTime, LogoutType=@LogoutType, LogoutErrType=@ErrType
WHERE UserUID=@UserUID AND SessionID=@SessionID


SET @Sql = N'
INSERT INTO PS_GameLog.dbo.UserLog
(SessionID, UserUID, LogType, LogTime, LogoutType, ErrType)
VALUES(@SessionID, @UserUID, @LogType, @LogTime, @LogoutType, @ErrType)'

EXEC sp_executesql @Sql, 
N'@SessionID bigint, @UserUID int, @LogType bit, @LogTime datetime, @LogoutType smallint, @ErrType int',
@SessionID, @UserUID, @LogType, @LogTime, @LogoutType, @ErrType

SET NOCOUNT OFF
