

DECLARE @Stat_NM tinyint, @Stat_HM tinyint, @Stat_UM tinyint;
DECLARE @Skill_NM tinyint, @Skill_HM tinyint, @Skill_UM tinyint;

    -- set your custom Status Points gained per level here
SET @Stat_NM = 5;
SET @Stat_HM = 7;
SET @Stat_UM = 9;
    -- set your custom Skill Points gained per level here
SET @Skill_NM = 3;
SET @Skill_HM = 4;
SET @Skill_UM = 10;


/*************************************************
 *    reset status and skill points for AoL & UoF  *
 *************************************************/

    -- status/skill points are reset by Family (race); base status points are class and family specific
DECLARE @i tinyint;
SET @i=0;

WHILE @i<=3
begin
    if @i=0        -- Human
    begin
        exec sp_executesql N'UPDATE PS_GameData.dbo.Chars SET [Str]=14, Dex=12, Rec=9, [Int]=8, Wis=7, Luc=15 
                            FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
                            ON C.UserUID = UM.UserUID AND UM.[Status] NOT IN (16,32,48,64,80) AND C.[Level]>1 AND C.Del=0
                            WHERE C.Family=@i AND C.Job=0',N'@i tinyint',@i
        exec sp_executesql N'UPDATE PS_GameData.dbo.Chars SET [Str]=10, Dex=9, Rec=12, [Int]=10, Wis=10, Luc=14 
                            FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
                            ON C.UserUID = UM.UserUID AND UM.[Status] NOT IN (16,32,48,64,80) AND C.[Level]>1 AND C.Del=0
                            WHERE C.Family=@i AND C.Job=1',N'@i tinyint',@i
        exec sp_executesql N'UPDATE PS_GameData.dbo.Chars SET [Str]=8, Dex=9, Rec=10, [Int]=12, Wis=14, Luc=12 
                            FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
                            ON C.UserUID = UM.UserUID AND UM.[Status] NOT IN (16,32,48,64,80) AND C.[Level]>1 AND C.Del=0
                            WHERE C.Family=@i AND C.Job=5',N'@i tinyint',@i
    end

    if @i=1        -- Elf
    begin
        exec sp_executesql N'UPDATE PS_GameData.dbo.Chars SET [Str]=10, Dex=19, Rec=9, [Int]=7, Wis=8, Luc=12 
                            FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
                            ON C.UserUID = UM.UserUID AND UM.[Status] NOT IN (16,32,48,64,80) AND C.[Level]>1 AND C.Del=0
                            WHERE C.Family=@i AND C.Job=2',N'@i tinyint',@i
        exec sp_executesql N'UPDATE PS_GameData.dbo.Chars SET [Str]=11, Dex=14, Rec=10, [Int]=7, Wis=10, Luc=13 
                            FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
                            ON C.UserUID = UM.UserUID AND UM.[Status] NOT IN (16,32,48,64,80) AND C.[Level]>1 AND C.Del=0
                            WHERE C.Family=@i AND C.Job=3',N'@i tinyint',@i
        exec sp_executesql N'UPDATE PS_GameData.dbo.Chars SET [Str]=7, Dex=13, Rec=9, [Int]=15, Wis=12, Luc=9 
                            FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
                            ON C.UserUID = UM.UserUID AND UM.[Status] NOT IN (16,32,48,64,80) AND C.[Level]>1 AND C.Del=0
                            WHERE C.Family=@i AND C.Job=4',N'@i tinyint',@i
    end

    if @i=2        -- Vail
    begin
        exec sp_executesql N'UPDATE PS_GameData.dbo.Chars SET [Str]=10, Dex=15, Rec=9, [Int]=9, Wis=10, Luc=12 
                            FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
                            ON C.UserUID = UM.UserUID AND UM.[Status] NOT IN (16,32,48,64,80) AND C.[Level]>1 AND C.Del=0
                            WHERE C.Family=@i AND C.Job=2',N'@i tinyint',@i
        exec sp_executesql N'UPDATE PS_GameData.dbo.Chars SET [Str]=7, Dex=9, Rec=9, [Int]=17, Wis=14, Luc=9 
                            FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
                            ON C.UserUID = UM.UserUID AND UM.[Status] NOT IN (16,32,48,64,80) AND C.[Level]>1 AND C.Del=0
                            WHERE C.Family=@i AND C.Job=4',N'@i tinyint',@i
        exec sp_executesql N'UPDATE PS_GameData.dbo.Chars SET [Str]=8, Dex=9, Rec=10, [Int]=14, Wis=16, Luc=8 
                            FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
                            ON C.UserUID = UM.UserUID AND UM.[Status] NOT IN (16,32,48,64,80) AND C.[Level]>1 AND C.Del=0
                            WHERE C.Family=@i AND C.Job=5',N'@i tinyint',@i
    end

    if @i=3        -- Nordein
    begin
        exec sp_executesql N'UPDATE PS_GameData.dbo.Chars SET [Str]=16, Dex=12, Rec=11, [Int]=8, Wis=7, Luc=11 
                            FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
                            ON C.UserUID = UM.UserUID AND UM.[Status] NOT IN (16,32,48,64,80) AND C.[Level]>1 AND C.Del=0
                            WHERE C.Family=@i AND C.Job=0',N'@i tinyint',@i
        exec sp_executesql N'UPDATE PS_GameData.dbo.Chars SET [Str]=12, Dex=9, Rec=14, [Int]=10, Wis=10, Luc=10 
                            FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
                            ON C.UserUID = UM.UserUID AND UM.[Status] NOT IN (16,32,48,64,80) AND C.[Level]>1 AND C.Del=0
                            WHERE C.Family=@i AND C.Job=1',N'@i tinyint',@i
        exec sp_executesql N'UPDATE PS_GameData.dbo.Chars SET [Str]=13, Dex=10, Rec=12, [Int]=7, Wis=10, Luc=13 
                            FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
                            ON C.UserUID = UM.UserUID AND UM.[Status] NOT IN (16,32,48,64,80) AND C.[Level]>1 AND C.Del=0
                            WHERE C.Family=@i AND C.Job=3',N'@i tinyint',@i
    end
    
    SET @i = @i + 1;
end


/**************************************************************
 *  Add class specific bonus status points gained each level  *
 **************************************************************/

UPDATE PS_GameData.dbo.Chars SET [Str] = (
    CASE 
        WHEN Family=0 AND Job=0 THEN [STR] + ([Level]-1)
        WHEN Family=3 AND Job=0 THEN [STR] + ([Level]-1) ELSE [Str] END),
    Rec = (
    CASE
        WHEN Family=0 AND Job=1 THEN Rec + ([Level]-1)
        WHEN Family=3 AND Job=1 THEN Rec + ([Level]-1) ELSE Rec END),
    Dex = (
    CASE
        WHEN Family=1 AND Job=2 THEN Dex + ([Level]-1)
        WHEN Family=2 AND Job=2 THEN Dex + ([Level]-1) ELSE Dex END),
    Luc = (
    CASE
        WHEN Family=1 AND Job=3 THEN Luc + ([Level]-1)
        WHEN Family=3 AND Job=3 THEN Luc + ([Level]-1) ELSE Luc END),
    [Int] = (
    CASE
        WHEN Family=1 AND Job=4 THEN [Int] + ([Level]-1)
        WHEN Family=2 AND Job=4 THEN [Int] + ([Level]-1) ELSE [Int] END),
    Wis = (
    CASE
        WHEN Family=0 AND Job=5 THEN Wis + ([Level]-1)
        WHEN Family=2 AND Job=5 THEN Wis + ([Level]-1) ELSE Wis END)
FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
ON C.UserUID = UM.UserUID AND UM.[Status] NOT IN (16,32,48,64,80) AND C.[Level]>1 AND C.Del=0


/***************************************************************
 *  Now, set Skill & Status Points according to players level  *
 ***************************************************************/

    -- these are set by multiplying skill/status points by (Level-1)
    -- (Level-1) is because you start at lv1 and gain 59 levels to reach lv60
UPDATE PS_GameData.dbo.Chars SET StatPoint=([Level]-1)*(
        CASE Grow
        WHEN 0 THEN @Stat_NM
        WHEN 1 THEN @Stat_NM
        WHEN 2 THEN @Stat_HM
        WHEN 3 THEN @Stat_UM END), 
    SkillPoint = ([Level]-1)*(
        CASE Grow
        WHEN 0 THEN @Skill_NM
        WHEN 1 THEN @Skill_NM
        WHEN 2 THEN @Skill_HM
        WHEN 3 THEN @Skill_UM END)
FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
ON C.UserUID = UM.UserUID AND UM.[Status] NOT IN (16,32,48,64,80) AND C.[Level]>1 AND C.Del=0

/*
 * Finally, delete player's skills, quick slots and set PvP Kill & Death Level to 0
 */
    -- set Kill/Dead Level to zero; these reflect the bonus points you gain per Rank
UPDATE [PS_GameData].[dbo].[Chars] 
    SET [KillLevel]=0 ,[DeadLevel]=0
    FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
    ON C.UserUID = UM.UserUID AND UM.[Status] NOT IN (16,32,48,64,80) AND C.Del=0;

    -- delete all skills
DELETE FROM [PS_GameData].[dbo].[CharSkills]
    FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
    ON C.UserUID = UM.UserUID AND UM.[Status] NOT IN (16,32,48,64,80) AND C.Del=0;

    -- delete all Quick Slots
DELETE FROM [PS_GameData].[dbo].[CharQuickSlots]
    FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
    ON C.UserUID = UM.UserUID AND UM.[Status] NOT IN (16,32,48,64,80) AND C.Del=0;