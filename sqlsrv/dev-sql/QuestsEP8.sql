/*script para atualização de drops com itens da quest ep 8*/
DECLARE @MobsParte1 TABLE (ID INT IDENTITY(1,1), MobID INT)
/*adicionar level aqui*/
INSERT INTO @MobsParte1 SELECT MobID FROM PS_GameDefs.dbo.Mobs WHERE Level BETWEEN 1 AND 5
DECLARE @MaxRowParte1 INT = (SELECT MAX(ID) FROM @MobsParte1), @RowParte1 INT = 1
/*Atualiza drop*/
WHILE (@RowParte1 <= @MaxRowParte1)
BEGIN
    DECLARE @MobIDParte1 INT = (SELECT MobID FROM @MobsParte1 WHERE ID = @RowParte1)
    UPDATE PS_GameDefs.dbo.MobItems
    /*adicionar grade e droprate aqui*/
    SET Grade = 0, DropRate = 5
    WHERE MobID = @MobIDParte1 AND ItemOrder = 5 AND Grade = 0
    SET @RowParte1 = @RowParte1 + 1
END