USE [PS_UserData]
GO
/****** Object:  StoredProcedure [dbo].[usp_Try_GameLogin_Taiwan]    Script Date: 02/07/2012 19:09:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER  Proc [dbo].[usp_Try_GameLogin_Taiwan]

@UserID 	varchar(18),
@InPassword	varchar(32),
@SessionID 	bigint,
@UserIP 	varchar(15),
@UserUID 	int = 0,
@LoginType 	smallint = 1, 
@LoginTime 	datetime = NULL

AS

SET NOCOUNT ON

DECLARE 

@Leave 		tinyint,
@Status 		smallint,
@CompanyIP 	varchar(15),
@TempIP 	varchar(15),
@Check		int,
@UseQueue	int,
@TimeReleased datetime,
@LeaveDate  datetime

SET @Status =		 -1
SET @LoginTime = 	GETDATE()

--------------------------------------------------
SET @CompanyIP = 	'61.107.81'
SET @UserIP =		LTRIM( RTRIM(@UserIP) )
--------------------------------------------------
SET @Check = 0
--------------------------------------------------
--Check for IP ban, if so set the status of the user to banned.
IF(SELECT COUNT(*) FROM [GM_Stuff].[dbo].[BannedIP] where [IP1] = @UserIP) > 0
BEGIN
	SET @Status = -2
	UPDATE PS_UserData.dbo.Users_Master SET [Status] = @Status WHERE UserID = @UserID	
END
IF(SELECT COUNT(*) FROM PS_UserData.dbo.Users_Master where [UserIp] = @UserIP and [Status] = '-2') > 0
BEGIN
-- if previous section returns results witch means the ip is attatched to an account previously ip banned
	IF(SELECT COUNT(*) FROM [GM_Stuff].[dbo].[BannedIP] where [UserID] = @UserID) > 0
	UPDATE [GM_Stuff].[dbo].[BannedIP] SET [LogAtempt] = 'TRUE' WHERE UserID = @UserID 
	Else  INSERT INTO [GM_Stuff].[dbo].[BannedIP] (UserID,BanDate,IP1,StaffID,StaffIP,[LogAtempt])  
	Values (@UserID,GETDATE(),@UserIP,'Log','127.0.0.1','TRUE')
END
--Check if 3day and 14day banments are ready for release then do so if ready
SELECT @TimeReleased = TimeReleased From GM_Stuff.dbo.BannedAccounts Where UserID = @UserID
IF ( @TimeReleased < GETDATE()) 
BEGIN
	UPDATE PS_UserData.dbo.Users_Master SET [Status] = 0 WHERE UserID=@UserID
	DELETE FROM GM_Stuff.dbo.BannedAccounts WHERE UserID=@UserID
END

SELECT @UserUID=UserUID, @Status=Status,@UseQueue=UseQueue, @Leave=Leave FROM Users_Master WHERE UserID = @UserID

-- NotExist User OR Leave User
IF( @UserUID = 0 OR @Leave = 1 )
BEGIN
	SET @Status = -3
END
-- Dupe fix section
ELSE IF (@Leave = 1) --This blocks a logged in account from being kicked
BEGIN
    SET @Status = -5
END
ELSE IF (DATEDIFF(SECOND, @LeaveDate, GETDATE()) < 6)--This is the time delay
BEGIN
    SET @Status = -7
END
-- verified email at regestration check
--ELSE IF (@UseQueue='0')
--BEGIN
--SET @Status= -7
--END

ELSE
BEGIN
	-- Check Password
	EXEC dbo.sp_LoginSuccessCheck @UserID, @InPassword, @Check output
	IF ( @@ERROR = 0 )
	BEGIN
		IF( @Check <> 1 )
		BEGIN
			SET @Status = -1
		END
	END
	ELSE
	BEGIN
		SET @Status = -1
	END
END

-- Select 
SELECT @Status AS Status, @UserUID AS UserUID

-- Log Insert
IF( @Status = 0 OR @Status = 16 OR @Status = 32 OR @Status = 48 OR @Status = 64 OR @Status = 80 )
BEGIN
    UPDATE Users_Master SET Leave = 1, JoinDate = GETDATE() WHERE UserUID = @UserUID
END

BEGIN
	EXEC usp_Insert_LoginLog_E @SessionID=@SessionID, @UserUID=@UserUID, @UserIP=@UserIP, @LogType=0, @LogTime=@LoginTime, @LoginType=@LoginType
END
BEGIN 
	UPDATE PS_UserData.dbo.Users_Master set UserIp = @UserIP WHERE UserID = @UserID
END
SET NOCOUNT OFF