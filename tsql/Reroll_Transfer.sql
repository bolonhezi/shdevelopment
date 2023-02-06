USE [PS_GameData]
GO
/****** Object:  Trigger [dbo].[Reroll_Transfer]    Script Date: 01/15/2023 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ===============================================================================-- 
--			Developed by Jorgi Bolonhezi, Based on POS - Euphoria Dev Team        -- 
-- ===============================================================================-- 

CREATE TRIGGER [dbo].[Reroll_Transfer]
   ON  [dbo].[CharQuests]
   AFTER INSERT
AS 
BEGIN

	SET NOCOUNT ON;

    DECLARE @QuestID INT = (SELECT QuestID FROM INSERTED)
    
    IF @QuestID = 486 -- Quest da transferência de reroll
    BEGIN
		
		DECLARE @CharID INT = (SELECT CharID FROM INSERTED)
		DECLARE	@UserUID INT = (SELECT UserUID FROM Chars WHERE CharID = @CharID)
	
		DECLARE	@ItemType1 TINYINT, @ItemType2 TINYINT, @TransferServiceItem INT, @CraftName1 VARCHAR(20), @CraftName2 VARCHAR(20)
	
		DECLARE @GearTypes TABLE (GearTypes TINYINT) -- Armaduras e escudos
		DECLARE @CapesTypes TABLE (CapesTypes TINYINT) -- Capas
		DECLARE @AccTypes TABLE (AccTypes TINYINT) -- Accessórios
		DECLARE @WeaponTypes TABLE (WeaponTypes TINYINT) -- Armas
		
		-- Declarando váriaveis manualmente em vez de buscar na db, assim garantimos um menor uso do processador
		
		SET @ItemType1 = (SELECT Type FROM UserStoredItems WHERE UserUID = @UserUID AND Slot = 0)
		SET @CraftName1 = (SELECT Craftname FROM UserStoredItems WHERE UserUID = @UserUID AND Slot = 0)
		SET @ItemType2 = (SELECT Type FROM UserStoredItems WHERE UserUID = @UserUID AND Slot = 1)
		SET @CraftName2 = (SELECT Craftname FROM UserStoredItems WHERE UserUID = @UserUID AND Slot = 1)
		SET @TransferServiceItem = (SELECT ItemID FROM UserStoredItems WHERE UserUID = @UserUID AND Slot = 2)
		
		INSERT INTO @GearTypes VALUES (16),(17),(18),(19),(20),(21),(31),(32),(33),(34),(35),(36)
		-- Tipos das armaduras
		
		INSERT INTO @CapesTypes VALUES (24), (39)
		-- Tipos de capas
		
		INSERT INTO @AccTypes VALUES (22),(23),(40)
		-- Tipos de acessórios
		
		INSERT INTO @WeaponTypes VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12),(13),(14),(15)
		-- Tipos de armas
		
		IF (
			(@ItemType1 IN (SELECT GearTypes FROM @GearTypes) AND @ItemType2 IN (SELECT GearTypes FROM @GearTypes) AND @TransferServiceItem = 78188) OR 
			(@ItemType1 IN (SELECT CapesTypes FROM @CapesTypes) AND @ItemType2 IN (SELECT CapesTypes FROM @CapesTypes) AND @TransferServiceItem = 78188) OR 
			(@ItemType1 IN (SELECT AccTypes FROM @AccTypes) AND @ItemType2 IN (SELECT AccTypes FROM @AccTypes) AND @TransferServiceItem = 78188)  OR 
			(@ItemType1 IN (SELECT WeaponTypes FROM @WeaponTypes) AND @ItemType2 IN (SELECT WeaponTypes FROM @WeaponTypes) AND @TransferServiceItem = 78188)
		)
		
		--  Linha de comando acima checa se os itens são do mesmo tipo
		
		BEGIN
			
			-- Envia a recriação do item que está no primeiro slot do depósito para o item que está no segundo slot do depósito
			UPDATE UserStoredItems
			SET Craftname = @CraftName1
			WHERE UserUID = @UserUID AND Slot = 1
			
			-- Remove a recriação do item que está no primeiro slot do depósito 
			UPDATE UserStoredItems
			SET Craftname = '00000000000000000000'
			WHERE UserUID = @UserUID AND Slot = 0
			
		DELETERUNE:
		-- Remove o item usado como serviço
		
			UPDATE UserStoredItems
			SET Count -= 1
			WHERE UserUID = @UserUID AND Slot = 2
			-- Removendo apenas 1 item em caso de ter mais de 1
			
			DELETE FROM UserStoredItems
			WHERE UserUID = @UserUID AND Slot = 2 AND Count = 0
			-- Se o jogador só tinha 1, então remove a stack completa da database
		END
		
    END
    
    FAIL:
	
	-- Em caso de falha
	
	DELETEQUEST:
	-- Remove a quest do personagem
		DELETE FROM CharQuests
		WHERE CharID = @CharID AND QuestID = @QuestID

END
