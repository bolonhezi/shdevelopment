USE [PS_GameData]
GO
/****** Object:  Trigger [dbo].[Base_Perfect_Orange_Stats_Free]    Script Date: 01/21/2023 01:08:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ===============================================================================-- 
--			Developed by Jorgi Bolonhezi, Based on POS - Euphoria Dev Team        -- 
-- ===============================================================================--  

CREATE TRIGGER [dbo].[Base_Perfect_Orange_Stats_Free]
   ON  [dbo].[CharQuests]
   AFTER INSERT
AS 
BEGIN

	SET NOCOUNT ON;

    DECLARE @QuestID INT = (SELECT QuestID FROM INSERTED)
    
    IF @QuestID = 489 -- The Free Perfect Orange Stats QuestID
    BEGIN
		
		DECLARE @CharID INT = (SELECT CharID FROM INSERTED) -- Char ID
		DECLARE	@UserUID INT = (SELECT UserUID FROM Chars WHERE CharID = @CharID)
		DECLARE @TokenID INT =  (SELECT ItemID FROM UserStoredItems WHERE UserUID = @UserUID AND Slot = 0) -- Reroll Token ID

		DECLARE @GearTypes TABLE (GearTypes TINYINT) -- Gears, Capes and Shields
		DECLARE @WeaponTypes TABLE (WeaponTypes TINYINT) -- Weapons
		DECLARE @AccessoriesTypes TABLE (AccessoriesTypes TINYINT) -- Acessories
		
		INSERT INTO @GearTypes VALUES (16),(17),(18),(19),(20),(21),(31),(32),(33),(34),(35),(36) -- Gears, Capes and Shields
		INSERT INTO @WeaponTypes VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12),(13),(14),(15) -- Weapons
		INSERT INTO @AccessoriesTypes VALUES (22),(23),(40) -- Acessories

		--------------------------------------------------------------------------------------------------------------------------------
		-- Gears HP STR DEX
		IF (@TokenID = 101001)
		BEGIN
		-- Gears and Shields
		UPDATE UserStoredItems
		SET Craftname = '15150000000015000000'
		WHERE Type IN (SELECT GearTypes FROM @GearTypes) AND UserUID = @UserUID
		END

		-- Gears HP STR REC
		ELSE IF (@TokenID = 101002)
		BEGIN
		-- Gears and Shields
		UPDATE UserStoredItems
		SET Craftname = '15001500000015000000'
		WHERE Type IN (SELECT GearTypes FROM @GearTypes) AND UserUID = @UserUID
		END

		-- Gears HP STR LUC
		ELSE IF (@TokenID = 101003)
		BEGIN
		-- Gears and Shields
		UPDATE UserStoredItems
		SET Craftname = '15000000001515000000'
		WHERE Type IN (SELECT GearTypes FROM @GearTypes) AND UserUID = @UserUID
		END

	    -- Gears HP DEX LUC
		ELSE IF (@TokenID = 101004)
		BEGIN
		-- Gears and Shields
		UPDATE UserStoredItems
		SET Craftname = '00150000001515000000'
		WHERE Type IN (SELECT GearTypes FROM @GearTypes) AND UserUID = @UserUID
		END

		-- Gears HP INT LUC
		ELSE IF (@TokenID = 101005)
		BEGIN
		-- Gears and Shields
		UPDATE UserStoredItems
		SET Craftname = '00000015001515000000'
		WHERE Type IN (SELECT GearTypes FROM @GearTypes) AND UserUID = @UserUID
		END

		-- Gears HP INT REC
		ELSE IF (@TokenID = 101006)
		BEGIN
		-- Gears and Shields
		UPDATE UserStoredItems
		SET Craftname = '00001515000015000000'
		WHERE Type IN (SELECT GearTypes FROM @GearTypes) AND UserUID = @UserUID
		END

		-- Gears HP INT WIS
		ELSE IF (@TokenID = 101007)
		BEGIN
		-- Gears and Shields
		UPDATE UserStoredItems
		SET Craftname = '00000015150015000000'
		WHERE Type IN (SELECT GearTypes FROM @GearTypes) AND UserUID = @UserUID
		END

		-- Gears HP REC WIS
		ELSE IF (@TokenID = 101008)
		BEGIN
		-- Gears and Shields
		UPDATE UserStoredItems
		SET Craftname = '00001500001515000000'
		WHERE Type IN (SELECT GearTypes FROM @GearTypes) AND UserUID = @UserUID
		END
		--------------------------------------------------------------------------------------------------------------------------------

		--------------------------------------------------------------------------------------------------------------------------------
		-- Weapons STR DEX REC
		ELSE IF (@TokenID = 101009)
		BEGIN
		-- Weapons
		UPDATE UserStoredItems
		SET Craftname = '20202000000000000000'
		WHERE Type IN (SELECT WeaponTypes FROM @WeaponTypes) AND UserUID = @UserUID
		END

		-- Weapons STR DEX LUC
		ELSE IF (@TokenID = 101010)
		BEGIN
		-- Weapons
		UPDATE UserStoredItems
		SET Craftname = '20200000002000000000'
		WHERE Type IN (SELECT WeaponTypes FROM @WeaponTypes) AND UserUID = @UserUID
		END

		-- Weapons REC INT LUC
		ELSE IF (@TokenID = 101011)
		BEGIN
		-- Weapons
		UPDATE UserStoredItems
		SET Craftname = '00002020002000000000'
		WHERE Type IN (SELECT WeaponTypes FROM @WeaponTypes) AND UserUID = @UserUID
		END

		-- Weapons REC INT WIS
		ELSE IF (@TokenID = 101012)
		BEGIN
		-- Weapons
		UPDATE UserStoredItems
		SET Craftname = '00002020200000000000'
		WHERE Type IN (SELECT WeaponTypes FROM @WeaponTypes) AND UserUID = @UserUID
		END
		--------------------------------------------------------------------------------------------------------------------------------

		--------------------------------------------------------------------------------------------------------------------------------
		-- Accessories All Stats
		ELSE IF (@TokenID = 101013)
		BEGIN
		-- Accessories
		UPDATE UserStoredItems
		SET Craftname = '10101010101000000000'
		WHERE Type IN (SELECT AccessoriesTypes FROM @AccessoriesTypes) AND UserUID = @UserUID
		END
		--------------------------------------------------------------------------------------------------------------------------------

		-- Guide Str, Dex, Rec, Int, Wis, Luc, HP, MP, SP, Lapisia

		IF(@TokenID = 101001 OR @TokenID = 101002 OR @TokenID = 101003 OR @TokenID = 101004 OR @TokenID = 101005 OR 
		@TokenID = 101006 OR @TokenID = 101007 OR @TokenID = 101008 OR @TokenID = 101009 OR @TokenID = 101010 OR 
		@TokenID = 101011 OR @TokenID = 101012 OR @TokenID = 101013)
		BEGIN
		DELETERUNE:
		-- This label removes the token.
		
			UPDATE UserStoredItems
			SET Count -= 1
			WHERE UserUID = @UserUID AND Slot = 0
			-- Removendo apenas 1 item em caso de ter mais de 1
			
			DELETE FROM UserStoredItems
			WHERE UserUID = @UserUID AND Slot = 0 AND Count = 0
			-- Se o jogador só tinha 1, então remove a stack completa da database
		END
    END
    
    FAIL:
    -- This label is called from above a couple of times,
    -- in case the recreation requirements aren't met.		
	DELETEQUEST:
	-- This label deletes the recreation quest.
		DELETE FROM CharQuests
		WHERE CharID = @CharID AND QuestID = @QuestID

END
