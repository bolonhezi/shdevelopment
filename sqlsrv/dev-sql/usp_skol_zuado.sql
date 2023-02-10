USE [PS_GameLog]
GO
/****** Object:  StoredProcedure [dbo].[usp_Insert_Action_Log_E]    Script Date: 01/25/2023 04:06:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER  Proc [dbo].[usp_Insert_Action_Log_E]

@UserID varchar(18),
@UserUID int,
@CharID int,
@CharName varchar(50),
@CharLevel tinyint,
@CharExp int,
@MapID smallint,
@PosX real,
@PosY real,
@PosZ real,
@ActionTime datetime,
@ActionType tinyint,
@Value1 bigint = null,
@Value2 int = null,
@Value3 int = null,
@Value4 bigint = null,
@Value5 int = null,
@Value6 int = null,
@Value7 int = null,
@Value8 int = null,
@Value9 int = null,
@Value10 int = null,
@Text1 varchar(100) = '',
@Text2 varchar(100) = '',
@Text3 varchar(100) = '',
@Text4 varchar(100) = '',
@Sql nvarchar(4000) = '',
@yyyy varchar(4) = '',
@mm varchar(2) = '',
@dd varchar(2) = '',
@Bucket smallint = -1
AS
DECLARE @CharLeave int

SET @yyyy = datepart(yyyy, @ActionTime)
SET @mm = datepart(mm, @ActionTime)
SET @dd = datepart(dd, @ActionTime)
SET @CharLeave = 1

IF @ActionType = 116 --Trade Item-remove item from originator
BEGIN
    WAITFOR DELAY '00:00:05' --Time delay to give the duper time to log out fully
    
    SELECT @CharLeave=Leave
    FROM PS_userdata.dbo.Users_Master
    WHERE UserUID=@UserUID

    IF @CharLeave=0
    BEGIN
        EXEC PS_GameData.dbo.usp_Save_Char_Item_Del_E @CharID=@CharID, @IDList=@Value1
    END
END

IF @ActionType = 164 --Trade Gold-remove gold from originator
BEGIN

    WAITFOR DELAY '00:00:05' --Time delay to give the duper time to log out fully

    SELECT @CharLeave=Leave
    FROM PS_userdata.dbo.Users_Master
    WHERE UserUID=@UserUID

    IF @CharLeave=0
    BEGIN
        UPDATE PS_GameData.dbo.Chars
        SET [Money]=@Value2
        WHERE PS_GameData.dbo.Chars.CharID=@CharID
    END
END

DECLARE
@DIP varchar (100),
@UID varchar (100),
@KIP Varchar (100)

IF (@ActionType = 103)

BEGIN
SELECT @UID = um.UserID FROM PS_UserData.dbo.Users_Master as um 
INNER JOIN PS_GameData.dbo.Chars as c ON c.UserUID = um.UserUID 
inner join PS_GameLog.dbo.ActionLog as a  on a.Value1 = c.CharID Where c.CharID = @Value1 AND ActionType = 103

SELECT @KIP = um.UserIp FROM PS_UserData.dbo.Users_Master as um 
INNER JOIN PS_GameData.dbo.Chars as c ON c.UserUID = um.UserUID 
inner join PS_GameLog.dbo.ActionLog as a  on a.Value1 = c.CharID Where c.CharID = @Value1 AND ActionType = 103

Select @DIP = um.UserIP FROM PS_UserData.dbo.Users_Master as um
INNER JOIN PS_GameLog.dbo.ActionLog as a on um.UserID = a.UserID WHERE um.UserID=@UserID AND ActionType = 103

IF @DIP = @KIP

INSERT INTO GM_Stuff.dbo.StatPadder (DeadToon,DeadIP,DeadID,KillerToon,KillerIP,KillerID,Date,Map)
VALUES (@Text1,@KIP,@UID,@CharName,@DIP,@UserID,@ActionTime,@MapID)
END
BEGIN
INSERT INTO PS_GameLog.dbo.ActionLog
(UserID, UserUID, CharID, CharName, CharLevel, CharExp, MapID,  PosX, PosY, PosZ, ActionTime, ActionType, 
Value1, Value2, Value3, Value4, Value5, Value6, Value7, Value8, Value9, Value10, Text1, Text2, Text3, Text4)
VALUES(@UserID, @UserUID, @CharID, @CharName, @CharLevel, @CharExp, @MapID, @PosX, @PosY, @PosZ, @ActionTime, @ActionType, 
@Value1, @Value2, @Value3, @Value4, @Value5, @Value6, @Value7, @Value8, @Value9, @Value10, @Text1, @Text2, @Text3, @Text4)
END

-- -----------------------------------------

IF @ActionType = 108
	BEGIN
        UPDATE PS_GameData.dbo.Chars SET [LoginStatus]=0 WHERE PS_GameData.dbo.Chars.CharID=@CharID 	
	END
IF @ActionType = 107
	BEGIN
        UPDATE PS_GameData.dbo.Chars SET [LoginStatus]=1 WHERE PS_GameData.dbo.Chars.CharID=@CharID		
    END
    
-- -----------------------------------------

DECLARE
@ItemID int
SET @ItemID = @Value2

IF @ActionType = 114
BEGIN

-- 1 AP Card

	IF (@ItemID = 78185)
	BEGIN 
	
		UPDATE PS_UserData.dbo.Users_Master 
		SET Point = (Point + @Value4 * 1) 
		WHERE UserUID = @UserUID
		
	END


-- 10 AP Card

	IF (@ItemID = 78186)
	BEGIN 
	
		UPDATE PS_UserData.dbo.Users_Master 
		SET Point = (Point + @Value4 * 10) 
		WHERE UserUID = @UserUID
		
	END


-- 20 AP Card

	IF (@ItemID = 78187)
	BEGIN 
	
		UPDATE PS_UserData.dbo.Users_Master 
		SET Point = (Point + @Value4 * 20) 
		WHERE UserUID = @UserUID
		
	END


-- 50 AP Card

	IF (@ItemID = 78183)
	BEGIN 
	
		UPDATE PS_UserData.dbo.Users_Master 
		SET Point = (Point + @Value4 * 50) 
		WHERE UserUID = @UserUID
		
	END

END

-- -----------------------------------------

SET @yyyy = datepart(yyyy, @ActionTime)
SET @mm = datepart(mm, @ActionTime)
SET @dd = datepart(dd, @ActionTime)


IF(LEN(@mm) = 1)
BEGIN
	SET @mm = '0' + @mm
END

IF(LEN(@dd) = 1)
BEGIN
	SET @dd = '0' + @dd
END

SET @Sql = N'
INSERT INTO PS_GameLog.dbo.ActionLog
(UserID, UserUID, CharID, CharName, CharLevel, CharExp, MapID,  PosX, PosY, PosZ, ActionTime, ActionType, 
Value1, Value2, Value3, Value4, Value5, Value6, Value7, Value8, Value9, Value10, Text1, Text2, Text3, Text4)
VALUES(@UserID, @UserUID, @CharID, @CharName, @CharLevel, @CharExp, @MapID, @PosX, @PosY, @PosZ, @ActionTime, @ActionType, 
@Value1, @Value2, @Value3, @Value4, @Value5, @Value6, @Value7, @Value8, @Value9, @Value10, @Text1, @Text2, @Text3, @Text4)'

EXEC sp_executesql @Sql, 
N'@UserID varchar(18), @UserUID int, @CharID int, @CharName varchar(50), 
@CharLevel tinyint, @CharExp int, @MapID smallint, @PosX real, @PosY real, @PosZ real, @ActionTime datetime, @ActionType tinyint, 
@Value1 bigint, @Value2 int, @Value3 int, @Value4 bigint, @Value5 int, @Value6 int, @Value7 int, @Value8 int, 
@Value9 int, @Value10 int, @Text1 varchar(100), @Text2 varchar(100), @Text3 varchar(100), @Text4 varchar(100)',
@UserID, @UserUID, @CharID, @CharName, @CharLevel, @CharExp, @MapID, @PosX, @PosY, @PosZ, @ActionTime, @ActionType, 
@Value1, @Value2, @Value3, @Value4, @Value5, @Value6, @Value7, @Value8, @Value9, @Value10, @Text1, @Text2, @Text3, @Text4
