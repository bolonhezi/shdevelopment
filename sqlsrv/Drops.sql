/*** Drops ***/
/*Limpas os drops de todos os mobs primeiro*/
UPDATE PS_GameDefs.dbo.MobItems
SET Grade = 0, DropRate = 0
/* Inicia os drops do server */