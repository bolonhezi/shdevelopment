/* Remove os links dos lapis de capacete lv2 do inventário e itens equipados*/
UPDATE PS_GameData.dbo.CharItems
SET Gem1 = 0
WHERE Gem1=118 OR Gem1=119 OR Gem1=120 OR Gem1=121 OR Gem1=122 OR Gem1=123

UPDATE PS_GameData.dbo.CharItems
SET Gem2 = 0
WHERE Gem2=118 OR Gem2=119 OR Gem2=120 OR Gem2=121 OR Gem2=122 OR Gem2=123

UPDATE PS_GameData.dbo.CharItems
SET Gem3 = 0
WHERE Gem3=118 OR Gem3=119 OR Gem3=120 OR Gem3=121 OR Gem3=122 OR Gem3=123

UPDATE PS_GameData.dbo.CharItems
SET Gem4 = 0
WHERE Gem4=118 OR Gem4=119 OR Gem4=120 OR Gem4=121 OR Gem4=122 OR Gem4=123

UPDATE PS_GameData.dbo.CharItems
SET Gem5 = 0
WHERE Gem5=118 OR Gem5=119 OR Gem5=120 OR Gem5=121 OR Gem5=122 OR Gem5=123

UPDATE PS_GameData.dbo.CharItems
SET Gem6 = 0
WHERE Gem6=118 OR Gem6=119 OR Gem6=120 OR Gem6=121 OR Gem6=122 OR Gem6=123

/* Remove os links dos lapis de capacete lv2 dos itens no depósito*/
UPDATE PS_GameData.dbo.UserStoredItems
SET Gem1 = 0
WHERE Gem1=118 OR Gem1=119 OR Gem1=120 OR Gem1=121 OR Gem1=122 OR Gem1=123

UPDATE PS_GameData.dbo.UserStoredItems
SET Gem2 = 0
WHERE Gem2=118 OR Gem2=119 OR Gem2=120 OR Gem2=121 OR Gem2=122 OR Gem2=123

UPDATE PS_GameData.dbo.UserStoredItems
SET Gem3 = 0
WHERE Gem3=118 OR Gem3=119 OR Gem3=120 OR Gem3=121 OR Gem3=122 OR Gem3=123

UPDATE PS_GameData.dbo.UserStoredItems
SET Gem4 = 0
WHERE Gem4=118 OR Gem4=119 OR Gem4=120 OR Gem4=121 OR Gem4=122 OR Gem4=123

UPDATE PS_GameData.dbo.UserStoredItems
SET Gem5 = 0
WHERE Gem5=118 OR Gem5=119 OR Gem5=120 OR Gem5=121 OR Gem5=122 OR Gem5=123

UPDATE PS_GameData.dbo.UserStoredItems
SET Gem6 = 0
WHERE Gem6=118 OR Gem6=119 OR Gem6=120 OR Gem6=121 OR Gem6=122 OR Gem6=123

/*Transforma os lapis de capacete lv2 do inventário em maça de ouro*/
UPDATE PS_GameData.dbo.CharItems
SET Type = 25, TypeID = 7
WHERE Type = 30 and TypeID in (118,119,120,121,122,123)

/*Transforma os lapis de capacete lv2 do depósito em maça de ouro*/
UPDATE PS_GameData.dbo.UserStoredItems
SET Type = 25, TypeID = 7
WHERE Type = 30 and TypeID in (118,119,120,121,122,123)