USE [GM_Stuff]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER BAN_FARM_KILL
ON [GM_Stuff].[dbo].[StatPadder]
FOR INSERT AS

DECLARE
@KillerID VARCHAR = (SELECT KillerID FROM INSERTED),
@DeadID VARCHAR = (SELECT DeadID FROM INSERTED),
@DeadToon VARCHAR = (SELECT DeadToon FROM INSERTED),
@Times INT

BEGIN
    SET @Times = (SELECT COUNT(KillerID)
    FROM GM_Stuff.dbo.StatPadder
    WHERE KillerID = @KillerID)
    IF(@Times>=16)
        DECLARE @DeadToonK1 INT = (SELECT K1 FROM PS_GameData.dbo.Chars WHERE CharName = @DeadToon),
                @DeadToonK2 INT = (SELECT K2 FROM PS_GameData.dbo.Chars WHERE CharName = @DeadToon)
                IF(@DeadToonK1/40 <= @DeadToonK2)
                    UPDATE PS_UserData.dbo.Users_Master SET Status = -5 WHERE UserID = @KillerID
                    UPDATE PS_UserData.dbo.Users_Master SET Status = -5 WHERE UserID = @DeadID
END