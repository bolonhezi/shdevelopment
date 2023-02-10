TRUNCATE TABLE GM_Stuff.dbo.StatPadder;
TRUNCATE TABLE PS_Chatlog.dbo.ChatLog;
DELETE FROM PS_GameLog.dbo.Death_Log WHERE ActionTime < DateAdd(HOUR, -240, GETDATE()) AND ActionTime <= GETDATE();

DECLARE
@CurrentRow INT = 1,
@MaxTable INT,
@KillerChardID INT,
@KillerUID INT,
@KillerIP VARCHAR(100),
@KillerID VARCHAR(100),
@KilledChardID INT,
@KilledUID INT,
@KilledIP VARCHAR(100),
@KilledID VARCHAR(100),
@ActionTime DATETIME,
@KillerName NVARCHAR(50),
@KilledName NVARCHAR(50),
@Map INT

DECLARE @RowID TABLE (RowID INT)

INSERT INTO @RowID SELECT RowID FROM PS_GameLog.dbo.Death_Log

SET @MaxTable = (SELECT MAX(RowID) FROM PS_GameLog.dbo.Death_Log)

WHILE @MaxTable >= @CurrentRow
BEGIN

	IF @CurrentRow IN(SELECT RowID FROM @RowID)
	BEGIN
		SET @KilledChardID = (SELECT CharID FROM PS_GameLog.dbo.Death_Log WHERE RowID = @CurrentRow)
		SET @KillerChardID = (SELECT KillerCharID FROM PS_GameLog.dbo.Death_Log WHERE RowID = @CurrentRow)
		SET @KilledUID = (SELECT UserUID FROM PS_GameData.dbo.Chars WHERE CharID = @KilledChardID)
		SET @KillerUID = (SELECT UserUID FROM PS_GameData.dbo.Chars WHERE CharID = @KillerChardID)
		SET @KilledIP = (SELECT UserIP FROM PS_UserData.dbo.Users_Master WHERE UserUID = @KilledUID)
		SET @KillerIP = (SELECT UserIP FROM PS_UserData.dbo.Users_Master WHERE UserUID = @KillerUID)
		SET @KillerName = (SELECT KillerCharName FROM PS_GameLog.dbo.Death_Log WHERE RowID = @CurrentRow)
		SET @KilledName = (SELECT CharName FROM PS_GameLog.dbo.Death_Log WHERE RowID = @CurrentRow)
		SET @ActionTime = (SELECT ActionTime FROM PS_GameLog.dbo.Death_Log WHERE RowID = @CurrentRow)
		SET @Map = (SELECT MapID FROM PS_GameLog.dbo.Death_Log WHERE RowID = @CurrentRow)
		SET @KillerID = (SELECT UserID FROM PS_UserData.dbo.Users_Master WHERE UserUID = @KillerUID)
		SET @KilledID = (SELECT UserID FROM PS_UserData.dbo.Users_Master WHERE UserUID = @KilledUID)
				
			IF @KilledUID != @KillerUID
				BEGIN
						IF @KillerIP = @KilledIP
						BEGIN
							INSERT INTO GM_Stuff.dbo.StatPadder VALUES (@KillerName, @KillerIP, @KillerID, @KilledName, @KilledIP, @KilledID, @ActionTime, @Map)
						END
					SET @KilledChardID = 0
					SET @KillerChardID = 0
					SET @KilledUID = 0
					SET @KillerUID = 0
					SET @KilledIP = 0
					SET @KillerName = 0
					SET @KilledName = 0
					SET @ActionTime = 0
				END
			ELSE
				BEGIN
					SET @KilledChardID = 0
					SET @KillerChardID = 0
					SET @KilledUID = 0
					SET @KillerUID = 0
					SET @KilledIP = 0
					SET @KillerName = 0
					SET @KilledName = 0
					SET @ActionTime = 0
				END
	END
	
SET @CurrentRow = @CurrentRow + 1
END