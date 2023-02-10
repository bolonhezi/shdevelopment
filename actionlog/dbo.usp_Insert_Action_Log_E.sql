USE [PS_GameLog]
GO
/****** Object:  StoredProcedure [dbo].[usp_Insert_Action_Log_E]    Script Date: 02/01/2023 20:04:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROC [dbo].[usp_Insert_Action_Log_E]

	@UserID VARCHAR(18),
	@UserUID INT,
	@CharID INT,
	@CharName NVARCHAR(50),
	@CharLevel TINYINT,
	@CharExp INT,
	@MapID SMALLINT,
	@PosX REAL,
	@PosY REAL,
	@PosZ REAL,
	@ActionTime DATETIME,
	@ActionType TINYINT,
	@Value1 BIGINT = NULL,
	@Value2 INT = NULL,
	@Value3 INT = NULL,
	@Value4 BIGINT = NULL,
	@Value5 INT = NULL,
	@Value6 INT = NULL,
	@Value7 INT = NULL,
	@Value8 INT = NULL,
	@Value9 INT = NULL,
	@Value10 INT = NULL,
	@Text1 VARCHAR(100) = '',
	@Text2 VARCHAR(100) = '',
	@Text3 VARCHAR(100) = '',
	@Text4 VARCHAR(100) = '',
	@Sql NVARCHAR(4000) = '',
	@yyyy VARCHAR(4) = '',
	@mm VARCHAR(2) = '',
	@dd VARCHAR(2) = '',
	@Bucket SMALLINT = -1

AS

DECLARE @Leave BIT

SET @yyyy = DATEPART(yyyy, @ActionTime)
SET @mm = DATEPART(mm, @ActionTime)
SET @dd = DATEPART(dd, @ActionTime)

IF(LEN(@mm) = 1)
BEGIN
	SET @mm = '0' + @mm
END

IF(LEN(@dd) = 1)
BEGIN
	SET @dd = '0' + @dd
END

-------------------- MORREU EM PVP --------------------
IF @ActionType = 104
BEGIN
	INSERT INTO Death_Log
	VALUES
		(@UserID, @UserUID, @CharID, @CharName, @Value1, @Text1, @MapID, @PosX, @PosY, @PosZ, @ActionTime)
END

-------------------- ENTROU NO GAME --------------------
ELSE IF @ActionType = 107
BEGIN
	UPDATE PS_GameData.dbo.Chars SET LoginStatus = 1 WHERE PS_GameData.dbo.Chars.CharID=@CharID
	INSERT INTO Char_Enter_Leave_Log
		(UserID, UserUID, CharID, CharName, ActionType, ActionTime, UserIP)
	VALUES
		(@UserID, @UserUID, @CharID, @CharName, 'Enter', @ActionTime, @Text1)
END

-------------------- SAIU DO GAME --------------------
ELSE IF @ActionType = 108
BEGIN
	UPDATE PS_GameData.dbo.Chars SET LoginStatus = 0 WHERE PS_GameData.dbo.Chars.CharID=@CharID
	INSERT INTO Char_Enter_Leave_Log
		(UserID, UserUID, CharID, CharName, ActionType, ActionTime)
	VALUES
		(@UserID, @UserUID, @CharID, @CharName, 'Leave', @ActionTime)
END

-------------------- VENDEU ITEM NO NPC --------------------
ELSE IF @ActionType = 114
BEGIN

	DECLARE
	@ItemID INT
	SET @ItemID = @Value2

	IF (@ItemID = 78185) -- CARTÃO DE 1R$
	BEGIN

		UPDATE PS_UserData.dbo.Users_Master 
		SET Point = (Point + @Value4 * 1) 
		WHERE UserUID = @UserUID

	END

	IF (@ItemID = 78186) -- CARTÃO DE 10R$
	BEGIN

		UPDATE PS_UserData.dbo.Users_Master 
		SET Point = (Point + @Value4 * 10) 
		WHERE UserUID = @UserUID

	END

	IF (@ItemID = 78187) -- CARTÃO DE 20R$
	BEGIN

		UPDATE PS_UserData.dbo.Users_Master 
		SET Point = (Point + @Value4 * 20) 
		WHERE UserUID = @UserUID

	END

	IF (@ItemID = 78183) -- CARTÃO DE 50R$
	BEGIN

		UPDATE PS_UserData.dbo.Users_Master 
		SET Point = (Point + @Value4 * 50) 
		WHERE UserUID = @UserUID

	END
END

-------------------- PASSOU UM ITEM PARA OUTRO PLAYER --------------------
ELSE IF @ActionType = 116
BEGIN
	WAITFOR DELAY '00:00:05'
	-- wait 5 seconds

	SET @Leave = (SELECT Leave
	FROM PS_UserData.dbo.Users_Master
	WHERE UserUID = @UserUID)
	-- if user is offline only 5 seconds after the transaction was completed,
	-- then they definitely duped, since a proper logout takes 10 seconds
	IF @Leave = 0
	BEGIN
		-- delete the item from the seller's inventory		
		DELETE FROM PS_GameData.dbo.CharItems
		WHERE ItemUID = @Value1 AND CharID = @CharID
	END

	-- trading untradeable items
	IF EXISTS (SELECT ItemID
	FROM PS_GameDefs.dbo.Items
	WHERE ItemID = @Value2 AND ReqOg = 1)
	BEGIN
		INSERT INTO Illegal_Transaction_Log VALUES (@ActionTime, @UserID, @UserUID, @CharID, @CharName, @Value3, @Text2, @Value1, @Value2, @Text1, @Value4)
	END

	INSERT INTO Transaction_Log (ActionTime, UserID, UserUID, CharID, CharName, CharID_2, CharName_2, ItemUID, ItemID, ItemName, ItemCount) VALUES (@ActionTime, @UserID, @UserUID, @CharID, @CharName, @Value3, @Text2, @Value1, @Value2, @Text1, @Value4)
END

-------------------- BOSS MORREU --------------------
ELSE IF @ActionType = 173 AND @Text2 = 'death'
BEGIN
	SET @UserUID = (SELECT TOP 1 UserUID FROM PS_GameData.dbo.Chars WHERE CharName = @Text3)
	INSERT INTO Boss_Death_Log VALUES (@Value3, @Text1, @UserUID, @Text3, @MapID, @PosX, @PosY, @PosZ, @ActionTime)
END

-------------------- GM USOU COMANDO --------------------
ELSE IF @ActionType = 180
BEGIN
	INSERT INTO Command_Log (UserID, UserUID, CharID, CharName, MapID, PosX, PosY, PosZ, ActionTime, Text1, Text2, Text3) VALUES (@UserID, @UserUID, @CharID, @CharName, @MapID, @PosX, @PosY, @PosZ, @ActionTime, @Text1, @Text2, @Text3)
END