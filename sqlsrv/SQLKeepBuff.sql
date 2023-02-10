/* SQL para manter buffs depois que o char morre */
UPDATE PS_GameDefs.dbo.Skills
SET FixRange = 2
WHERE SkillID in (
/*Adicionar todos IDs das skills de buffs aqui*/
30, 31, 44, 46, 47, 59, 111,
112, 116, 117, 120, 121, 123,
132, 133, 139, 141, 188, 189,
190, 191, 304, 316, 317, 318,
319
)