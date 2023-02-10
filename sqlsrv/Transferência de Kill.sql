USE [PS_GameData]
GO
/****** Object:  Trigger [dbo].[Reroll_Transfer]    Script Date: 01/15/2023 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ====================================================================================================
--			Escrito por Jorgi - Baseaso em Perfect_Orange_Stats do Euphoria Dev Team
-- ====================================================================================================

CREATE TRIGGER [dbo].[Kill_Transfer]
   ON  [dbo].[CharQuests]
   AFTER INSERT
AS 
BEGIN

	SET NOCOUNT ON;

    DECLARE @QuestReceberKills INT = (SELECT QuestID FROM INSERTED)
    
    IF @QuestReceberKills = 488 -- Quest receber kills
    BEGIN
		
		DECLARE @CharIDReceber INT = (SELECT CharID FROM INSERTED) -- Seleciona o ID do boneco que pegou a quest de receber kills
		DECLARE	@UserUID INT = (SELECT UserUID FROM Chars WHERE CharID = @CharIDReceber) -- Seleciona o usuário que tem o boneco na conta

        DECLARE @QuestEnviarKills INT = 487 -- Quest de enviar kills
        DECLARE @AccountChars TABLE (AccountChar INT) -- Criando tabela para alocar todos os bonecos na conta do usuário

        INSERT INTO @AccountChars SELECT CharID FROM Chars WHERE UserUID = @UserUID -- Seleciona todos os bonecos na conta do usuário

        DECLARE @CharIDEnviar INT = (SELECT TOP 1 CharID FROM CharQuests WHERE CharID in (SELECT AccountChar FROM @AccountChars) AND QuestID = @QuestEnviarKills) -- Seleciona boneco na conta do usuário que tem a quest de enviar as kills

        DECLARE @KillsEnviadas INT = (SELECT K1 FROM Chars WHERE CharID = @CharIDEnviar) -- Seleciona as kills do boneco que vai enviar
        DECLARE @MortesEnviadas INT = (SELECT K2 FROM Chars WHERE CharID = @CharIDEnviar) -- Seleciona as mortes do boneco que vai enviar
        DECLARE @TransferServiceItem INT = (SELECT ItemID FROM CharItems WHERE CharID = @CharIDReceber AND Bag = 1 AND Slot = 0) -- Seleciona o item do slot 1 da bag 1 do personagem que vai receber as kills
		
		IF (@TransferServiceItem = 78189 AND @CharIDEnviar IS NOT NULL) -- Checa se o boneco que vai receber as kills possuí o item do serviço e se existe um boneco com as quest de enviar
		
		--  Linha de comando acima checa se os itens são do mesmo tipo
		
		BEGIN
			
			-- Remove as kills do char com mais kill na conta
			UPDATE Chars
			SET K1 = 0, K2 = 0
			WHERE CharID = @CharIDEnviar
			
			-- Remove a recriação do item que está no primeiro slot do depósito 
			UPDATE Chars
			SET K1 = K1+@KillsEnviadas, K2 = K2+@MortesEnviadas
			WHERE CharID = @CharIDReceber
			
		DELETERUNE:
		-- Remove o item usado como serviço
		
			UPDATE CharItems
			SET Count -= 1
			WHERE CharID = @CharIDReceber AND Bag = 1 AND Slot = 0
			-- Removendo apenas 1 item em caso de ter mais de 1
			
			DELETE FROM CharItems
			WHERE CharID = @CharIDReceber AND Bag = 1 AND Slot = 0
			-- Se o jogador só tinha 1, então remove a stack completa da database
		END

		ELSE GOTO FAIL
		
    END
    
    FAIL:
	
	-- Em caso de falha
	
	DELETEQUEST:
	-- Remove a quest dos personagens
		DELETE FROM CharQuests
		WHERE CharID = @CharIDReceber AND QuestID = @QuestReceberKills
    	
        DELETE FROM CharQuests
		WHERE CharID = @CharIDEnviar AND QuestID = @QuestEnviarKills

END
