/****** Script Date: 01/06/2023 13:32:51 ******/
USE [PS_GameLog]
GO
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

IF @ActionType = '116'--Trade Item-remove item from originator
BEGIN
    WAITFOR DELAY '00:00:05'--Time delay to give the duper time to log out fully
    
    SELECT @CharLeave=Leave
    FROM PS_userdata.dbo.Users_Master
    WHERE UserUID=@UserUID

    IF @CharLeave=0
    BEGIN
        EXEC PS_GameData.dbo.usp_Save_Char_Item_Del_E @CharID=@CharID, @IDList=@Value1
    END
END

IF @ActionType = '164'--Trade Gold-remove gold from originator
BEGIN

    WAITFOR DELAY '00:00:05'--Time delay to give the duper time to log out fully

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
DECLARE
@DP INT

if(@ActionType = 114 AND @Value2 > 44141 AND @Value2 < 44148)
SET @DP =(
CASE 
 WHEN @Value2 = 44142 THEN 25
 WHEN @Value2 = 44143 THEN 50
 WHEN @Value2 = 44144 THEN 75
 WHEN @Value2 = 44145 THEN 100
 WHEN @Value2 = 44146 THEN 1000
 WHEN @Value2 = 44147 THEN 10000
ELSE @DP
END)

BEGIN
UPDATE PS_UserData.dbo.Users_Master SET Point = Point + @Value4 * @DP WHERE UserID = @UserID
END
