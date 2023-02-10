CREATE DATABASE GM_Stuff
GO
USE [GM_Stuff]
GO
/****** Object:  Table [dbo].[Log]    Script Date: 02/07/2012 19:07:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Log](
	[StaffID] [varchar](max) NULL,
	[StaffIP] [varchar](max) NULL,
	[Account] [varchar](max) NULL,
	[actiondef] [varchar](max) NULL,
	[date] [datetime] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[StatPadder]    Script Date: 02/07/2012 19:07:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[StatPadder](
	[KillerToon] [varchar](max) NULL,
	[KillerIP] [varchar](max) NULL,
	[KillerID] [varchar](max) NULL,
	[DeadToon] [varchar](max) NULL,
	[DeadIP] [varchar](max) NULL,
	[DeadID] [varchar](max) NULL,
	[Date] [datetime] NULL,
	[Map] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[staff]    Script Date: 02/07/2012 19:07:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[staff](
	[UserID] [varchar](50) NULL,
	[Pw] [varchar](50) NULL,
	[Status] [varchar](50) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RandomLottoWinners]    Script Date: 02/07/2012 19:07:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RandomLottoWinners](
	[CharName] [varchar](max) NULL,
	[StaffName] [varchar](max) NULL,
	[ExecutionDate] [datetime] NULL,
	[StaffIP] [varchar](max) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[InGameTime]    Script Date: 02/07/2012 19:07:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[InGameTime](
	[CharName] [varchar](50) NULL,
	[InTime] [datetime] NULL,
	[OutTime] [datetime] NULL,
	[TotalTime] [datetime] NULL,
	[YYYY] [int] NULL,
	[MM] [int] NULL,
	[DD] [int] NULL,
	[HH] [int] NULL,
	[MI] [int] NULL,
	[SS] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BannedIP]    Script Date: 02/07/2012 19:07:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BannedIP](
	[UserID] [varchar](max) NULL,
	[BanDate] [datetime] NULL,
	[IP1] [varchar](50) NULL,
	[StaffID] [varchar](50) NULL,
	[StaffIP] [varchar](50) NULL,
	[LogAtempt] [varchar](max) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BannedAccounts]    Script Date: 02/07/2012 19:07:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BannedAccounts](
	[UserID] [varchar](50) NULL,
	[Status] [varchar](max) NULL,
	[Success] [varchar](50) NULL,
	[TimeActivated] [datetime] NULL,
	[TimeReleased] [datetime] NULL,
	[StaffID] [varchar](50) NULL,
	[StaffIP] [varchar](50) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[AdminAccountDeleatAndSwipe]    Script Date: 02/07/2012 19:07:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AdminAccountDeleatAndSwipe]

@UserID varchar(16)

AS
SET NOCOUNT ON
UPDATE PS_UserData.dbo.Users_Master
SET [Admin]= 'False', [AdminLevel]=0,[Status]=0,UserType='1', Point='0'
WHERE UserID= @UserID
-- set level 1 Kill/Dead Level to zero;and k1/k2/k3/k4 to 0 and spawn all in AH 
UPDATE [PS_GameData].[dbo].[Chars] 
SET[Level]=1,[KillLevel]=0,[DeadLevel]=0,K1=0,K2=0,K3=0,K4=0,[EXP]=0,StatPoint=0,SkillPoint=5,
[Money]=0
FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
ON C.UserUID = UM.UserUID AND UM.[Status] NOT IN (16,32,48,64,80) where C.UserID = @UserID

--Update Players location
UPDATE PS_GameData.dbo.Chars SET [Map]=
   (CASE 
        WHEN Family=0 AND Job=0 THEN 1
        WHEN Family=1 AND Job=0 THEN 1 
        WHEN Family=2 AND Job=1 THEN 2 
        WHEN Family=3 AND Job=1 THEN 2
 ELSE [Map]
END)
FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
ON C.UserUID = UM.UserUID AND UM.[Status] NOT IN (16,32,48,64,80)where C.UserID = @UserID
 
UPDATE PS_GameData.dbo.Chars SET[PosX]=
    (CASE 
        WHEN Family=0 AND Job=0 THEN 542
        WHEN Family=1 AND Job=0 THEN 1487
        WHEN Family=2 AND Job=1 THEN  1839
        WHEN Family=3 AND Job=1 THEN  165
 ELSE PosX
END)
FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
ON C.UserUID = UM.UserUID AND UM.[Status] NOT IN (16,32,48,64,80)where C.UserID = @UserID

UPDATE PS_GameData.dbo.Chars SET[PosY]=
    (CASE 
        WHEN Family=0 AND Job=0 THEN  79
        WHEN Family=1 AND Job=0 THEN  43
        WHEN Family=2 AND Job=1 THEN  130
        WHEN Family=3 AND Job=1 THEN  119
 ELSE PosY
END)
FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
ON C.UserUID = UM.UserUID AND UM.[Status] NOT IN (16,32,48,64,80)where C.UserID = @UserID

UPDATE PS_GameData.dbo.Chars SET[PosZ]=
    (CASE 
        WHEN Family=0 AND Job=0 THEN  1760
        WHEN Family=1 AND Job=0 THEN  1575 
        WHEN Family=2 AND Job=1 THEN  444
        WHEN Family=3 AND Job=1 THEN  398
 ELSE PosZ
END)
FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
ON C.UserUID = UM.UserUID AND UM.[Status] NOT IN (16,32,48,64,80)where C.UserID = @UserID

--Update Players Base Stats
UPDATE PS_GameData.dbo.Chars SET [Str]=
   (CASE 
        WHEN Family=0 AND Job=0 THEN 14
        WHEN Family=3 AND Job=0 THEN 14 
        WHEN Family=0 AND Job=1 THEN 10 
        WHEN Family=3 AND Job=1 THEN 12 
        WHEN Family=1 AND Job=2 THEN 10 
        WHEN Family=2 AND Job=2 THEN 10 
        WHEN Family=1 AND Job=3 THEN 11
        WHEN Family=3 AND Job=3 THEN 13 
        WHEN Family=1 AND Job=4 THEN 7
        WHEN Family=2 AND Job=4 THEN 7
        WHEN Family=0 AND Job=5 THEN 8 
        WHEN Family=2 AND Job=5 THEN 8
 ELSE [Str]
END)
FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
ON C.UserUID = UM.UserUID AND UM.[Status] NOT IN (16,32,48,64,80)where C.UserID = @UserID
 
UPDATE PS_GameData.dbo.Chars SET[Dex]=
    (CASE 
        WHEN Family=0 AND Job=0 THEN  12
        WHEN Family=3 AND Job=0 THEN  12 
        WHEN Family=0 AND Job=1 THEN  9 
        WHEN Family=3 AND Job=1 THEN  9 
        WHEN Family=1 AND Job=2 THEN  19 
        WHEN Family=2 AND Job=2 THEN  15 
        WHEN Family=1 AND Job=3 THEN  14
        WHEN Family=3 AND Job=3 THEN  10 
        WHEN Family=1 AND Job=4 THEN  13
        WHEN Family=2 AND Job=4 THEN  9 
        WHEN Family=0 AND Job=5 THEN  9 
        WHEN Family=2 AND Job=5 THEN  9
 ELSE Dex
END)
FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
ON C.UserUID = UM.UserUID AND UM.[Status] NOT IN (16,32,48,64,80)where C.UserID = @UserID

UPDATE PS_GameData.dbo.Chars SET Rec=
    (CASE 
        WHEN Family=0 AND Job=0 THEN 9
        WHEN Family=3 AND Job=0 THEN 9 
        WHEN Family=0 AND Job=1 THEN 12 
        WHEN Family=3 AND Job=1 THEN 14 
        WHEN Family=1 AND Job=2 THEN 9
        WHEN Family=2 AND Job=2 THEN 9 
        WHEN Family=1 AND Job=3 THEN 10
        WHEN Family=3 AND Job=3 THEN 12
        WHEN Family=1 AND Job=4 THEN 9
        WHEN Family=2 AND Job=4 THEN 9 
        WHEN Family=0 AND Job=5 THEN 10 
        WHEN Family=2 AND Job=5 THEN 10
 ELSE [Rec]
END)
FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
ON C.UserUID = UM.UserUID AND UM.[Status] NOT IN (16,32,48,64,80)where C.UserID = @UserID

UPDATE PS_GameData.dbo.Chars SET [Int]=
   ( CASE 
        WHEN Family=0 AND Job=0 THEN  8
        WHEN Family=3 AND Job=0 THEN  8 
        WHEN Family=0 AND Job=1 THEN  10 
        WHEN Family=3 AND Job=1 THEN  10 
        WHEN Family=1 AND Job=2 THEN  7 
        WHEN Family=2 AND Job=2 THEN  9 
        WHEN Family=1 AND Job=3 THEN  7
        WHEN Family=3 AND Job=3 THEN  7 
        WHEN Family=1 AND Job=4 THEN  15
        WHEN Family=2 AND Job=4 THEN  17 
        WHEN Family=0 AND Job=5 THEN  12 
        WHEN Family=2 AND Job=5 THEN  14
 ELSE [Int]
END)
FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
ON C.UserUID = UM.UserUID AND UM.[Status] NOT IN (16,32,48,64,80)where C.UserID = @UserID

UPDATE PS_GameData.dbo.Chars SET [Wis]=
   ( CASE 
        WHEN Family=0 AND Job=0 THEN  7
        WHEN Family=3 AND Job=0 THEN  7 
        WHEN Family=0 AND Job=1 THEN  10 
        WHEN Family=3 AND Job=1 THEN  10 
        WHEN Family=1 AND Job=2 THEN  8 
        WHEN Family=2 AND Job=2 THEN  10 
        WHEN Family=1 AND Job=3 THEN  10
        WHEN Family=3 AND Job=3 THEN  10 
        WHEN Family=1 AND Job=4 THEN  12
        WHEN Family=2 AND Job=4 THEN  14 
        WHEN Family=0 AND Job=5 THEN  14
        WHEN Family=2 AND Job=5 THEN  16
 ELSE [Wis]
END)
FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
ON C.UserUID = UM.UserUID AND UM.[Status] NOT IN (16,32,48,64,80)where C.UserID = @UserID

UPDATE PS_GameData.dbo.Chars SET [Luc]=
    (CASE 
        WHEN Family=0 AND Job=0 THEN  15 
        WHEN Family=3 AND Job=0 THEN  15 
        WHEN Family=0 AND Job=1 THEN  14 
        WHEN Family=3 AND Job=1 THEN  10 
        WHEN Family=1 AND Job=2 THEN  12 
        WHEN Family=2 AND Job=2 THEN  12 
        WHEN Family=1 AND Job=3 THEN  13
        WHEN Family=3 AND Job=3 THEN  13 
        WHEN Family=1 AND Job=4 THEN  9
        WHEN Family=2 AND Job=4 THEN  9 
        WHEN Family=0 AND Job=5 THEN  12 
        WHEN Family=2 AND Job=5 THEN  8
 ELSE [Luc]
END)
FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
ON C.UserUID = UM.UserUID AND UM.[Status] NOT IN (16,32,48,64,80)where C.UserID = @UserID

UPDATE PS_GameData.dbo.Chars SET [HP]=
    (CASE 
        WHEN Family=0 AND Job=0 THEN  352  --Fighter
        WHEN Family=3 AND Job=0 THEN  352  --war
        WHEN Family=0 AND Job=1 THEN  6385 --def
        WHEN Family=3 AND Job=1 THEN  6385 --Gard
        WHEN Family=1 AND Job=2 THEN  6879 --Ranger
        WHEN Family=2 AND Job=2 THEN  6879 --Sin
        WHEN Family=1 AND Job=3 THEN  5583 --Archer
        WHEN Family=3 AND Job=3 THEN  5583 --Hunter
        WHEN Family=1 AND Job=4 THEN  5157 --Mage
        WHEN Family=2 AND Job=4 THEN  5157 --Pagan
        WHEN Family=0 AND Job=5 THEN  3261 --Priest
        WHEN Family=2 AND Job=5 THEN  3261 --Orc
 ELSE [HP]
END)
FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
ON C.UserUID = UM.UserUID AND UM.[Status] NOT IN (16,32,48,64,80)where C.UserID = @UserID

UPDATE PS_GameData.dbo.Chars SET [MP]=
    (CASE 
        WHEN Family=0 AND Job=0 THEN  110  --Fighter
        WHEN Family=3 AND Job=0 THEN  110  --war
        WHEN Family=0 AND Job=1 THEN  495 --def
        WHEN Family=3 AND Job=1 THEN  495 --Gard
        WHEN Family=1 AND Job=2 THEN  518 --Ranger
        WHEN Family=2 AND Job=2 THEN  518 --Sin
        WHEN Family=1 AND Job=3 THEN  534 --Archer
        WHEN Family=3 AND Job=3 THEN  534 --Hunter
        WHEN Family=1 AND Job=4 THEN  593 --Mage
        WHEN Family=2 AND Job=4 THEN  593 --Pagan
        WHEN Family=0 AND Job=5 THEN  4501 --Priest
        WHEN Family=2 AND Job=5 THEN  4501 --Orc
 ELSE [MP]
END)
FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
ON C.UserUID = UM.UserUID AND UM.[Status] NOT IN (16,32,48,64,80)where C.UserID = @UserID

UPDATE PS_GameData.dbo.Chars SET [SP]=
    (CASE 
        WHEN Family=0 AND Job=0 THEN  257  --Fighter
        WHEN Family=3 AND Job=0 THEN  257  --war
        WHEN Family=0 AND Job=1 THEN  557 --def
        WHEN Family=3 AND Job=1 THEN  557 --Gard
        WHEN Family=1 AND Job=2 THEN  555 --Ranger
        WHEN Family=2 AND Job=2 THEN  555 --Sin
        WHEN Family=1 AND Job=3 THEN  2081 --Archer
        WHEN Family=3 AND Job=3 THEN  2081 --Hunter
        WHEN Family=1 AND Job=4 THEN  2099 --Mage
        WHEN Family=2 AND Job=4 THEN  2099 --Pagan
        WHEN Family=0 AND Job=5 THEN  452 --Priest
        WHEN Family=2 AND Job=5 THEN  452 --Orc
 ELSE [SP]
END)
FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
ON C.UserUID = UM.UserUID AND UM.[Status] NOT IN (16,32,48,64,80)where C.UserID = @UserID

SELECT CharID INTO #CharTemp FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
    ON C.UserUID = UM.UserUID AND UM.[Status]  NOT IN (16,32,48,64,80)where C.UserID = @UserID

SELECT UserUID INTO #CharTemp1 FROM  PS_UserData.dbo.Users_Master Where [Status]  NOT IN (16,32,48,64,80)and UserID = @UserID

SELECT CharID INTO #CharTemp2 FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
    ON C.Family = 0 and C.Job = 0 and C.UserUID = UM.UserUID AND UM.[Status]  NOT IN (16,32,48,64,80)where C.UserID = @UserID

SELECT CharID INTO #CharTemp3 FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
    ON C.Family = 0 and C.Job = 1 and C.UserUID = UM.UserUID AND UM.[Status]  NOT IN (16,32,48,64,80)where C.UserID = @UserID

SELECT CharID INTO #CharTemp4 FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
    ON C.Family = 0 and C.Job = 5 and C.UserUID = UM.UserUID AND UM.[Status]  NOT IN (16,32,48,64,80)where C.UserID = @UserID

SELECT CharID INTO #CharTemp5 FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
    ON C.Family = 1 and C.Job = 3 and C.UserUID = UM.UserUID AND UM.[Status]  NOT IN (16,32,48,64,80)where C.UserID = @UserID

SELECT CharID INTO #CharTemp6 FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
    ON C.Family = 1 and C.Job = 2 and C.UserUID = UM.UserUID AND UM.[Status]  NOT IN (16,32,48,64,80)where C.UserID = @UserID

SELECT CharID INTO #CharTemp7 FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM 
 ON C.Family = 1 and C.Job = 4 and C.UserUID = UM.UserUID AND UM.[Status]  NOT IN (16,32,48,64,80)WHERE C.UserID = @UserID

SELECT CharID INTO #CharTemp8 FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
    ON C.Family = 3 and C.Job = 0 and C.UserUID = UM.UserUID AND UM.[Status]  NOT IN (16,32,48,64,80)where C.UserID = @UserID

SELECT CharID INTO #CharTemp9 FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
    ON C.Family = 3 and C.Job = 1 and C.UserUID = UM.UserUID AND UM.[Status]  NOT IN (16,32,48,64,80)where C.UserID = @UserID

SELECT CharID INTO #CharTemp10 FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
    ON C.Family = 2 and C.Job = 5 and C.UserUID = UM.UserUID AND UM.[Status]  NOT IN (16,32,48,64,80)where C.UserID = @UserID

SELECT CharID INTO #CharTemp11 FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
    ON C.Family = 3 and C.Job = 3 and C.UserUID = UM.UserUID AND UM.[Status]  NOT IN (16,32,48,64,80)where C.UserID = @UserID

SELECT CharID INTO #CharTemp12 FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
    ON C.Family = 2 and C.Job = 2 and C.UserUID = UM.UserUID AND UM.[Status]  NOT IN (16,32,48,64,80)where C.UserID = @UserID

SELECT CharID INTO #CharTemp13 FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
    ON C.Family = 2 and C.Job = 4 and C.UserUID = UM.UserUID AND UM.[Status]  NOT IN (16,32,48,64,80)where C.UserID = @UserID

SELECT CharID INTO #CharTemp14 FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
    ON  C.Job = 1 and C.UserUID = UM.UserUID AND UM.[Status]  NOT IN (16,32,48,64,80)where C.UserID = @UserID

SELECT CharID INTO #CharTemp15 FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
    ON  C.Job IN (0,2,3,4,5,6,7,8,9,10,11,12,13,14) and C.UserUID = UM.UserUID AND UM.[Status]  NOT IN (16,32,48,64,80)where C.UserID = @UserID
--Deleate Skills

DELETE FROM [PS_GameData].[dbo].[CharSkills] WHERE [CharID] IN (SELECT [CharID] FROM #CharTemp);

    -- delete all Quick Slots
DELETE FROM [PS_GameData].[dbo].[CharQuickSlots] WHERE [CharID] IN (SELECT [CharID] FROM #CharTemp);

--Update Equiped Items
update [PS_GameData].[dbo].[CharItems]Set ItemID=1001,[Type]=1,TypeID=1, Gem1=0, Gem2=0, Gem3=0, Gem4=0, Gem5=0, Gem6=0, CraftName=00000000000000000000
 WHERE [CharID] IN 
(SELECT [CharID] FROM #CharTemp2) and Bag=0 and Slot=5;

update [PS_GameData].[dbo].[CharItems]Set ItemID=7001,[Type]=7,TypeID=1, Gem1=0, Gem2=0, Gem3=0, Gem4=0, Gem5=0, Gem6=0, CraftName=00000000000000000000
 WHERE [CharID] IN 
(SELECT [CharID] FROM #CharTemp3) and Bag=0 and Slot=5;

update [PS_GameData].[dbo].[CharItems]Set ItemID=12001,[Type]=12,TypeID=1, Gem1=0, Gem2=0, Gem3=0, Gem4=0, Gem5=0, Gem6=0, CraftName=00000000000000000000
 WHERE [CharID] IN 
(SELECT [CharID] FROM #CharTemp4) and Bag=0 and Slot=5;

update [PS_GameData].[dbo].[CharItems]Set ItemID=13001,[Type]=13,TypeID=1, Gem1=0, Gem2=0, Gem3=0, Gem4=0, Gem5=0, Gem6=0, CraftName=00000000000000000000
 WHERE [CharID] IN 
(SELECT [CharID] FROM #CharTemp5) and Bag=0 and Slot=5;

update [PS_GameData].[dbo].[CharItems]Set ItemID=9001,[Type]=9,TypeID=1, Gem1=0, Gem2=0, Gem3=0, Gem4=0, Gem5=0, Gem6=0, CraftName=00000000000000000000
 WHERE [CharID] IN 
(SELECT [CharID] FROM #CharTemp6) and Bag=0 and Slot=5;

update [PS_GameData].[dbo].[CharItems]Set ItemID=12001,[Type]=12,TypeID=1, Gem1=0, Gem2=0, Gem3=0, Gem4=0, Gem5=0, Gem6=0, CraftName=00000000000000000000
 WHERE [CharID] IN 
(SELECT [CharID] FROM #CharTemp7) and Bag=0 and Slot=5;

update [PS_GameData].[dbo].[CharItems]Set ItemID=3001,[Type]=3,TypeID=1, Gem1=0, Gem2=0, Gem3=0, Gem4=0, Gem5=0, Gem6=0, CraftName=00000000000000000000
 WHERE [CharID] IN 
(SELECT [CharID] FROM #CharTemp8) and Bag=0 and Slot=5;

update [PS_GameData].[dbo].[CharItems]Set ItemID=7006,[Type]=7,TypeID=6, Gem1=0, Gem2=0, Gem3=0, Gem4=0, Gem5=0, Gem6=0, CraftName=00000000000000000000
 WHERE [CharID] IN 
(SELECT [CharID] FROM #CharTemp9) and Bag=0 and Slot=5;

update [PS_GameData].[dbo].[CharItems]Set ItemID=12006,[Type]=12,TypeID=6, Gem1=0, Gem2=0, Gem3=0, Gem4=0, Gem5=0, Gem6=0, CraftName=00000000000000000000
 WHERE [CharID] IN 
(SELECT [CharID] FROM #CharTemp10) and Bag=0 and Slot=5;

update [PS_GameData].[dbo].[CharItems]Set ItemID=13006,[Type]=13,TypeID=6, Gem1=0, Gem2=0, Gem3=0, Gem4=0, Gem5=0, Gem6=0, CraftName=00000000000000000000
 WHERE [CharID] IN 
(SELECT [CharID] FROM #CharTemp11) and Bag=0 and Slot=5;

update [PS_GameData].[dbo].[CharItems]Set ItemID=9001,[Type]=9,TypeID=1, Gem1=0, Gem2=0, Gem3=0, Gem4=0, Gem5=0, Gem6=0, CraftName=00000000000000000000
 WHERE [CharID] IN 
(SELECT [CharID] FROM #CharTemp12) and Bag=0 and Slot=5;

update [PS_GameData].[dbo].[CharItems]Set ItemID=12006,[Type]=12,TypeID=6, Gem1=0, Gem2=0, Gem3=0, Gem4=0, Gem5=0, Gem6=0, CraftName=00000000000000000000
 WHERE [CharID] IN 
(SELECT [CharID] FROM #CharTemp13) and Bag=0 and Slot=5;

update [PS_GameData].[dbo].[CharItems]Set ItemID=19001,[Type]=19,TypeID=1, Gem1=0, Gem2=0, Gem3=0, Gem4=0, Gem5=0, Gem6=0, CraftName=00000000000000000000
 WHERE [CharID] IN 
(SELECT [CharID] FROM #CharTemp3) and Bag=0 and Slot=6;

update [PS_GameData].[dbo].[CharItems]Set ItemID=34001,[Type]=19,TypeID=1, Gem1=0, Gem2=0, Gem3=0, Gem4=0, Gem5=0, Gem6=0, CraftName=00000000000000000000
 WHERE [CharID] IN 
(SELECT [CharID] FROM #CharTemp9) and Bag=0 and Slot=6;

--deleate  all none equiped weps/shields
DELETE FROM [PS_GameData].[dbo].[CharItems] WHERE [CharID] IN (SELECT [CharID] FROM #CharTemp14) and Bag IN ( 1 ,2 ,3 ,4 ,5 ,6 ,7);

DELETE FROM [PS_GameData].[dbo].[CharItems] WHERE [CharID] IN (SELECT [CharID] FROM #CharTemp14) and 
Slot IN(0,1,2,3,4,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30);

DELETE FROM [PS_GameData].[dbo].[CharItems] WHERE [CharID] IN (SELECT [CharID] FROM #CharTemp15) and Bag IN ( 1,2,3,4,5,6,7,8,9);

DELETE FROM [PS_GameData].[dbo].[CharItems] WHERE [CharID] IN (SELECT [CharID] FROM #CharTemp15) and 
Slot IN (0,1,2,3,4,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30);

--deleat all WH Items
DELETE FROM [PS_GameData].[dbo].[UserStoredItems] WHERE [UserUID] IN (SELECT [UserUID] FROM #CharTemp1);


--Deletion of Teleportation Spots (Not finished yet)
DELETE FROM [PS_GameData].[dbo].[CharSavePoint] WHERE [CharID] IN (SELECT [CharID] FROM #CharTemp);
--makeshure ItemID is exact
Update PS_GameData.dbo.CharItems set ItemID = [Type]*1000+TypeID where CharID=CharID

--Dropping temporary tables
DROP TABLE #CharTemp
Drop Table #CharTemp1
Drop Table #CharTemp2
Drop Table #CharTemp3
Drop Table #CharTemp4
Drop Table #CharTemp5
Drop Table #CharTemp6
Drop Table #CharTemp7
Drop Table #CharTemp8
Drop Table #CharTemp9
Drop Table #CharTemp10
Drop Table #CharTemp11
Drop Table #CharTemp12
Drop Table #CharTemp13
Drop Table #CharTemp14
Drop Table #CharTemp15 

SET NOCOUNT OFF
GO
/****** Object:  StoredProcedure [dbo].[usp_FC]    Script Date: 02/07/2012 19:07:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_FC]

@UserID varchar(16)

AS
SET NOCOUNT ON

DECLARE
@User int,
@Country tinyint,
@Family tinyint,
@Charge int,
@Point int,
@CharID Int,
@Skill_NM smallint, 
@Skill_HM smallint, 
@Skill_UM smallint

SELECT @User=um.UserUID, @Country=umg.Country
FROM PS_UserData.dbo.Users_Master AS um
INNER JOIN PS_GameData.dbo.UserMaxGrow AS umg ON umg.UserUID = um.UserUID
WHERE um.UserID=@UserID

SET @Charge='1000' --Set the cost of Faction Change
SELECT @Point=Point FROM PS_UserData.dbo.Users_Master WHERE UserUID=@User
IF (@Point < @Charge)
BEGIN
  PRINT 'Insufficient AP'
 RETURN 2
END
GOTO SkillReset;

SkillReset:
SET @Skill_NM = 3 -- Your NM Skill points per level
SET @Skill_HM = 4 -- Your HM Skill points per level
SET @Skill_UM = 8 -- Your UM Skill points per level
BEGIN
DELETE FROM PS_GameData.dbo.CharSkills WHERE
CharID in (SELECT CharID FROM PS_GameData.dbo.Chars
WHERE UserUID=@User AND [Level]>1 AND Del=0 AND Grow>0)
AND SkillID<>4

UPDATE PS_GameData.dbo.Chars SET SkillPoint = ([Level]-1)*(
CASE Grow
WHEN 1 THEN @Skill_NM
WHEN 2 THEN @Skill_HM
WHEN 3 THEN @Skill_UM END)
WHERE [Level]>1 AND Del=0 AND Grow>0 AND UserUID=@User
END
GOTO DeleatQuests;

DeleatQuests:
BEGIN
DELETE FROM PS_GameData.dbo.CharQuests WHERE
CharID in (SELECT CharID FROM PS_GameData.dbo.Chars WHERE UserUID=@User)
END
GOTO DeleatGuild;

DeleatGuild:
BEGIN
DELETE FROM PS_GameData.dbo.GuildChars WHERE
CharID in (SELECT CharID FROM PS_GameData.dbo.Chars WHERE UserUID=@User)
END
GOTO DeleatFriends;

DeleatFriends:
BEGIN
DELETE FROM PS_GameData.dbo.FriendChars WHERE
CharID in (SELECT CharID FROM PS_GameData.dbo.Chars WHERE UserUID=@User)
DELETE FROM PS_GameData.dbo.FriendChars WHERE
FriendID in (SELECT CharID FROM PS_GameData.dbo.Chars WHERE UserUID=@User)
END
GOTO FactionChange;
-- Faction Selection
FactionChange:
BEGIN
  UPDATE PS_GameData.dbo.UserMaxGrow SET Country=(
CASE 
 WHEN Country = 0 THEN 1 
 WHEN Country = 1 THEN 0 
 ELSE Country
END)
WHERE UserUID=@User 
PRINT 'Faction Changed'
END
  GOTO Family_Change;
/*
 WHEN Family=0 AND Job = 0 THEN 'Fighter'
 WHEN Family=0 AND Job =1  THEN 'Defender'
 WHEN Family=0 AND Job =5  THEN 'Priest'
 WHEN Family=1 AND Job = 3 THEN 'Archer'
 WHEN Family=1 AND Job = 2 THEN 'Ranger'
 WHEN Family=1 AND Job = 4 THEN 'Mage'
 WHEN Family=3 AND Job = 0 THEN 'Warrior'
 WHEN Family=3 AND Job = 1 THEN 'Guardian'
 WHEN Family=3 AND Job = 3 THEN 'Hunter'
 WHEN Family=2 AND Job = 4 THEN 'Pagan'
 WHEN Family=2 AND Job = 2 THEN 'Assassin'
 WHEN Family=2 AND Job = 5 THEN 'Oracle'
*/

Family_Change:
BEGIN
UPDATE PS_GameData.dbo.Chars 
SET [Family] = (
CASE 
 WHEN Family=0 AND Job=5 THEN 2
 WHEN Family=0 AND Job IN (0,1) THEN 3

 WHEN Family=1 AND Job=3 THEN 3
 WHEN Family=1 AND Job IN (2,4) THEN 2

 WHEN Family=2 AND Job=5 THEN 0
 WHEN Family=2 AND Job IN (2,4) THEN 1

 WHEN Family=3 AND Job=3 THEN 1
 WHEN  Family=3 AND Job IN (0,1) THEN 0

 ELSE Family
END)
WHERE UserUID=@User
PRINT 'toon changed sucessfully'
/*
UPDATE PS_GameData.dbo.Chars 
SET [Class] = (
CASE 
 WHEN Class='Fighter' THEN 'Warrior'
 WHEN Class='Warrior' THEN 'Fighter'
 WHEN Class='Defender' THEN 'Guardian'
 WHEN Class='Guardian'  THEN 'Defender'
 WHEN Class='Ranger' THEN 'Assassin'
 WHEN Class='Assassin' THEN 'Ranger'
 WHEN Class='Priest' THEN 'Oracle'
 WHEN Class='Oracle' THEN 'Priest'
 WHEN Class='Archer' THEN 'Hunter'
 WHEN Class='Hunter' THEN 'Archer'
 WHEN Class='Mage' THEN 'Pagan'
 WHEN Class='Pagan' THEN 'Mage'
 ELSE Class
END)
WHERE UserUID=@User
PRINT 'toon changed sucessfully'*/
END
GOTO Map_Spawn_Set;
--SET SPAWN POINTS TO AH
Map_Spawn_Set:
BEGIN
UPDATE PS_GameData.dbo.Chars 
SET Map=42, PosX=63,PosY=2, PosZ=57  
WHERE UserID=@UserID
Print 'All Toons Moved To AH'
END
GOTO DELEATTelly;

--Deletion of Teleportation Spots (Not finished yet)
DELEATTelly:
Begin
SELECT CharID INTO #CharTemp FROM PS_GameData.dbo.Chars WHERE UserID=@UserID
DELETE FROM [PS_GameData].[dbo].[CharSavePoint] WHERE [CharID] IN (SELECT [CharID] FROM #CharTemp)
END
GOTO ItemUpdate;

ItemUpdate:
UPDATE PS_GameData.dbo.CharItems
SET [TypeID]=
(CASE
WHEN	ItemID	=	6001	THEN	6
WHEN	ItemID	=	6002	THEN	7
WHEN	ItemID	=	6006	THEN	1
WHEN	ItemID	=	6007	THEN	2
WHEN	ItemID	=	5001	THEN	6
WHEN	ItemID	=	5002	THEN	7
WHEN	ItemID	=	5006	THEN	1
WHEN	ItemID	=	5007	THEN	2
WHEN	ItemID	=	7001	THEN	6
WHEN	ItemID	=	7002	THEN	7
WHEN	ItemID	=	7006	THEN	1
WHEN	ItemID	=	7007	THEN	2
WHEN	ItemID	=	8001	THEN	6
WHEN	ItemID	=	8002	THEN	7
WHEN	ItemID	=	8006	THEN	1
WHEN	ItemID	=	8007	THEN	2
WHEN	ItemID	=	12001	THEN	6
WHEN	ItemID	=	12002	THEN	7
WHEN	ItemID	=	12006	THEN	1
WHEN	ItemID	=	12007	THEN	2
WHEN	ItemID	=	13001	THEN	6
WHEN	ItemID	=	13002	THEN	7
WHEN	ItemID	=	13006	THEN	1
WHEN	ItemID	=	13007	THEN	2
WHEN	ItemID	=	7011	THEN	16
WHEN	ItemID	=	7012	THEN	17
WHEN	ItemID	=	7013	THEN	18
WHEN	ItemID	=	7016	THEN	11
WHEN	ItemID	=	7017	THEN	12
WHEN	ItemID	=	7018	THEN	13
WHEN	ItemID	=	8011	THEN	16
WHEN	ItemID	=	8012	THEN	17
WHEN	ItemID	=	8013	THEN	18
WHEN	ItemID	=	8016	THEN	11
WHEN	ItemID	=	8017	THEN	12
WHEN	ItemID	=	8018	THEN	13
WHEN	ItemID	=	5011	THEN	16
WHEN	ItemID	=	5012	THEN	17
WHEN	ItemID	=	5013	THEN	18
WHEN	ItemID	=	5016	THEN	11
WHEN	ItemID	=	5017	THEN	12
WHEN	ItemID	=	5018	THEN	13
WHEN	ItemID	=	12011	THEN	16
WHEN	ItemID	=	12012	THEN	17
WHEN	ItemID	=	12013	THEN	18
WHEN	ItemID	=	12016	THEN	11
WHEN	ItemID	=	12017	THEN	12
WHEN	ItemID	=	12018	THEN	13
WHEN	ItemID	=	13011	THEN	16
WHEN	ItemID	=	13012	THEN	17
WHEN	ItemID	=	13013	THEN	18
WHEN	ItemID	=	13016	THEN	11
WHEN	ItemID	=	13017	THEN	12
WHEN	ItemID	=	13018	THEN	13
WHEN	ItemID	=	6011	THEN	16
WHEN	ItemID	=	6012	THEN	17
WHEN	ItemID	=	6013	THEN	18
WHEN	ItemID	=	6016	THEN	11
WHEN	ItemID	=	6017	THEN	12
WHEN	ItemID	=	6018	THEN	13
WHEN	ItemID	=	7021	THEN	26
WHEN	ItemID	=	7022	THEN	27
WHEN	ItemID	=	7023	THEN	28
WHEN	ItemID	=	7024	THEN	29
WHEN	ItemID	=	7026	THEN	21
WHEN	ItemID	=	7027	THEN	22
WHEN	ItemID	=	7028	THEN	23
WHEN	ItemID	=	7029	THEN	24
WHEN	ItemID	=	12021	THEN	26
WHEN	ItemID	=	12022	THEN	27
WHEN	ItemID	=	12023	THEN	28
WHEN	ItemID	=	12024	THEN	29
WHEN	ItemID	=	12026	THEN	21
WHEN	ItemID	=	12027	THEN	22
WHEN	ItemID	=	12028	THEN	23
WHEN	ItemID	=	12029	THEN	24
WHEN	ItemID	=	8021	THEN	26
WHEN	ItemID	=	8022	THEN	27
WHEN	ItemID	=	8023	THEN	28
WHEN	ItemID	=	8024	THEN	29
WHEN	ItemID	=	8026	THEN	21
WHEN	ItemID	=	8027	THEN	22
WHEN	ItemID	=	8028	THEN	23
WHEN	ItemID	=	8029	THEN	24
WHEN	ItemID	=	5021	THEN	26
WHEN	ItemID	=	5022	THEN	27
WHEN	ItemID	=	5023	THEN	28
WHEN	ItemID	=	5024	THEN	29
WHEN	ItemID	=	5026	THEN	21
WHEN	ItemID	=	5027	THEN	22
WHEN	ItemID	=	5028	THEN	23
WHEN	ItemID	=	5029	THEN	24
WHEN	ItemID	=	13021	THEN	26
WHEN	ItemID	=	13022	THEN	27
WHEN	ItemID	=	13023	THEN	28
WHEN	ItemID	=	13024	THEN	29
WHEN	ItemID	=	13026	THEN	21
WHEN	ItemID	=	13027	THEN	22
WHEN	ItemID	=	13028	THEN	23
WHEN	ItemID	=	13029	THEN	24
WHEN	ItemID	=	6021	THEN	26
WHEN	ItemID	=	6022	THEN	27
WHEN	ItemID	=	6023	THEN	28
WHEN	ItemID	=	6024	THEN	29
WHEN	ItemID	=	6026	THEN	21
WHEN	ItemID	=	6027	THEN	22
WHEN	ItemID	=	6028	THEN	23
WHEN	ItemID	=	6029	THEN	24
WHEN	ItemID	=	6031	THEN	36
WHEN	ItemID	=	6032	THEN	37
WHEN	ItemID	=	6033	THEN	38
WHEN	ItemID	=	6034	THEN	39
WHEN	ItemID	=	6035	THEN	40
WHEN	ItemID	=	6036	THEN	31
WHEN	ItemID	=	6037	THEN	32
WHEN	ItemID	=	6038	THEN	33
WHEN	ItemID	=	6039	THEN	34
WHEN	ItemID	=	6040	THEN	35
WHEN	ItemID	=	5031	THEN	36
WHEN	ItemID	=	5032	THEN	37
WHEN	ItemID	=	5033	THEN	38
WHEN	ItemID	=	5034	THEN	39
WHEN	ItemID	=	5035	THEN	40
WHEN	ItemID	=	5036	THEN	31
WHEN	ItemID	=	5037	THEN	32
WHEN	ItemID	=	5038	THEN	33
WHEN	ItemID	=	5039	THEN	34
WHEN	ItemID	=	5040	THEN	35
WHEN	ItemID	=	8031	THEN	36
WHEN	ItemID	=	8032	THEN	37
WHEN	ItemID	=	8033	THEN	38
WHEN	ItemID	=	8034	THEN	39
WHEN	ItemID	=	8035	THEN	40
WHEN	ItemID	=	8036	THEN	31
WHEN	ItemID	=	8037	THEN	32
WHEN	ItemID	=	8038	THEN	33
WHEN	ItemID	=	8039	THEN	34
WHEN	ItemID	=	8040	THEN	35
WHEN	ItemID	=	7031	THEN	36
WHEN	ItemID	=	7032	THEN	37
WHEN	ItemID	=	7033	THEN	38
WHEN	ItemID	=	7034	THEN	39
WHEN	ItemID	=	7035	THEN	40
WHEN	ItemID	=	7036	THEN	31
WHEN	ItemID	=	7037	THEN	32
WHEN	ItemID	=	7038	THEN	33
WHEN	ItemID	=	7039	THEN	34
WHEN	ItemID	=	7040	THEN	35
WHEN	ItemID	=	13031	THEN	36
WHEN	ItemID	=	13032	THEN	37
WHEN	ItemID	=	13033	THEN	38
WHEN	ItemID	=	13034	THEN	39
WHEN	ItemID	=	13035	THEN	40
WHEN	ItemID	=	13036	THEN	31
WHEN	ItemID	=	13037	THEN	32
WHEN	ItemID	=	13038	THEN	33
WHEN	ItemID	=	13039	THEN	34
WHEN	ItemID	=	13040	THEN	35
WHEN	ItemID	=	12031	THEN	36
WHEN	ItemID	=	12032	THEN	37
WHEN	ItemID	=	12033	THEN	38
WHEN	ItemID	=	12034	THEN	39
WHEN	ItemID	=	12035	THEN	40
WHEN	ItemID	=	12036	THEN	31
WHEN	ItemID	=	12037	THEN	32
WHEN	ItemID	=	12038	THEN	33
WHEN	ItemID	=	12039	THEN	34
WHEN	ItemID	=	12040	THEN	35
WHEN	ItemID	=	12041	THEN	46
WHEN	ItemID	=	12042	THEN	47
WHEN	ItemID	=	12043	THEN	48
WHEN	ItemID	=	12044	THEN	49
WHEN	ItemID	=	12045	THEN	50
WHEN	ItemID	=	12046	THEN	41
WHEN	ItemID	=	12047	THEN	42
WHEN	ItemID	=	12048	THEN	43
WHEN	ItemID	=	12049	THEN	44
WHEN	ItemID	=	12050	THEN	45
WHEN	ItemID	=	7041	THEN	46
WHEN	ItemID	=	7042	THEN	47
WHEN	ItemID	=	7043	THEN	48
WHEN	ItemID	=	7044	THEN	49
WHEN	ItemID	=	7045	THEN	50
WHEN	ItemID	=	7046	THEN	41
WHEN	ItemID	=	7047	THEN	42
WHEN	ItemID	=	7048	THEN	43
WHEN	ItemID	=	7049	THEN	44
WHEN	ItemID	=	7050	THEN	45
WHEN	ItemID	=	8041	THEN	46
WHEN	ItemID	=	8042	THEN	47
WHEN	ItemID	=	8043	THEN	48
WHEN	ItemID	=	8044	THEN	49
WHEN	ItemID	=	8045	THEN	50
WHEN	ItemID	=	8046	THEN	41
WHEN	ItemID	=	8047	THEN	42
WHEN	ItemID	=	8048	THEN	43
WHEN	ItemID	=	8049	THEN	44
WHEN	ItemID	=	8050	THEN	45
WHEN	ItemID	=	5041	THEN	46
WHEN	ItemID	=	5042	THEN	47
WHEN	ItemID	=	5043	THEN	48
WHEN	ItemID	=	5044	THEN	49
WHEN	ItemID	=	5045	THEN	50
WHEN	ItemID	=	5046	THEN	41
WHEN	ItemID	=	5047	THEN	42
WHEN	ItemID	=	5048	THEN	43
WHEN	ItemID	=	5049	THEN	44
WHEN	ItemID	=	5050	THEN	45
WHEN	ItemID	=	13041	THEN	46
WHEN	ItemID	=	13042	THEN	47
WHEN	ItemID	=	13043	THEN	48
WHEN	ItemID	=	13044	THEN	49
WHEN	ItemID	=	13045	THEN	50
WHEN	ItemID	=	13046	THEN	41
WHEN	ItemID	=	13047	THEN	42
WHEN	ItemID	=	13048	THEN	43
WHEN	ItemID	=	13049	THEN	44
WHEN	ItemID	=	13050	THEN	45
WHEN	ItemID	=	12201	THEN	203
WHEN	ItemID	=	12202	THEN	204
WHEN	ItemID	=	12203	THEN	201
WHEN	ItemID	=	12204	THEN	202
WHEN	ItemID	=	13201	THEN	202
WHEN	ItemID	=	13202	THEN	201
WHEN	ItemID	=	12051	THEN	56
WHEN	ItemID	=	12052	THEN	57
WHEN	ItemID	=	12053	THEN	58
WHEN	ItemID	=	12054	THEN	59
WHEN	ItemID	=	12055	THEN	60
WHEN	ItemID	=	12056	THEN	51
WHEN	ItemID	=	12057	THEN	52
WHEN	ItemID	=	12058	THEN	53
WHEN	ItemID	=	12059	THEN	54
WHEN	ItemID	=	12060	THEN	55
WHEN	ItemID	=	6041	THEN	46
WHEN	ItemID	=	6042	THEN	47
WHEN	ItemID	=	6043	THEN	48
WHEN	ItemID	=	6044	THEN	49
WHEN	ItemID	=	6045	THEN	50
WHEN	ItemID	=	6046	THEN	41
WHEN	ItemID	=	6047	THEN	42
WHEN	ItemID	=	6048	THEN	43
WHEN	ItemID	=	6049	THEN	44
WHEN	ItemID	=	6050	THEN	45
WHEN	ItemID	=	6051	THEN	56
WHEN	ItemID	=	6052	THEN	57
WHEN	ItemID	=	6053	THEN	58
WHEN	ItemID	=	6054	THEN	59
WHEN	ItemID	=	6055	THEN	60
WHEN	ItemID	=	6056	THEN	51
WHEN	ItemID	=	6057	THEN	52
WHEN	ItemID	=	6058	THEN	53
WHEN	ItemID	=	6059	THEN	54
WHEN	ItemID	=	6060	THEN	55
WHEN	ItemID	=	5051	THEN	56
WHEN	ItemID	=	5052	THEN	57
WHEN	ItemID	=	5053	THEN	58
WHEN	ItemID	=	5054	THEN	59
WHEN	ItemID	=	5055	THEN	60
WHEN	ItemID	=	5056	THEN	51
WHEN	ItemID	=	5057	THEN	52
WHEN	ItemID	=	5058	THEN	53
WHEN	ItemID	=	5059	THEN	54
WHEN	ItemID	=	5060	THEN	55
WHEN	ItemID	=	8051	THEN	56
WHEN	ItemID	=	8052	THEN	57
WHEN	ItemID	=	8053	THEN	58
WHEN	ItemID	=	8054	THEN	59
WHEN	ItemID	=	8055	THEN	60
WHEN	ItemID	=	8056	THEN	51
WHEN	ItemID	=	8057	THEN	52
WHEN	ItemID	=	8058	THEN	53
WHEN	ItemID	=	8059	THEN	54
WHEN	ItemID	=	8060	THEN	55
WHEN	ItemID	=	7051	THEN	56
WHEN	ItemID	=	7052	THEN	57
WHEN	ItemID	=	7053	THEN	58
WHEN	ItemID	=	7054	THEN	59
WHEN	ItemID	=	7055	THEN	60
WHEN	ItemID	=	7056	THEN	51
WHEN	ItemID	=	7057	THEN	52
WHEN	ItemID	=	7058	THEN	53
WHEN	ItemID	=	7059	THEN	54
WHEN	ItemID	=	7060	THEN	55
WHEN	ItemID	=	12061	THEN	66
WHEN	ItemID	=	12062	THEN	67
WHEN	ItemID	=	12063	THEN	68
WHEN	ItemID	=	12064	THEN	69
WHEN	ItemID	=	12066	THEN	61
WHEN	ItemID	=	12067	THEN	62
WHEN	ItemID	=	12068	THEN	63
WHEN	ItemID	=	12069	THEN	64
WHEN	ItemID	=	13051	THEN	56
WHEN	ItemID	=	13052	THEN	57
WHEN	ItemID	=	13053	THEN	58
WHEN	ItemID	=	13054	THEN	59
WHEN	ItemID	=	13055	THEN	60
WHEN	ItemID	=	13056	THEN	51
WHEN	ItemID	=	13057	THEN	52
WHEN	ItemID	=	13058	THEN	53
WHEN	ItemID	=	13059	THEN	54
WHEN	ItemID	=	13060	THEN	55
WHEN	ItemID	=	12070	THEN	65
WHEN	ItemID	=	12065	THEN	70
WHEN	ItemID	=	7201	THEN	201
WHEN	ItemID	=	7061	THEN	66
WHEN	ItemID	=	7062	THEN	67
WHEN	ItemID	=	7063	THEN	68
WHEN	ItemID	=	7064	THEN	69
WHEN	ItemID	=	7065	THEN	70
WHEN	ItemID	=	7066	THEN	61
WHEN	ItemID	=	7067	THEN	62
WHEN	ItemID	=	7068	THEN	63
WHEN	ItemID	=	7069	THEN	64
WHEN	ItemID	=	7070	THEN	65
WHEN	ItemID	=	5201	THEN	201
WHEN	ItemID	=	5061	THEN	66
WHEN	ItemID	=	5062	THEN	67
WHEN	ItemID	=	5063	THEN	68
WHEN	ItemID	=	5064	THEN	69
WHEN	ItemID	=	5065	THEN	70
WHEN	ItemID	=	5066	THEN	61
WHEN	ItemID	=	5067	THEN	62
WHEN	ItemID	=	5068	THEN	63
WHEN	ItemID	=	5069	THEN	64
WHEN	ItemID	=	5070	THEN	65
WHEN	ItemID	=	8061	THEN	66
WHEN	ItemID	=	8062	THEN	67
WHEN	ItemID	=	8063	THEN	68
WHEN	ItemID	=	8064	THEN	69
WHEN	ItemID	=	8065	THEN	70
WHEN	ItemID	=	8066	THEN	61
WHEN	ItemID	=	8067	THEN	62
WHEN	ItemID	=	8068	THEN	63
WHEN	ItemID	=	8069	THEN	64
WHEN	ItemID	=	8070	THEN	65
WHEN	ItemID	=	12071	THEN	76
WHEN	ItemID	=	12072	THEN	77
WHEN	ItemID	=	12073	THEN	78
WHEN	ItemID	=	12074	THEN	79
WHEN	ItemID	=	12075	THEN	80
WHEN	ItemID	=	12076	THEN	71
WHEN	ItemID	=	12077	THEN	72
WHEN	ItemID	=	12078	THEN	73
WHEN	ItemID	=	12079	THEN	74
WHEN	ItemID	=	12080	THEN	75
WHEN	ItemID	=	13061	THEN	66
WHEN	ItemID	=	13062	THEN	67
WHEN	ItemID	=	13063	THEN	68
WHEN	ItemID	=	13064	THEN	69
WHEN	ItemID	=	13065	THEN	70
WHEN	ItemID	=	13066	THEN	61
WHEN	ItemID	=	13067	THEN	62
WHEN	ItemID	=	13068	THEN	63
WHEN	ItemID	=	13069	THEN	64
WHEN	ItemID	=	13070	THEN	65
WHEN	ItemID	=	6061	THEN	66
WHEN	ItemID	=	6062	THEN	67
WHEN	ItemID	=	6063	THEN	68
WHEN	ItemID	=	6064	THEN	69
WHEN	ItemID	=	6065	THEN	70
WHEN	ItemID	=	6066	THEN	61
WHEN	ItemID	=	6067	THEN	62
WHEN	ItemID	=	6068	THEN	63
WHEN	ItemID	=	6069	THEN	64
WHEN	ItemID	=	6070	THEN	65
WHEN	ItemID	=	13251	THEN	252
WHEN	ItemID	=	13252	THEN	251
WHEN	ItemID	=	12251	THEN	253
WHEN	ItemID	=	12252	THEN	254
WHEN	ItemID	=	12253	THEN	251
WHEN	ItemID	=	12254	THEN	252
WHEN	ItemID	=	12081	THEN	86
WHEN	ItemID	=	12082	THEN	87
WHEN	ItemID	=	12083	THEN	88
WHEN	ItemID	=	12084	THEN	89
WHEN	ItemID	=	12085	THEN	90
WHEN	ItemID	=	12086	THEN	81
WHEN	ItemID	=	12087	THEN	82
WHEN	ItemID	=	12088	THEN	83
WHEN	ItemID	=	12089	THEN	84
WHEN	ItemID	=	12090	THEN	85
WHEN	ItemID	=	7071	THEN	76
WHEN	ItemID	=	7072	THEN	77
WHEN	ItemID	=	7073	THEN	78
WHEN	ItemID	=	7074	THEN	79
WHEN	ItemID	=	7075	THEN	80
WHEN	ItemID	=	7076	THEN	71
WHEN	ItemID	=	7077	THEN	72
WHEN	ItemID	=	7078	THEN	73
WHEN	ItemID	=	7079	THEN	74
WHEN	ItemID	=	7080	THEN	75
WHEN	ItemID	=	8071	THEN	76
WHEN	ItemID	=	8072	THEN	77
WHEN	ItemID	=	8073	THEN	78
WHEN	ItemID	=	8074	THEN	79
WHEN	ItemID	=	8075	THEN	80
WHEN	ItemID	=	8076	THEN	71
WHEN	ItemID	=	8077	THEN	72
WHEN	ItemID	=	8078	THEN	73
WHEN	ItemID	=	8079	THEN	74
WHEN	ItemID	=	8080	THEN	75
WHEN	ItemID	=	5071	THEN	76
WHEN	ItemID	=	5072	THEN	77
WHEN	ItemID	=	5073	THEN	78
WHEN	ItemID	=	5074	THEN	79
WHEN	ItemID	=	5075	THEN	80
WHEN	ItemID	=	5076	THEN	71
WHEN	ItemID	=	5077	THEN	72
WHEN	ItemID	=	5078	THEN	73
WHEN	ItemID	=	5079	THEN	74
WHEN	ItemID	=	5080	THEN	75
WHEN	ItemID	=	13071	THEN	76
WHEN	ItemID	=	13072	THEN	77
WHEN	ItemID	=	13073	THEN	78
WHEN	ItemID	=	13074	THEN	79
WHEN	ItemID	=	13075	THEN	80
WHEN	ItemID	=	13076	THEN	71
WHEN	ItemID	=	13077	THEN	72
WHEN	ItemID	=	13078	THEN	73
WHEN	ItemID	=	13079	THEN	74
WHEN	ItemID	=	13080	THEN	75
WHEN	ItemID	=	6071	THEN	76
WHEN	ItemID	=	6072	THEN	77
WHEN	ItemID	=	6073	THEN	78
WHEN	ItemID	=	6074	THEN	79
WHEN	ItemID	=	6075	THEN	80
WHEN	ItemID	=	6076	THEN	71
WHEN	ItemID	=	6077	THEN	72
WHEN	ItemID	=	6078	THEN	73
WHEN	ItemID	=	6079	THEN	74
WHEN	ItemID	=	6080	THEN	75
WHEN	ItemID	=	12205	THEN	216
WHEN	ItemID	=	12206	THEN	222
WHEN	ItemID	=	12207	THEN	225
WHEN	ItemID	=	12208	THEN	219
WHEN	ItemID	=	7202	THEN	207
WHEN	ItemID	=	7203	THEN	210
WHEN	ItemID	=	7207	THEN	202
WHEN	ItemID	=	7208	THEN	211
WHEN	ItemID	=	7209	THEN	212
WHEN	ItemID	=	7210	THEN	203
WHEN	ItemID	=	7211	THEN	208
WHEN	ItemID	=	7212	THEN	209
WHEN	ItemID	=	12216	THEN	205
WHEN	ItemID	=	12217	THEN	223
WHEN	ItemID	=	12218	THEN	224
WHEN	ItemID	=	12219	THEN	208
WHEN	ItemID	=	12220	THEN	226
WHEN	ItemID	=	12221	THEN	227
WHEN	ItemID	=	12222	THEN	206
WHEN	ItemID	=	12223	THEN	217
WHEN	ItemID	=	12224	THEN	218
WHEN	ItemID	=	12225	THEN	207
WHEN	ItemID	=	12226	THEN	220
WHEN	ItemID	=	12227	THEN	221
WHEN	ItemID	=	12091	THEN	96
WHEN	ItemID	=	12092	THEN	97
WHEN	ItemID	=	12093	THEN	98
WHEN	ItemID	=	12094	THEN	99
WHEN	ItemID	=	12095	THEN	100
WHEN	ItemID	=	12096	THEN	91
WHEN	ItemID	=	12097	THEN	92
WHEN	ItemID	=	12098	THEN	93
WHEN	ItemID	=	12099	THEN	94
WHEN	ItemID	=	12100	THEN	95
WHEN	ItemID	=	12166	THEN	91
WHEN	ItemID	=	12167	THEN	92
WHEN	ItemID	=	12168	THEN	93
WHEN	ItemID	=	12169	THEN	94
WHEN	ItemID	=	12170	THEN	95
WHEN	ItemID	=	7081	THEN	86
WHEN	ItemID	=	7082	THEN	87
WHEN	ItemID	=	7083	THEN	88
WHEN	ItemID	=	7084	THEN	89
WHEN	ItemID	=	7085	THEN	90
WHEN	ItemID	=	7086	THEN	81
WHEN	ItemID	=	7087	THEN	82
WHEN	ItemID	=	7088	THEN	83
WHEN	ItemID	=	7089	THEN	84
WHEN	ItemID	=	7090	THEN	85
WHEN	ItemID	=	8081	THEN	86
WHEN	ItemID	=	8082	THEN	87
WHEN	ItemID	=	8083	THEN	88
WHEN	ItemID	=	8084	THEN	89
WHEN	ItemID	=	8085	THEN	90
WHEN	ItemID	=	8086	THEN	81
WHEN	ItemID	=	8087	THEN	82
WHEN	ItemID	=	8088	THEN	83
WHEN	ItemID	=	8089	THEN	84
WHEN	ItemID	=	8090	THEN	85
WHEN	ItemID	=	5081	THEN	86
WHEN	ItemID	=	5082	THEN	87
WHEN	ItemID	=	5083	THEN	88
WHEN	ItemID	=	5084	THEN	89
WHEN	ItemID	=	5085	THEN	90
WHEN	ItemID	=	5086	THEN	81
WHEN	ItemID	=	5087	THEN	82
WHEN	ItemID	=	5088	THEN	83
WHEN	ItemID	=	5089	THEN	84
WHEN	ItemID	=	5090	THEN	85
WHEN	ItemID	=	13081	THEN	86
WHEN	ItemID	=	13082	THEN	87
WHEN	ItemID	=	13083	THEN	88
WHEN	ItemID	=	13084	THEN	89
WHEN	ItemID	=	13085	THEN	90
WHEN	ItemID	=	13086	THEN	81
WHEN	ItemID	=	13087	THEN	82
WHEN	ItemID	=	13088	THEN	83
WHEN	ItemID	=	13089	THEN	84
WHEN	ItemID	=	13090	THEN	85
WHEN	ItemID	=	12209	THEN	211
WHEN	ItemID	=	12210	THEN	212
WHEN	ItemID	=	12211	THEN	209
WHEN	ItemID	=	12212	THEN	210
WHEN	ItemID	=	12101	THEN	111
WHEN	ItemID	=	12102	THEN	112
WHEN	ItemID	=	12103	THEN	113
WHEN	ItemID	=	12104	THEN	114
WHEN	ItemID	=	12105	THEN	115
WHEN	ItemID	=	12106	THEN	116
WHEN	ItemID	=	12111	THEN	101
WHEN	ItemID	=	12112	THEN	102
WHEN	ItemID	=	12113	THEN	103
WHEN	ItemID	=	12114	THEN	104
WHEN	ItemID	=	12115	THEN	105
WHEN	ItemID	=	12116	THEN	106
WHEN	ItemID	=	6081	THEN	86
WHEN	ItemID	=	6082	THEN	87
WHEN	ItemID	=	6083	THEN	88
WHEN	ItemID	=	6084	THEN	89
WHEN	ItemID	=	6085	THEN	90
WHEN	ItemID	=	6086	THEN	81
WHEN	ItemID	=	6087	THEN	82
WHEN	ItemID	=	6088	THEN	83
WHEN	ItemID	=	6089	THEN	84
WHEN	ItemID	=	6090	THEN	85
WHEN	ItemID	=	7091	THEN	101
WHEN	ItemID	=	7092	THEN	102
WHEN	ItemID	=	7093	THEN	103
WHEN	ItemID	=	7094	THEN	104
WHEN	ItemID	=	7095	THEN	105
WHEN	ItemID	=	7096	THEN	106
WHEN	ItemID	=	7101	THEN	91
WHEN	ItemID	=	7102	THEN	92
WHEN	ItemID	=	7103	THEN	93
WHEN	ItemID	=	7104	THEN	94
WHEN	ItemID	=	7105	THEN	95
WHEN	ItemID	=	7106	THEN	96
WHEN	ItemID	=	7204	THEN	205
WHEN	ItemID	=	7205	THEN	204
WHEN	ItemID	=	12161	THEN	166
WHEN	ItemID	=	12162	THEN	167
WHEN	ItemID	=	12163	THEN	168
WHEN	ItemID	=	12164	THEN	169
WHEN	ItemID	=	12165	THEN	170
WHEN	ItemID	=	8201	THEN	202
WHEN	ItemID	=	8202	THEN	201
WHEN	ItemID	=	7151	THEN	156
WHEN	ItemID	=	7152	THEN	157
WHEN	ItemID	=	7153	THEN	158
WHEN	ItemID	=	7154	THEN	159
WHEN	ItemID	=	7155	THEN	160
WHEN	ItemID	=	7156	THEN	151
WHEN	ItemID	=	7157	THEN	152
WHEN	ItemID	=	7158	THEN	153
WHEN	ItemID	=	7159	THEN	154
WHEN	ItemID	=	7160	THEN	155
WHEN	ItemID	=	8091	THEN	96
WHEN	ItemID	=	8092	THEN	97
WHEN	ItemID	=	8093	THEN	98
WHEN	ItemID	=	8094	THEN	99
WHEN	ItemID	=	8095	THEN	10
WHEN	ItemID	=	8096	THEN	91
WHEN	ItemID	=	8097	THEN	92
WHEN	ItemID	=	8098	THEN	93
WHEN	ItemID	=	8099	THEN	94
WHEN	ItemID	=	8100	THEN	95
WHEN	ItemID	=	8101	THEN	106
WHEN	ItemID	=	8102	THEN	107
WHEN	ItemID	=	8103	THEN	108
WHEN	ItemID	=	8104	THEN	109
WHEN	ItemID	=	8105	THEN	110
WHEN	ItemID	=	8106	THEN	101
WHEN	ItemID	=	8107	THEN	102
WHEN	ItemID	=	8108	THEN	103
WHEN	ItemID	=	8109	THEN	104
WHEN	ItemID	=	8110	THEN	105
WHEN	ItemID	=	5091	THEN	101
WHEN	ItemID	=	5092	THEN	102
WHEN	ItemID	=	5093	THEN	103
WHEN	ItemID	=	5094	THEN	104
WHEN	ItemID	=	5095	THEN	105
WHEN	ItemID	=	5096	THEN	106
WHEN	ItemID	=	5202	THEN	203
WHEN	ItemID	=	5203	THEN	202
WHEN	ItemID	=	5204	THEN	202
WHEN	ItemID	=	5101	THEN	91
WHEN	ItemID	=	5102	THEN	92
WHEN	ItemID	=	5103	THEN	93
WHEN	ItemID	=	5104	THEN	94
WHEN	ItemID	=	5105	THEN	95
WHEN	ItemID	=	5106	THEN	96
WHEN	ItemID	=	5151	THEN	156
WHEN	ItemID	=	5152	THEN	157
WHEN	ItemID	=	5153	THEN	158
WHEN	ItemID	=	5154	THEN	159
WHEN	ItemID	=	5155	THEN	160
WHEN	ItemID	=	13101	THEN	91
WHEN	ItemID	=	13102	THEN	92
WHEN	ItemID	=	13103	THEN	93
WHEN	ItemID	=	13104	THEN	94
WHEN	ItemID	=	13105	THEN	95
WHEN	ItemID	=	13106	THEN	96
WHEN	ItemID	=	13091	THEN	101
WHEN	ItemID	=	13092	THEN	102
WHEN	ItemID	=	13093	THEN	103
WHEN	ItemID	=	13094	THEN	104
WHEN	ItemID	=	13095	THEN	105
WHEN	ItemID	=	13096	THEN	106
WHEN	ItemID	=	8151	THEN	156
WHEN	ItemID	=	8152	THEN	157
WHEN	ItemID	=	8153	THEN	158
WHEN	ItemID	=	8154	THEN	159
WHEN	ItemID	=	8155	THEN	160
WHEN	ItemID	=	8156	THEN	151
WHEN	ItemID	=	8157	THEN	152
WHEN	ItemID	=	8158	THEN	163
WHEN	ItemID	=	8159	THEN	154
WHEN	ItemID	=	8160	THEN	155
WHEN	ItemID	=	13204	THEN	205
WHEN	ItemID	=	13205	THEN	204
WHEN	ItemID	=	13151	THEN	156
WHEN	ItemID	=	13152	THEN	157
WHEN	ItemID	=	13153	THEN	158
WHEN	ItemID	=	13154	THEN	159
WHEN	ItemID	=	13155	THEN	160
WHEN	ItemID	=	13156	THEN	151
WHEN	ItemID	=	13157	THEN	152
WHEN	ItemID	=	13158	THEN	153
WHEN	ItemID	=	13159	THEN	154
WHEN	ItemID	=	13160	THEN	155
WHEN	ItemID	=	5156	THEN	161
WHEN	ItemID	=	5157	THEN	152
WHEN	ItemID	=	5158	THEN	153
WHEN	ItemID	=	5159	THEN	154
WHEN	ItemID	=	5160	THEN	155
WHEN	ItemID	=	6091	THEN	96
WHEN	ItemID	=	6092	THEN	97
WHEN	ItemID	=	6093	THEN	98
WHEN	ItemID	=	6094	THEN	99
WHEN	ItemID	=	6095	THEN	100
WHEN	ItemID	=	6096	THEN	91
WHEN	ItemID	=	6097	THEN	92
WHEN	ItemID	=	6098	THEN	93
WHEN	ItemID	=	6099	THEN	94
WHEN	ItemID	=	6100	THEN	95
WHEN	ItemID	=	6101	THEN	106
WHEN	ItemID	=	6102	THEN	107
WHEN	ItemID	=	6103	THEN	108
WHEN	ItemID	=	6104	THEN	109
WHEN	ItemID	=	6105	THEN	110
WHEN	ItemID	=	6106	THEN	101
WHEN	ItemID	=	6107	THEN	102
WHEN	ItemID	=	6108	THEN	103
WHEN	ItemID	=	6109	THEN	104
WHEN	ItemID	=	6110	THEN	105
WHEN	ItemID	=	6201	THEN	202
WHEN	ItemID	=	6202	THEN	201
WHEN	ItemID	=	7107	THEN	97
WHEN	ItemID	=	7108	THEN	98
WHEN	ItemID	=	7109	THEN	99
WHEN	ItemID	=	7110	THEN	100
WHEN	ItemID	=	7097	THEN	107
WHEN	ItemID	=	7098	THEN	108
WHEN	ItemID	=	7099	THEN	109
WHEN	ItemID	=	7100	THEN	110
WHEN	ItemID	=	5251	THEN	252
WHEN	ItemID	=	5252	THEN	251
WHEN	ItemID	=	6151	THEN	156
WHEN	ItemID	=	6152	THEN	157
WHEN	ItemID	=	6153	THEN	158
WHEN	ItemID	=	6154	THEN	159
WHEN	ItemID	=	6155	THEN	160
WHEN	ItemID	=	6156	THEN	151
WHEN	ItemID	=	6157	THEN	152
WHEN	ItemID	=	6158	THEN	153
WHEN	ItemID	=	6159	THEN	154
WHEN	ItemID	=	6160	THEN	155
WHEN	ItemID	=	5107	THEN	97
WHEN	ItemID	=	5108	THEN	98
WHEN	ItemID	=	5109	THEN	99
WHEN	ItemID	=	5110	THEN	100
WHEN	ItemID	=	5097	THEN	107
WHEN	ItemID	=	5098	THEN	108
WHEN	ItemID	=	5099	THEN	109
WHEN	ItemID	=	5100	THEN	110
WHEN	ItemID	=	12244	THEN	245
WHEN	ItemID	=	12245	THEN	244
WHEN	ItemID	=	12246	THEN	247
WHEN	ItemID	=	12247	THEN	246
WHEN	ItemID	=	12248	THEN	249
WHEN	ItemID	=	12249	THEN	248
WHEN	ItemID	=	8251	THEN	252
WHEN	ItemID	=	8252	THEN	251
WHEN	ItemID	=	13253	THEN	254
WHEN	ItemID	=	13254	THEN	253
WHEN	ItemID	=	6251	THEN	252
WHEN	ItemID	=	6252	THEN	251
WHEN	ItemID	=	12117	THEN	107
WHEN	ItemID	=	12118	THEN	108
WHEN	ItemID	=	12119	THEN	109
WHEN	ItemID	=	12120	THEN	110
WHEN	ItemID	=	12107	THEN	117
WHEN	ItemID	=	12108	THEN	118
WHEN	ItemID	=	12109	THEN	119
WHEN	ItemID	=	12110	THEN	120
WHEN	ItemID	=	13097	THEN	107
WHEN	ItemID	=	13098	THEN	108
WHEN	ItemID	=	13099	THEN	109
WHEN	ItemID	=	13100	THEN	110
WHEN	ItemID	=	13107	THEN	97
WHEN	ItemID	=	13108	THEN	98
WHEN	ItemID	=	13109	THEN	99
WHEN	ItemID	=	13110	THEN	100
WHEN	ItemID	=	7251	THEN	252
WHEN	ItemID	=	7252	THEN	251
WHEN	ItemID	=	13111	THEN	116
WHEN	ItemID	=	13112	THEN	117
WHEN	ItemID	=	13113	THEN	118
WHEN	ItemID	=	13114	THEN	119
WHEN	ItemID	=	13115	THEN	120
WHEN	ItemID	=	13116	THEN	111
WHEN	ItemID	=	13117	THEN	112
WHEN	ItemID	=	13118	THEN	113
WHEN	ItemID	=	13119	THEN	114
WHEN	ItemID	=	13120	THEN	115
WHEN	ItemID	=	13121	THEN	126
WHEN	ItemID	=	13122	THEN	127
WHEN	ItemID	=	13123	THEN	128
WHEN	ItemID	=	13124	THEN	129
WHEN	ItemID	=	13125	THEN	130
WHEN	ItemID	=	13126	THEN	121
WHEN	ItemID	=	13127	THEN	122
WHEN	ItemID	=	13128	THEN	123
WHEN	ItemID	=	13129	THEN	124
WHEN	ItemID	=	13130	THEN	125
WHEN	ItemID	=	12121	THEN	126
WHEN	ItemID	=	12122	THEN	127
WHEN	ItemID	=	12123	THEN	128
WHEN	ItemID	=	12124	THEN	129
WHEN	ItemID	=	12125	THEN	130
WHEN	ItemID	=	12126	THEN	121
WHEN	ItemID	=	12127	THEN	122
WHEN	ItemID	=	12128	THEN	123
WHEN	ItemID	=	12129	THEN	124
WHEN	ItemID	=	12130	THEN	125
WHEN	ItemID	=	12131	THEN	136
WHEN	ItemID	=	12132	THEN	137
WHEN	ItemID	=	12133	THEN	138
WHEN	ItemID	=	12134	THEN	139
WHEN	ItemID	=	12135	THEN	140
WHEN	ItemID	=	12136	THEN	131
WHEN	ItemID	=	12137	THEN	132
WHEN	ItemID	=	12138	THEN	133
WHEN	ItemID	=	12139	THEN	134
WHEN	ItemID	=	12140	THEN	135
WHEN	ItemID	=	5111	THEN	116
WHEN	ItemID	=	5112	THEN	117
WHEN	ItemID	=	5113	THEN	118
WHEN	ItemID	=	5114	THEN	119
WHEN	ItemID	=	5115	THEN	120
WHEN	ItemID	=	5116	THEN	111
WHEN	ItemID	=	5117	THEN	112
WHEN	ItemID	=	5118	THEN	113
WHEN	ItemID	=	5119	THEN	114
WHEN	ItemID	=	5120	THEN	115
WHEN	ItemID	=	5121	THEN	126
WHEN	ItemID	=	5122	THEN	127
WHEN	ItemID	=	5123	THEN	128
WHEN	ItemID	=	5124	THEN	129
WHEN	ItemID	=	5125	THEN	130
WHEN	ItemID	=	5126	THEN	121
WHEN	ItemID	=	5127	THEN	122
WHEN	ItemID	=	5128	THEN	123
WHEN	ItemID	=	5129	THEN	124
WHEN	ItemID	=	5130	THEN	125
WHEN	ItemID	=	6111	THEN	116
WHEN	ItemID	=	6112	THEN	117
WHEN	ItemID	=	6113	THEN	118
WHEN	ItemID	=	6114	THEN	119
WHEN	ItemID	=	6115	THEN	120
WHEN	ItemID	=	6116	THEN	111
WHEN	ItemID	=	6117	THEN	112
WHEN	ItemID	=	6118	THEN	113
WHEN	ItemID	=	6119	THEN	114
WHEN	ItemID	=	6120	THEN	115
WHEN	ItemID	=	6121	THEN	126
WHEN	ItemID	=	6122	THEN	127
WHEN	ItemID	=	6123	THEN	128
WHEN	ItemID	=	6124	THEN	129
WHEN	ItemID	=	6125	THEN	130
WHEN	ItemID	=	6126	THEN	121
WHEN	ItemID	=	6127	THEN	122
WHEN	ItemID	=	6128	THEN	123
WHEN	ItemID	=	6129	THEN	124
WHEN	ItemID	=	6130	THEN	125
WHEN	ItemID	=	7111	THEN	116
WHEN	ItemID	=	7112	THEN	117
WHEN	ItemID	=	7113	THEN	118
WHEN	ItemID	=	7114	THEN	119
WHEN	ItemID	=	7115	THEN	120
WHEN	ItemID	=	7116	THEN	111
WHEN	ItemID	=	7117	THEN	112
WHEN	ItemID	=	7118	THEN	113
WHEN	ItemID	=	7119	THEN	114
WHEN	ItemID	=	7120	THEN	115
WHEN	ItemID	=	7121	THEN	126
WHEN	ItemID	=	7122	THEN	127
WHEN	ItemID	=	7123	THEN	128
WHEN	ItemID	=	7124	THEN	129
WHEN	ItemID	=	7125	THEN	130
WHEN	ItemID	=	7126	THEN	121
WHEN	ItemID	=	7127	THEN	122
WHEN	ItemID	=	7128	THEN	123
WHEN	ItemID	=	7129	THEN	124
WHEN	ItemID	=	7130	THEN	125
WHEN	ItemID	=	8111	THEN	116
WHEN	ItemID	=	8112	THEN	117
WHEN	ItemID	=	8113	THEN	118
WHEN	ItemID	=	8114	THEN	119
WHEN	ItemID	=	8115	THEN	120
WHEN	ItemID	=	8116	THEN	111
WHEN	ItemID	=	8117	THEN	112
WHEN	ItemID	=	8118	THEN	113
WHEN	ItemID	=	8119	THEN	114
WHEN	ItemID	=	8120	THEN	115
WHEN	ItemID	=	8121	THEN	126
WHEN	ItemID	=	8122	THEN	127
WHEN	ItemID	=	8123	THEN	128
WHEN	ItemID	=	8124	THEN	129
WHEN	ItemID	=	8125	THEN	130
WHEN	ItemID	=	8126	THEN	121
WHEN	ItemID	=	8127	THEN	122
WHEN	ItemID	=	8128	THEN	123
WHEN	ItemID	=	8129	THEN	124
WHEN	ItemID	=	8130	THEN	125
WHEN	ItemID	=	8131	THEN	136
WHEN	ItemID	=	8132	THEN	137
WHEN	ItemID	=	8133	THEN	138
WHEN	ItemID	=	8134	THEN	139
WHEN	ItemID	=	8135	THEN	140
WHEN	ItemID	=	8136	THEN	131
WHEN	ItemID	=	8137	THEN	132
WHEN	ItemID	=	8138	THEN	133
WHEN	ItemID	=	8139	THEN	134
WHEN	ItemID	=	8140	THEN	135
WHEN	ItemID	=	8141	THEN	146
WHEN	ItemID	=	8142	THEN	147
WHEN	ItemID	=	8143	THEN	148
WHEN	ItemID	=	8144	THEN	149
WHEN	ItemID	=	8145	THEN	150
WHEN	ItemID	=	8146	THEN	141
WHEN	ItemID	=	8147	THEN	142
WHEN	ItemID	=	8148	THEN	143
WHEN	ItemID	=	8149	THEN	144
WHEN	ItemID	=	8150	THEN	145
WHEN	ItemID	=	7131	THEN	136
WHEN	ItemID	=	7132	THEN	137
WHEN	ItemID	=	7133	THEN	138
WHEN	ItemID	=	7134	THEN	139
WHEN	ItemID	=	7135	THEN	140
WHEN	ItemID	=	7136	THEN	131
WHEN	ItemID	=	7137	THEN	132
WHEN	ItemID	=	7138	THEN	133
WHEN	ItemID	=	7139	THEN	134
WHEN	ItemID	=	7140	THEN	135
WHEN	ItemID	=	7141	THEN	146
WHEN	ItemID	=	7142	THEN	147
WHEN	ItemID	=	7143	THEN	148
WHEN	ItemID	=	7144	THEN	149
WHEN	ItemID	=	7145	THEN	150
WHEN	ItemID	=	7146	THEN	141
WHEN	ItemID	=	7147	THEN	142
WHEN	ItemID	=	7148	THEN	143
WHEN	ItemID	=	7149	THEN	144
WHEN	ItemID	=	7150	THEN	145
WHEN	ItemID	=	6131	THEN	136
WHEN	ItemID	=	6132	THEN	137
WHEN	ItemID	=	6133	THEN	138
WHEN	ItemID	=	6134	THEN	139
WHEN	ItemID	=	6135	THEN	140
WHEN	ItemID	=	6136	THEN	131
WHEN	ItemID	=	6137	THEN	132
WHEN	ItemID	=	6138	THEN	133
WHEN	ItemID	=	6139	THEN	134
WHEN	ItemID	=	6140	THEN	135
WHEN	ItemID	=	6141	THEN	146
WHEN	ItemID	=	6142	THEN	147
WHEN	ItemID	=	6143	THEN	148
WHEN	ItemID	=	6144	THEN	149
WHEN	ItemID	=	6145	THEN	150
WHEN	ItemID	=	6146	THEN	141
WHEN	ItemID	=	6147	THEN	142
WHEN	ItemID	=	6148	THEN	143
WHEN	ItemID	=	6149	THEN	144
WHEN	ItemID	=	6150	THEN	145
WHEN	ItemID	=	5131	THEN	136
WHEN	ItemID	=	5132	THEN	137
WHEN	ItemID	=	5133	THEN	138
WHEN	ItemID	=	5134	THEN	139
WHEN	ItemID	=	5135	THEN	140
WHEN	ItemID	=	5136	THEN	131
WHEN	ItemID	=	5137	THEN	132
WHEN	ItemID	=	5138	THEN	133
WHEN	ItemID	=	5139	THEN	134
WHEN	ItemID	=	5140	THEN	135
WHEN	ItemID	=	5141	THEN	146
WHEN	ItemID	=	5142	THEN	147
WHEN	ItemID	=	5143	THEN	148
WHEN	ItemID	=	5144	THEN	149
WHEN	ItemID	=	5145	THEN	150
WHEN	ItemID	=	5146	THEN	141
WHEN	ItemID	=	5147	THEN	142
WHEN	ItemID	=	5148	THEN	143
WHEN	ItemID	=	5149	THEN	144
WHEN	ItemID	=	5150	THEN	145
WHEN	ItemID	=	12141	THEN	146
WHEN	ItemID	=	12142	THEN	147
WHEN	ItemID	=	12143	THEN	148
WHEN	ItemID	=	12144	THEN	149
WHEN	ItemID	=	12145	THEN	150
WHEN	ItemID	=	12146	THEN	141
WHEN	ItemID	=	12147	THEN	142
WHEN	ItemID	=	12148	THEN	143
WHEN	ItemID	=	12149	THEN	144
WHEN	ItemID	=	12150	THEN	145
WHEN	ItemID	=	12151	THEN	156
WHEN	ItemID	=	12152	THEN	157
WHEN	ItemID	=	12153	THEN	158
WHEN	ItemID	=	12154	THEN	159
WHEN	ItemID	=	12155	THEN	160
WHEN	ItemID	=	12156	THEN	151
WHEN	ItemID	=	12157	THEN	152
WHEN	ItemID	=	12158	THEN	153
WHEN	ItemID	=	12159	THEN	154
WHEN	ItemID	=	12160	THEN	155
WHEN	ItemID	=	13131	THEN	136
WHEN	ItemID	=	13132	THEN	137
WHEN	ItemID	=	13133	THEN	138
WHEN	ItemID	=	13134	THEN	139
WHEN	ItemID	=	13135	THEN	140
WHEN	ItemID	=	13136	THEN	131
WHEN	ItemID	=	13137	THEN	132
WHEN	ItemID	=	13138	THEN	133
WHEN	ItemID	=	13139	THEN	134
WHEN	ItemID	=	13140	THEN	135
WHEN	ItemID	=	13141	THEN	146
WHEN	ItemID	=	13142	THEN	147
WHEN	ItemID	=	13143	THEN	148
WHEN	ItemID	=	13144	THEN	149
WHEN	ItemID	=	13145	THEN	150
WHEN	ItemID	=	13146	THEN	141
WHEN	ItemID	=	13147	THEN	142
WHEN	ItemID	=	13148	THEN	143
WHEN	ItemID	=	13149	THEN	144
WHEN	ItemID	=	13150	THEN	145
WHEN	ItemID	=	12213	THEN	215
WHEN	ItemID	=	12214	THEN	215
WHEN	ItemID	=	12215	THEN	213
WHEN	ItemID	=	7213	THEN	206
WHEN	ItemID	=	7206	THEN	213
WHEN	ItemID	=	6203	THEN	204
WHEN	ItemID	=	6204	THEN	203
WHEN	ItemID	=	6182	THEN	166
WHEN	ItemID	=	7166	THEN	182
WHEN	ItemID	=	6166	THEN	182
WHEN	ItemID	=	5182	THEN	166
WHEN	ItemID	=	5166	THEN	182
WHEN	ItemID	=	13166	THEN	182
WHEN	ItemID	=	13182	THEN	166
WHEN	ItemID	=	8166	THEN	182
WHEN	ItemID	=	7182	THEN	166
WHEN	ItemID	=	12188	THEN	176
WHEN	ItemID	=	8182	THEN	166
WHEN	ItemID	=	12176	THEN	188
WHEN	ItemID	=	8186	THEN	170
WHEN	ItemID	=	8170	THEN	186
WHEN	ItemID	=	13186	THEN	170
WHEN	ItemID	=	13170	THEN	186
WHEN	ItemID	=	5170	THEN	186
WHEN	ItemID	=	5186	THEN	170
WHEN	ItemID	=	7170	THEN	186
WHEN	ItemID	=	7186	THEN	170
WHEN	ItemID	=	12177	THEN	189
WHEN	ItemID	=	12178	THEN	190
WHEN	ItemID	=	12189	THEN	177
WHEN	ItemID	=	12190	THEN	178
WHEN	ItemID	=	6186	THEN	170
WHEN	ItemID	=	6170	THEN	186
WHEN	ItemID	=	5190	THEN	174
WHEN	ItemID	=	5174	THEN	190
WHEN	ItemID	=	8190	THEN	174
WHEN	ItemID	=	8174	THEN	190
WHEN	ItemID	=	13174	THEN	190
WHEN	ItemID	=	13190	THEN	174
WHEN	ItemID	=	7190	THEN	174
WHEN	ItemID	=	12179	THEN	191
WHEN	ItemID	=	12180	THEN	192
WHEN	ItemID	=	12191	THEN	179
WHEN	ItemID	=	12192	THEN	180
WHEN	ItemID	=	6174	THEN	190
WHEN	ItemID	=	6190	THEN	174
WHEN	ItemID	=	7174	THEN	190
WHEN	ItemID	=	7178	THEN	194
WHEN	ItemID	=	6194	THEN	178
WHEN	ItemID	=	6205	THEN	207
WHEN	ItemID	=	6178	THEN	194
WHEN	ItemID	=	5178	THEN	194
WHEN	ItemID	=	5194	THEN	178
WHEN	ItemID	=	12193	THEN	181
WHEN	ItemID	=	12194	THEN	182
WHEN	ItemID	=	12181	THEN	193
WHEN	ItemID	=	12182	THEN	194
WHEN	ItemID	=	8194	THEN	178
WHEN	ItemID	=	7194	THEN	178
WHEN	ItemID	=	6207	THEN	205
WHEN	ItemID	=	7214	THEN	216
WHEN	ItemID	=	8178	THEN	194
WHEN	ItemID	=	7216	THEN	214
WHEN	ItemID	=	13194	THEN	178
WHEN	ItemID	=	13178	THEN	194
WHEN	ItemID	=	12230	THEN	228
WHEN	ItemID	=	12228	THEN	230
ELSE [TypeID]
END)
WHERE CharID IN (SELECT [CharID]FROM #CharTemp);
PRINT 'Items changed'
GOTO ItemUpdate2;

ItemUpdate2:
UPDATE PS_GameData.dbo.CharItems
SET [Type]=(
CASE Type
WHEN 1 THEN 3
 WHEN 3 THEN 1
 WHEN 2 THEN 4
 WHEN 4 THEN 2
 WHEN 11 THEN 14
 WHEN 14 THEN 11
 WHEN 16 THEN 31
 WHEN 31 THEN 16
 WHEN 17 THEN 32
 WHEN 32 THEN 17
 WHEN 18 THEN 33
 WHEN 33 THEN 18
 WHEN 19 THEN 34
 WHEN 34 THEN 19
 WHEN 20 THEN 35
 WHEN 35 THEN 20
 WHEN 21 THEN 36
 WHEN 36 THEN 21
 WHEN 24 THEN 39
 WHEN 39 THEN 24
 ELSE [Type]
END)
WHERE CharID IN (SELECT [CharID]FROM #CharTemp);
PRINT 'Items changed'

UPDATE PS_GameData.dbo.CharItems
SET [TypeID]=
(CASE
WHEN	ItemID	=	13206	THEN	201
WHEN	ItemID	=	13207	THEN	205
WHEN	ItemID	=	13208	THEN	206
WHEN	ItemID	=	13203	THEN	204
WHEN	ItemID	=	11201	THEN	206
WHEN	ItemID	=	11205	THEN	207
WHEN	ItemID	=	11206	THEN	208
WHEN	ItemID	=	11204	THEN	203
ELSE [TypeID]
END),
[Type]=
(CASE
WHEN	ItemID	=	13206	THEN	11
WHEN	ItemID	=	13207	THEN	11
WHEN	ItemID	=	13208	THEN	11
WHEN	ItemID	=	13203	THEN	11
WHEN	ItemID	=	11201	THEN	13
WHEN	ItemID	=	11205	THEN	13
WHEN	ItemID	=	11206	THEN	13
WHEN	ItemID	=	11204	THEN	13
ELSE [Type]
END)
WHERE CharID IN (SELECT [CharID]FROM #CharTemp)
and ItemID in (13206,13207,13208,13203,11201,11205,11206,11204);
PRINT 'Items changed'
GOTO WHUpdate;

WHUpdate:
UPDATE PS_GameData.dbo.UserStoredItems
SET [TypeID]=
(CASE
WHEN	ItemID	=	6001	THEN	6
WHEN	ItemID	=	6002	THEN	7
WHEN	ItemID	=	6006	THEN	1
WHEN	ItemID	=	6007	THEN	2
WHEN	ItemID	=	5001	THEN	6
WHEN	ItemID	=	5002	THEN	7
WHEN	ItemID	=	5006	THEN	1
WHEN	ItemID	=	5007	THEN	2
WHEN	ItemID	=	7001	THEN	6
WHEN	ItemID	=	7002	THEN	7
WHEN	ItemID	=	7006	THEN	1
WHEN	ItemID	=	7007	THEN	2
WHEN	ItemID	=	8001	THEN	6
WHEN	ItemID	=	8002	THEN	7
WHEN	ItemID	=	8006	THEN	1
WHEN	ItemID	=	8007	THEN	2
WHEN	ItemID	=	12001	THEN	6
WHEN	ItemID	=	12002	THEN	7
WHEN	ItemID	=	12006	THEN	1
WHEN	ItemID	=	12007	THEN	2
WHEN	ItemID	=	13001	THEN	6
WHEN	ItemID	=	13002	THEN	7
WHEN	ItemID	=	13006	THEN	1
WHEN	ItemID	=	13007	THEN	2
WHEN	ItemID	=	7011	THEN	16
WHEN	ItemID	=	7012	THEN	17
WHEN	ItemID	=	7013	THEN	18
WHEN	ItemID	=	7016	THEN	11
WHEN	ItemID	=	7017	THEN	12
WHEN	ItemID	=	7018	THEN	13
WHEN	ItemID	=	8011	THEN	16
WHEN	ItemID	=	8012	THEN	17
WHEN	ItemID	=	8013	THEN	18
WHEN	ItemID	=	8016	THEN	11
WHEN	ItemID	=	8017	THEN	12
WHEN	ItemID	=	8018	THEN	13
WHEN	ItemID	=	5011	THEN	16
WHEN	ItemID	=	5012	THEN	17
WHEN	ItemID	=	5013	THEN	18
WHEN	ItemID	=	5016	THEN	11
WHEN	ItemID	=	5017	THEN	12
WHEN	ItemID	=	5018	THEN	13
WHEN	ItemID	=	12011	THEN	16
WHEN	ItemID	=	12012	THEN	17
WHEN	ItemID	=	12013	THEN	18
WHEN	ItemID	=	12016	THEN	11
WHEN	ItemID	=	12017	THEN	12
WHEN	ItemID	=	12018	THEN	13
WHEN	ItemID	=	13011	THEN	16
WHEN	ItemID	=	13012	THEN	17
WHEN	ItemID	=	13013	THEN	18
WHEN	ItemID	=	13016	THEN	11
WHEN	ItemID	=	13017	THEN	12
WHEN	ItemID	=	13018	THEN	13
WHEN	ItemID	=	6011	THEN	16
WHEN	ItemID	=	6012	THEN	17
WHEN	ItemID	=	6013	THEN	18
WHEN	ItemID	=	6016	THEN	11
WHEN	ItemID	=	6017	THEN	12
WHEN	ItemID	=	6018	THEN	13
WHEN	ItemID	=	7021	THEN	26
WHEN	ItemID	=	7022	THEN	27
WHEN	ItemID	=	7023	THEN	28
WHEN	ItemID	=	7024	THEN	29
WHEN	ItemID	=	7026	THEN	21
WHEN	ItemID	=	7027	THEN	22
WHEN	ItemID	=	7028	THEN	23
WHEN	ItemID	=	7029	THEN	24
WHEN	ItemID	=	12021	THEN	26
WHEN	ItemID	=	12022	THEN	27
WHEN	ItemID	=	12023	THEN	28
WHEN	ItemID	=	12024	THEN	29
WHEN	ItemID	=	12026	THEN	21
WHEN	ItemID	=	12027	THEN	22
WHEN	ItemID	=	12028	THEN	23
WHEN	ItemID	=	12029	THEN	24
WHEN	ItemID	=	8021	THEN	26
WHEN	ItemID	=	8022	THEN	27
WHEN	ItemID	=	8023	THEN	28
WHEN	ItemID	=	8024	THEN	29
WHEN	ItemID	=	8026	THEN	21
WHEN	ItemID	=	8027	THEN	22
WHEN	ItemID	=	8028	THEN	23
WHEN	ItemID	=	8029	THEN	24
WHEN	ItemID	=	5021	THEN	26
WHEN	ItemID	=	5022	THEN	27
WHEN	ItemID	=	5023	THEN	28
WHEN	ItemID	=	5024	THEN	29
WHEN	ItemID	=	5026	THEN	21
WHEN	ItemID	=	5027	THEN	22
WHEN	ItemID	=	5028	THEN	23
WHEN	ItemID	=	5029	THEN	24
WHEN	ItemID	=	13021	THEN	26
WHEN	ItemID	=	13022	THEN	27
WHEN	ItemID	=	13023	THEN	28
WHEN	ItemID	=	13024	THEN	29
WHEN	ItemID	=	13026	THEN	21
WHEN	ItemID	=	13027	THEN	22
WHEN	ItemID	=	13028	THEN	23
WHEN	ItemID	=	13029	THEN	24
WHEN	ItemID	=	6021	THEN	26
WHEN	ItemID	=	6022	THEN	27
WHEN	ItemID	=	6023	THEN	28
WHEN	ItemID	=	6024	THEN	29
WHEN	ItemID	=	6026	THEN	21
WHEN	ItemID	=	6027	THEN	22
WHEN	ItemID	=	6028	THEN	23
WHEN	ItemID	=	6029	THEN	24
WHEN	ItemID	=	6031	THEN	36
WHEN	ItemID	=	6032	THEN	37
WHEN	ItemID	=	6033	THEN	38
WHEN	ItemID	=	6034	THEN	39
WHEN	ItemID	=	6035	THEN	40
WHEN	ItemID	=	6036	THEN	31
WHEN	ItemID	=	6037	THEN	32
WHEN	ItemID	=	6038	THEN	33
WHEN	ItemID	=	6039	THEN	34
WHEN	ItemID	=	6040	THEN	35
WHEN	ItemID	=	5031	THEN	36
WHEN	ItemID	=	5032	THEN	37
WHEN	ItemID	=	5033	THEN	38
WHEN	ItemID	=	5034	THEN	39
WHEN	ItemID	=	5035	THEN	40
WHEN	ItemID	=	5036	THEN	31
WHEN	ItemID	=	5037	THEN	32
WHEN	ItemID	=	5038	THEN	33
WHEN	ItemID	=	5039	THEN	34
WHEN	ItemID	=	5040	THEN	35
WHEN	ItemID	=	8031	THEN	36
WHEN	ItemID	=	8032	THEN	37
WHEN	ItemID	=	8033	THEN	38
WHEN	ItemID	=	8034	THEN	39
WHEN	ItemID	=	8035	THEN	40
WHEN	ItemID	=	8036	THEN	31
WHEN	ItemID	=	8037	THEN	32
WHEN	ItemID	=	8038	THEN	33
WHEN	ItemID	=	8039	THEN	34
WHEN	ItemID	=	8040	THEN	35
WHEN	ItemID	=	7031	THEN	36
WHEN	ItemID	=	7032	THEN	37
WHEN	ItemID	=	7033	THEN	38
WHEN	ItemID	=	7034	THEN	39
WHEN	ItemID	=	7035	THEN	40
WHEN	ItemID	=	7036	THEN	31
WHEN	ItemID	=	7037	THEN	32
WHEN	ItemID	=	7038	THEN	33
WHEN	ItemID	=	7039	THEN	34
WHEN	ItemID	=	7040	THEN	35
WHEN	ItemID	=	13031	THEN	36
WHEN	ItemID	=	13032	THEN	37
WHEN	ItemID	=	13033	THEN	38
WHEN	ItemID	=	13034	THEN	39
WHEN	ItemID	=	13035	THEN	40
WHEN	ItemID	=	13036	THEN	31
WHEN	ItemID	=	13037	THEN	32
WHEN	ItemID	=	13038	THEN	33
WHEN	ItemID	=	13039	THEN	34
WHEN	ItemID	=	13040	THEN	35
WHEN	ItemID	=	12031	THEN	36
WHEN	ItemID	=	12032	THEN	37
WHEN	ItemID	=	12033	THEN	38
WHEN	ItemID	=	12034	THEN	39
WHEN	ItemID	=	12035	THEN	40
WHEN	ItemID	=	12036	THEN	31
WHEN	ItemID	=	12037	THEN	32
WHEN	ItemID	=	12038	THEN	33
WHEN	ItemID	=	12039	THEN	34
WHEN	ItemID	=	12040	THEN	35
WHEN	ItemID	=	12041	THEN	46
WHEN	ItemID	=	12042	THEN	47
WHEN	ItemID	=	12043	THEN	48
WHEN	ItemID	=	12044	THEN	49
WHEN	ItemID	=	12045	THEN	50
WHEN	ItemID	=	12046	THEN	41
WHEN	ItemID	=	12047	THEN	42
WHEN	ItemID	=	12048	THEN	43
WHEN	ItemID	=	12049	THEN	44
WHEN	ItemID	=	12050	THEN	45
WHEN	ItemID	=	7041	THEN	46
WHEN	ItemID	=	7042	THEN	47
WHEN	ItemID	=	7043	THEN	48
WHEN	ItemID	=	7044	THEN	49
WHEN	ItemID	=	7045	THEN	50
WHEN	ItemID	=	7046	THEN	41
WHEN	ItemID	=	7047	THEN	42
WHEN	ItemID	=	7048	THEN	43
WHEN	ItemID	=	7049	THEN	44
WHEN	ItemID	=	7050	THEN	45
WHEN	ItemID	=	8041	THEN	46
WHEN	ItemID	=	8042	THEN	47
WHEN	ItemID	=	8043	THEN	48
WHEN	ItemID	=	8044	THEN	49
WHEN	ItemID	=	8045	THEN	50
WHEN	ItemID	=	8046	THEN	41
WHEN	ItemID	=	8047	THEN	42
WHEN	ItemID	=	8048	THEN	43
WHEN	ItemID	=	8049	THEN	44
WHEN	ItemID	=	8050	THEN	45
WHEN	ItemID	=	5041	THEN	46
WHEN	ItemID	=	5042	THEN	47
WHEN	ItemID	=	5043	THEN	48
WHEN	ItemID	=	5044	THEN	49
WHEN	ItemID	=	5045	THEN	50
WHEN	ItemID	=	5046	THEN	41
WHEN	ItemID	=	5047	THEN	42
WHEN	ItemID	=	5048	THEN	43
WHEN	ItemID	=	5049	THEN	44
WHEN	ItemID	=	5050	THEN	45
WHEN	ItemID	=	13041	THEN	46
WHEN	ItemID	=	13042	THEN	47
WHEN	ItemID	=	13043	THEN	48
WHEN	ItemID	=	13044	THEN	49
WHEN	ItemID	=	13045	THEN	50
WHEN	ItemID	=	13046	THEN	41
WHEN	ItemID	=	13047	THEN	42
WHEN	ItemID	=	13048	THEN	43
WHEN	ItemID	=	13049	THEN	44
WHEN	ItemID	=	13050	THEN	45
WHEN	ItemID	=	12201	THEN	203
WHEN	ItemID	=	12202	THEN	204
WHEN	ItemID	=	12203	THEN	201
WHEN	ItemID	=	12204	THEN	202
WHEN	ItemID	=	13201	THEN	202
WHEN	ItemID	=	13202	THEN	201
WHEN	ItemID	=	12051	THEN	56
WHEN	ItemID	=	12052	THEN	57
WHEN	ItemID	=	12053	THEN	58
WHEN	ItemID	=	12054	THEN	59
WHEN	ItemID	=	12055	THEN	60
WHEN	ItemID	=	12056	THEN	51
WHEN	ItemID	=	12057	THEN	52
WHEN	ItemID	=	12058	THEN	53
WHEN	ItemID	=	12059	THEN	54
WHEN	ItemID	=	12060	THEN	55
WHEN	ItemID	=	6041	THEN	46
WHEN	ItemID	=	6042	THEN	47
WHEN	ItemID	=	6043	THEN	48
WHEN	ItemID	=	6044	THEN	49
WHEN	ItemID	=	6045	THEN	50
WHEN	ItemID	=	6046	THEN	41
WHEN	ItemID	=	6047	THEN	42
WHEN	ItemID	=	6048	THEN	43
WHEN	ItemID	=	6049	THEN	44
WHEN	ItemID	=	6050	THEN	45
WHEN	ItemID	=	6051	THEN	56
WHEN	ItemID	=	6052	THEN	57
WHEN	ItemID	=	6053	THEN	58
WHEN	ItemID	=	6054	THEN	59
WHEN	ItemID	=	6055	THEN	60
WHEN	ItemID	=	6056	THEN	51
WHEN	ItemID	=	6057	THEN	52
WHEN	ItemID	=	6058	THEN	53
WHEN	ItemID	=	6059	THEN	54
WHEN	ItemID	=	6060	THEN	55
WHEN	ItemID	=	5051	THEN	56
WHEN	ItemID	=	5052	THEN	57
WHEN	ItemID	=	5053	THEN	58
WHEN	ItemID	=	5054	THEN	59
WHEN	ItemID	=	5055	THEN	60
WHEN	ItemID	=	5056	THEN	51
WHEN	ItemID	=	5057	THEN	52
WHEN	ItemID	=	5058	THEN	53
WHEN	ItemID	=	5059	THEN	54
WHEN	ItemID	=	5060	THEN	55
WHEN	ItemID	=	8051	THEN	56
WHEN	ItemID	=	8052	THEN	57
WHEN	ItemID	=	8053	THEN	58
WHEN	ItemID	=	8054	THEN	59
WHEN	ItemID	=	8055	THEN	60
WHEN	ItemID	=	8056	THEN	51
WHEN	ItemID	=	8057	THEN	52
WHEN	ItemID	=	8058	THEN	53
WHEN	ItemID	=	8059	THEN	54
WHEN	ItemID	=	8060	THEN	55
WHEN	ItemID	=	7051	THEN	56
WHEN	ItemID	=	7052	THEN	57
WHEN	ItemID	=	7053	THEN	58
WHEN	ItemID	=	7054	THEN	59
WHEN	ItemID	=	7055	THEN	60
WHEN	ItemID	=	7056	THEN	51
WHEN	ItemID	=	7057	THEN	52
WHEN	ItemID	=	7058	THEN	53
WHEN	ItemID	=	7059	THEN	54
WHEN	ItemID	=	7060	THEN	55
WHEN	ItemID	=	12061	THEN	66
WHEN	ItemID	=	12062	THEN	67
WHEN	ItemID	=	12063	THEN	68
WHEN	ItemID	=	12064	THEN	69
WHEN	ItemID	=	12066	THEN	61
WHEN	ItemID	=	12067	THEN	62
WHEN	ItemID	=	12068	THEN	63
WHEN	ItemID	=	12069	THEN	64
WHEN	ItemID	=	13051	THEN	56
WHEN	ItemID	=	13052	THEN	57
WHEN	ItemID	=	13053	THEN	58
WHEN	ItemID	=	13054	THEN	59
WHEN	ItemID	=	13055	THEN	60
WHEN	ItemID	=	13056	THEN	51
WHEN	ItemID	=	13057	THEN	52
WHEN	ItemID	=	13058	THEN	53
WHEN	ItemID	=	13059	THEN	54
WHEN	ItemID	=	13060	THEN	55
WHEN	ItemID	=	12070	THEN	65
WHEN	ItemID	=	12065	THEN	70
WHEN	ItemID	=	7201	THEN	201
WHEN	ItemID	=	7061	THEN	66
WHEN	ItemID	=	7062	THEN	67
WHEN	ItemID	=	7063	THEN	68
WHEN	ItemID	=	7064	THEN	69
WHEN	ItemID	=	7065	THEN	70
WHEN	ItemID	=	7066	THEN	61
WHEN	ItemID	=	7067	THEN	62
WHEN	ItemID	=	7068	THEN	63
WHEN	ItemID	=	7069	THEN	64
WHEN	ItemID	=	7070	THEN	65
WHEN	ItemID	=	5201	THEN	201
WHEN	ItemID	=	5061	THEN	66
WHEN	ItemID	=	5062	THEN	67
WHEN	ItemID	=	5063	THEN	68
WHEN	ItemID	=	5064	THEN	69
WHEN	ItemID	=	5065	THEN	70
WHEN	ItemID	=	5066	THEN	61
WHEN	ItemID	=	5067	THEN	62
WHEN	ItemID	=	5068	THEN	63
WHEN	ItemID	=	5069	THEN	64
WHEN	ItemID	=	5070	THEN	65
WHEN	ItemID	=	8061	THEN	66
WHEN	ItemID	=	8062	THEN	67
WHEN	ItemID	=	8063	THEN	68
WHEN	ItemID	=	8064	THEN	69
WHEN	ItemID	=	8065	THEN	70
WHEN	ItemID	=	8066	THEN	61
WHEN	ItemID	=	8067	THEN	62
WHEN	ItemID	=	8068	THEN	63
WHEN	ItemID	=	8069	THEN	64
WHEN	ItemID	=	8070	THEN	65
WHEN	ItemID	=	12071	THEN	76
WHEN	ItemID	=	12072	THEN	77
WHEN	ItemID	=	12073	THEN	78
WHEN	ItemID	=	12074	THEN	79
WHEN	ItemID	=	12075	THEN	80
WHEN	ItemID	=	12076	THEN	71
WHEN	ItemID	=	12077	THEN	72
WHEN	ItemID	=	12078	THEN	73
WHEN	ItemID	=	12079	THEN	74
WHEN	ItemID	=	12080	THEN	75
WHEN	ItemID	=	13061	THEN	66
WHEN	ItemID	=	13062	THEN	67
WHEN	ItemID	=	13063	THEN	68
WHEN	ItemID	=	13064	THEN	69
WHEN	ItemID	=	13065	THEN	70
WHEN	ItemID	=	13066	THEN	61
WHEN	ItemID	=	13067	THEN	62
WHEN	ItemID	=	13068	THEN	63
WHEN	ItemID	=	13069	THEN	64
WHEN	ItemID	=	13070	THEN	65
WHEN	ItemID	=	6061	THEN	66
WHEN	ItemID	=	6062	THEN	67
WHEN	ItemID	=	6063	THEN	68
WHEN	ItemID	=	6064	THEN	69
WHEN	ItemID	=	6065	THEN	70
WHEN	ItemID	=	6066	THEN	61
WHEN	ItemID	=	6067	THEN	62
WHEN	ItemID	=	6068	THEN	63
WHEN	ItemID	=	6069	THEN	64
WHEN	ItemID	=	6070	THEN	65
WHEN	ItemID	=	13251	THEN	252
WHEN	ItemID	=	13252	THEN	251
WHEN	ItemID	=	12251	THEN	253
WHEN	ItemID	=	12252	THEN	254
WHEN	ItemID	=	12253	THEN	251
WHEN	ItemID	=	12254	THEN	252
WHEN	ItemID	=	12081	THEN	86
WHEN	ItemID	=	12082	THEN	87
WHEN	ItemID	=	12083	THEN	88
WHEN	ItemID	=	12084	THEN	89
WHEN	ItemID	=	12085	THEN	90
WHEN	ItemID	=	12086	THEN	81
WHEN	ItemID	=	12087	THEN	82
WHEN	ItemID	=	12088	THEN	83
WHEN	ItemID	=	12089	THEN	84
WHEN	ItemID	=	12090	THEN	85
WHEN	ItemID	=	7071	THEN	76
WHEN	ItemID	=	7072	THEN	77
WHEN	ItemID	=	7073	THEN	78
WHEN	ItemID	=	7074	THEN	79
WHEN	ItemID	=	7075	THEN	80
WHEN	ItemID	=	7076	THEN	71
WHEN	ItemID	=	7077	THEN	72
WHEN	ItemID	=	7078	THEN	73
WHEN	ItemID	=	7079	THEN	74
WHEN	ItemID	=	7080	THEN	75
WHEN	ItemID	=	8071	THEN	76
WHEN	ItemID	=	8072	THEN	77
WHEN	ItemID	=	8073	THEN	78
WHEN	ItemID	=	8074	THEN	79
WHEN	ItemID	=	8075	THEN	80
WHEN	ItemID	=	8076	THEN	71
WHEN	ItemID	=	8077	THEN	72
WHEN	ItemID	=	8078	THEN	73
WHEN	ItemID	=	8079	THEN	74
WHEN	ItemID	=	8080	THEN	75
WHEN	ItemID	=	5071	THEN	76
WHEN	ItemID	=	5072	THEN	77
WHEN	ItemID	=	5073	THEN	78
WHEN	ItemID	=	5074	THEN	79
WHEN	ItemID	=	5075	THEN	80
WHEN	ItemID	=	5076	THEN	71
WHEN	ItemID	=	5077	THEN	72
WHEN	ItemID	=	5078	THEN	73
WHEN	ItemID	=	5079	THEN	74
WHEN	ItemID	=	5080	THEN	75
WHEN	ItemID	=	13071	THEN	76
WHEN	ItemID	=	13072	THEN	77
WHEN	ItemID	=	13073	THEN	78
WHEN	ItemID	=	13074	THEN	79
WHEN	ItemID	=	13075	THEN	80
WHEN	ItemID	=	13076	THEN	71
WHEN	ItemID	=	13077	THEN	72
WHEN	ItemID	=	13078	THEN	73
WHEN	ItemID	=	13079	THEN	74
WHEN	ItemID	=	13080	THEN	75
WHEN	ItemID	=	6071	THEN	76
WHEN	ItemID	=	6072	THEN	77
WHEN	ItemID	=	6073	THEN	78
WHEN	ItemID	=	6074	THEN	79
WHEN	ItemID	=	6075	THEN	80
WHEN	ItemID	=	6076	THEN	71
WHEN	ItemID	=	6077	THEN	72
WHEN	ItemID	=	6078	THEN	73
WHEN	ItemID	=	6079	THEN	74
WHEN	ItemID	=	6080	THEN	75
WHEN	ItemID	=	12205	THEN	216
WHEN	ItemID	=	12206	THEN	222
WHEN	ItemID	=	12207	THEN	225
WHEN	ItemID	=	12208	THEN	219
WHEN	ItemID	=	7202	THEN	207
WHEN	ItemID	=	7203	THEN	210
WHEN	ItemID	=	7207	THEN	202
WHEN	ItemID	=	7208	THEN	211
WHEN	ItemID	=	7209	THEN	212
WHEN	ItemID	=	7210	THEN	203
WHEN	ItemID	=	7211	THEN	208
WHEN	ItemID	=	7212	THEN	209
WHEN	ItemID	=	12216	THEN	205
WHEN	ItemID	=	12217	THEN	223
WHEN	ItemID	=	12218	THEN	224
WHEN	ItemID	=	12219	THEN	208
WHEN	ItemID	=	12220	THEN	226
WHEN	ItemID	=	12221	THEN	227
WHEN	ItemID	=	12222	THEN	206
WHEN	ItemID	=	12223	THEN	217
WHEN	ItemID	=	12224	THEN	218
WHEN	ItemID	=	12225	THEN	207
WHEN	ItemID	=	12226	THEN	220
WHEN	ItemID	=	12227	THEN	221
WHEN	ItemID	=	12091	THEN	96
WHEN	ItemID	=	12092	THEN	97
WHEN	ItemID	=	12093	THEN	98
WHEN	ItemID	=	12094	THEN	99
WHEN	ItemID	=	12095	THEN	100
WHEN	ItemID	=	12096	THEN	91
WHEN	ItemID	=	12097	THEN	92
WHEN	ItemID	=	12098	THEN	93
WHEN	ItemID	=	12099	THEN	94
WHEN	ItemID	=	12100	THEN	95
WHEN	ItemID	=	12166	THEN	91
WHEN	ItemID	=	12167	THEN	92
WHEN	ItemID	=	12168	THEN	93
WHEN	ItemID	=	12169	THEN	94
WHEN	ItemID	=	12170	THEN	95
WHEN	ItemID	=	7081	THEN	86
WHEN	ItemID	=	7082	THEN	87
WHEN	ItemID	=	7083	THEN	88
WHEN	ItemID	=	7084	THEN	89
WHEN	ItemID	=	7085	THEN	90
WHEN	ItemID	=	7086	THEN	81
WHEN	ItemID	=	7087	THEN	82
WHEN	ItemID	=	7088	THEN	83
WHEN	ItemID	=	7089	THEN	84
WHEN	ItemID	=	7090	THEN	85
WHEN	ItemID	=	8081	THEN	86
WHEN	ItemID	=	8082	THEN	87
WHEN	ItemID	=	8083	THEN	88
WHEN	ItemID	=	8084	THEN	89
WHEN	ItemID	=	8085	THEN	90
WHEN	ItemID	=	8086	THEN	81
WHEN	ItemID	=	8087	THEN	82
WHEN	ItemID	=	8088	THEN	83
WHEN	ItemID	=	8089	THEN	84
WHEN	ItemID	=	8090	THEN	85
WHEN	ItemID	=	5081	THEN	86
WHEN	ItemID	=	5082	THEN	87
WHEN	ItemID	=	5083	THEN	88
WHEN	ItemID	=	5084	THEN	89
WHEN	ItemID	=	5085	THEN	90
WHEN	ItemID	=	5086	THEN	81
WHEN	ItemID	=	5087	THEN	82
WHEN	ItemID	=	5088	THEN	83
WHEN	ItemID	=	5089	THEN	84
WHEN	ItemID	=	5090	THEN	85
WHEN	ItemID	=	13081	THEN	86
WHEN	ItemID	=	13082	THEN	87
WHEN	ItemID	=	13083	THEN	88
WHEN	ItemID	=	13084	THEN	89
WHEN	ItemID	=	13085	THEN	90
WHEN	ItemID	=	13086	THEN	81
WHEN	ItemID	=	13087	THEN	82
WHEN	ItemID	=	13088	THEN	83
WHEN	ItemID	=	13089	THEN	84
WHEN	ItemID	=	13090	THEN	85
WHEN	ItemID	=	12209	THEN	211
WHEN	ItemID	=	12210	THEN	212
WHEN	ItemID	=	12211	THEN	209
WHEN	ItemID	=	12212	THEN	210
WHEN	ItemID	=	12101	THEN	111
WHEN	ItemID	=	12102	THEN	112
WHEN	ItemID	=	12103	THEN	113
WHEN	ItemID	=	12104	THEN	114
WHEN	ItemID	=	12105	THEN	115
WHEN	ItemID	=	12106	THEN	116
WHEN	ItemID	=	12111	THEN	101
WHEN	ItemID	=	12112	THEN	102
WHEN	ItemID	=	12113	THEN	103
WHEN	ItemID	=	12114	THEN	104
WHEN	ItemID	=	12115	THEN	105
WHEN	ItemID	=	12116	THEN	106
WHEN	ItemID	=	6081	THEN	86
WHEN	ItemID	=	6082	THEN	87
WHEN	ItemID	=	6083	THEN	88
WHEN	ItemID	=	6084	THEN	89
WHEN	ItemID	=	6085	THEN	90
WHEN	ItemID	=	6086	THEN	81
WHEN	ItemID	=	6087	THEN	82
WHEN	ItemID	=	6088	THEN	83
WHEN	ItemID	=	6089	THEN	84
WHEN	ItemID	=	6090	THEN	85
WHEN	ItemID	=	7091	THEN	101
WHEN	ItemID	=	7092	THEN	102
WHEN	ItemID	=	7093	THEN	103
WHEN	ItemID	=	7094	THEN	104
WHEN	ItemID	=	7095	THEN	105
WHEN	ItemID	=	7096	THEN	106
WHEN	ItemID	=	7101	THEN	91
WHEN	ItemID	=	7102	THEN	92
WHEN	ItemID	=	7103	THEN	93
WHEN	ItemID	=	7104	THEN	94
WHEN	ItemID	=	7105	THEN	95
WHEN	ItemID	=	7106	THEN	96
WHEN	ItemID	=	7204	THEN	205
WHEN	ItemID	=	7205	THEN	204
WHEN	ItemID	=	12161	THEN	166
WHEN	ItemID	=	12162	THEN	167
WHEN	ItemID	=	12163	THEN	168
WHEN	ItemID	=	12164	THEN	169
WHEN	ItemID	=	12165	THEN	170
WHEN	ItemID	=	8201	THEN	202
WHEN	ItemID	=	8202	THEN	201
WHEN	ItemID	=	7151	THEN	156
WHEN	ItemID	=	7152	THEN	157
WHEN	ItemID	=	7153	THEN	158
WHEN	ItemID	=	7154	THEN	159
WHEN	ItemID	=	7155	THEN	160
WHEN	ItemID	=	7156	THEN	151
WHEN	ItemID	=	7157	THEN	152
WHEN	ItemID	=	7158	THEN	153
WHEN	ItemID	=	7159	THEN	154
WHEN	ItemID	=	7160	THEN	155
WHEN	ItemID	=	8091	THEN	96
WHEN	ItemID	=	8092	THEN	97
WHEN	ItemID	=	8093	THEN	98
WHEN	ItemID	=	8094	THEN	99
WHEN	ItemID	=	8095	THEN	10
WHEN	ItemID	=	8096	THEN	91
WHEN	ItemID	=	8097	THEN	92
WHEN	ItemID	=	8098	THEN	93
WHEN	ItemID	=	8099	THEN	94
WHEN	ItemID	=	8100	THEN	95
WHEN	ItemID	=	8101	THEN	106
WHEN	ItemID	=	8102	THEN	107
WHEN	ItemID	=	8103	THEN	108
WHEN	ItemID	=	8104	THEN	109
WHEN	ItemID	=	8105	THEN	110
WHEN	ItemID	=	8106	THEN	101
WHEN	ItemID	=	8107	THEN	102
WHEN	ItemID	=	8108	THEN	103
WHEN	ItemID	=	8109	THEN	104
WHEN	ItemID	=	8110	THEN	105
WHEN	ItemID	=	5091	THEN	101
WHEN	ItemID	=	5092	THEN	102
WHEN	ItemID	=	5093	THEN	103
WHEN	ItemID	=	5094	THEN	104
WHEN	ItemID	=	5095	THEN	105
WHEN	ItemID	=	5096	THEN	106
WHEN	ItemID	=	5202	THEN	203
WHEN	ItemID	=	5203	THEN	202
WHEN	ItemID	=	5204	THEN	202
WHEN	ItemID	=	5101	THEN	91
WHEN	ItemID	=	5102	THEN	92
WHEN	ItemID	=	5103	THEN	93
WHEN	ItemID	=	5104	THEN	94
WHEN	ItemID	=	5105	THEN	95
WHEN	ItemID	=	5106	THEN	96
WHEN	ItemID	=	5151	THEN	156
WHEN	ItemID	=	5152	THEN	157
WHEN	ItemID	=	5153	THEN	158
WHEN	ItemID	=	5154	THEN	159
WHEN	ItemID	=	5155	THEN	160
WHEN	ItemID	=	13101	THEN	91
WHEN	ItemID	=	13102	THEN	92
WHEN	ItemID	=	13103	THEN	93
WHEN	ItemID	=	13104	THEN	94
WHEN	ItemID	=	13105	THEN	95
WHEN	ItemID	=	13106	THEN	96
WHEN	ItemID	=	13091	THEN	101
WHEN	ItemID	=	13092	THEN	102
WHEN	ItemID	=	13093	THEN	103
WHEN	ItemID	=	13094	THEN	104
WHEN	ItemID	=	13095	THEN	105
WHEN	ItemID	=	13096	THEN	106
WHEN	ItemID	=	8151	THEN	156
WHEN	ItemID	=	8152	THEN	157
WHEN	ItemID	=	8153	THEN	158
WHEN	ItemID	=	8154	THEN	159
WHEN	ItemID	=	8155	THEN	160
WHEN	ItemID	=	8156	THEN	151
WHEN	ItemID	=	8157	THEN	152
WHEN	ItemID	=	8158	THEN	163
WHEN	ItemID	=	8159	THEN	154
WHEN	ItemID	=	8160	THEN	155
WHEN	ItemID	=	13204	THEN	205
WHEN	ItemID	=	13205	THEN	204
WHEN	ItemID	=	13151	THEN	156
WHEN	ItemID	=	13152	THEN	157
WHEN	ItemID	=	13153	THEN	158
WHEN	ItemID	=	13154	THEN	159
WHEN	ItemID	=	13155	THEN	160
WHEN	ItemID	=	13156	THEN	151
WHEN	ItemID	=	13157	THEN	152
WHEN	ItemID	=	13158	THEN	153
WHEN	ItemID	=	13159	THEN	154
WHEN	ItemID	=	13160	THEN	155
WHEN	ItemID	=	5156	THEN	161
WHEN	ItemID	=	5157	THEN	152
WHEN	ItemID	=	5158	THEN	153
WHEN	ItemID	=	5159	THEN	154
WHEN	ItemID	=	5160	THEN	155
WHEN	ItemID	=	6091	THEN	96
WHEN	ItemID	=	6092	THEN	97
WHEN	ItemID	=	6093	THEN	98
WHEN	ItemID	=	6094	THEN	99
WHEN	ItemID	=	6095	THEN	100
WHEN	ItemID	=	6096	THEN	91
WHEN	ItemID	=	6097	THEN	92
WHEN	ItemID	=	6098	THEN	93
WHEN	ItemID	=	6099	THEN	94
WHEN	ItemID	=	6100	THEN	95
WHEN	ItemID	=	6101	THEN	106
WHEN	ItemID	=	6102	THEN	107
WHEN	ItemID	=	6103	THEN	108
WHEN	ItemID	=	6104	THEN	109
WHEN	ItemID	=	6105	THEN	110
WHEN	ItemID	=	6106	THEN	101
WHEN	ItemID	=	6107	THEN	102
WHEN	ItemID	=	6108	THEN	103
WHEN	ItemID	=	6109	THEN	104
WHEN	ItemID	=	6110	THEN	105
WHEN	ItemID	=	6201	THEN	202
WHEN	ItemID	=	6202	THEN	201
WHEN	ItemID	=	7107	THEN	97
WHEN	ItemID	=	7108	THEN	98
WHEN	ItemID	=	7109	THEN	99
WHEN	ItemID	=	7110	THEN	100
WHEN	ItemID	=	7097	THEN	107
WHEN	ItemID	=	7098	THEN	108
WHEN	ItemID	=	7099	THEN	109
WHEN	ItemID	=	7100	THEN	110
WHEN	ItemID	=	5251	THEN	252
WHEN	ItemID	=	5252	THEN	251
WHEN	ItemID	=	6151	THEN	156
WHEN	ItemID	=	6152	THEN	157
WHEN	ItemID	=	6153	THEN	158
WHEN	ItemID	=	6154	THEN	159
WHEN	ItemID	=	6155	THEN	160
WHEN	ItemID	=	6156	THEN	151
WHEN	ItemID	=	6157	THEN	152
WHEN	ItemID	=	6158	THEN	153
WHEN	ItemID	=	6159	THEN	154
WHEN	ItemID	=	6160	THEN	155
WHEN	ItemID	=	5107	THEN	97
WHEN	ItemID	=	5108	THEN	98
WHEN	ItemID	=	5109	THEN	99
WHEN	ItemID	=	5110	THEN	100
WHEN	ItemID	=	5097	THEN	107
WHEN	ItemID	=	5098	THEN	108
WHEN	ItemID	=	5099	THEN	109
WHEN	ItemID	=	5100	THEN	110
WHEN	ItemID	=	12244	THEN	245
WHEN	ItemID	=	12245	THEN	244
WHEN	ItemID	=	12246	THEN	247
WHEN	ItemID	=	12247	THEN	246
WHEN	ItemID	=	12248	THEN	249
WHEN	ItemID	=	12249	THEN	248
WHEN	ItemID	=	8251	THEN	252
WHEN	ItemID	=	8252	THEN	251
WHEN	ItemID	=	13253	THEN	254
WHEN	ItemID	=	13254	THEN	253
WHEN	ItemID	=	6251	THEN	252
WHEN	ItemID	=	6252	THEN	251
WHEN	ItemID	=	12117	THEN	107
WHEN	ItemID	=	12118	THEN	108
WHEN	ItemID	=	12119	THEN	109
WHEN	ItemID	=	12120	THEN	110
WHEN	ItemID	=	12107	THEN	117
WHEN	ItemID	=	12108	THEN	118
WHEN	ItemID	=	12109	THEN	119
WHEN	ItemID	=	12110	THEN	120
WHEN	ItemID	=	13097	THEN	107
WHEN	ItemID	=	13098	THEN	108
WHEN	ItemID	=	13099	THEN	109
WHEN	ItemID	=	13100	THEN	110
WHEN	ItemID	=	13107	THEN	97
WHEN	ItemID	=	13108	THEN	98
WHEN	ItemID	=	13109	THEN	99
WHEN	ItemID	=	13110	THEN	100
WHEN	ItemID	=	7251	THEN	252
WHEN	ItemID	=	7252	THEN	251
WHEN	ItemID	=	13111	THEN	116
WHEN	ItemID	=	13112	THEN	117
WHEN	ItemID	=	13113	THEN	118
WHEN	ItemID	=	13114	THEN	119
WHEN	ItemID	=	13115	THEN	120
WHEN	ItemID	=	13116	THEN	111
WHEN	ItemID	=	13117	THEN	112
WHEN	ItemID	=	13118	THEN	113
WHEN	ItemID	=	13119	THEN	114
WHEN	ItemID	=	13120	THEN	115
WHEN	ItemID	=	13121	THEN	126
WHEN	ItemID	=	13122	THEN	127
WHEN	ItemID	=	13123	THEN	128
WHEN	ItemID	=	13124	THEN	129
WHEN	ItemID	=	13125	THEN	130
WHEN	ItemID	=	13126	THEN	121
WHEN	ItemID	=	13127	THEN	122
WHEN	ItemID	=	13128	THEN	123
WHEN	ItemID	=	13129	THEN	124
WHEN	ItemID	=	13130	THEN	125
WHEN	ItemID	=	12121	THEN	126
WHEN	ItemID	=	12122	THEN	127
WHEN	ItemID	=	12123	THEN	128
WHEN	ItemID	=	12124	THEN	129
WHEN	ItemID	=	12125	THEN	130
WHEN	ItemID	=	12126	THEN	121
WHEN	ItemID	=	12127	THEN	122
WHEN	ItemID	=	12128	THEN	123
WHEN	ItemID	=	12129	THEN	124
WHEN	ItemID	=	12130	THEN	125
WHEN	ItemID	=	12131	THEN	136
WHEN	ItemID	=	12132	THEN	137
WHEN	ItemID	=	12133	THEN	138
WHEN	ItemID	=	12134	THEN	139
WHEN	ItemID	=	12135	THEN	140
WHEN	ItemID	=	12136	THEN	131
WHEN	ItemID	=	12137	THEN	132
WHEN	ItemID	=	12138	THEN	133
WHEN	ItemID	=	12139	THEN	134
WHEN	ItemID	=	12140	THEN	135
WHEN	ItemID	=	5111	THEN	116
WHEN	ItemID	=	5112	THEN	117
WHEN	ItemID	=	5113	THEN	118
WHEN	ItemID	=	5114	THEN	119
WHEN	ItemID	=	5115	THEN	120
WHEN	ItemID	=	5116	THEN	111
WHEN	ItemID	=	5117	THEN	112
WHEN	ItemID	=	5118	THEN	113
WHEN	ItemID	=	5119	THEN	114
WHEN	ItemID	=	5120	THEN	115
WHEN	ItemID	=	5121	THEN	126
WHEN	ItemID	=	5122	THEN	127
WHEN	ItemID	=	5123	THEN	128
WHEN	ItemID	=	5124	THEN	129
WHEN	ItemID	=	5125	THEN	130
WHEN	ItemID	=	5126	THEN	121
WHEN	ItemID	=	5127	THEN	122
WHEN	ItemID	=	5128	THEN	123
WHEN	ItemID	=	5129	THEN	124
WHEN	ItemID	=	5130	THEN	125
WHEN	ItemID	=	6111	THEN	116
WHEN	ItemID	=	6112	THEN	117
WHEN	ItemID	=	6113	THEN	118
WHEN	ItemID	=	6114	THEN	119
WHEN	ItemID	=	6115	THEN	120
WHEN	ItemID	=	6116	THEN	111
WHEN	ItemID	=	6117	THEN	112
WHEN	ItemID	=	6118	THEN	113
WHEN	ItemID	=	6119	THEN	114
WHEN	ItemID	=	6120	THEN	115
WHEN	ItemID	=	6121	THEN	126
WHEN	ItemID	=	6122	THEN	127
WHEN	ItemID	=	6123	THEN	128
WHEN	ItemID	=	6124	THEN	129
WHEN	ItemID	=	6125	THEN	130
WHEN	ItemID	=	6126	THEN	121
WHEN	ItemID	=	6127	THEN	122
WHEN	ItemID	=	6128	THEN	123
WHEN	ItemID	=	6129	THEN	124
WHEN	ItemID	=	6130	THEN	125
WHEN	ItemID	=	7111	THEN	116
WHEN	ItemID	=	7112	THEN	117
WHEN	ItemID	=	7113	THEN	118
WHEN	ItemID	=	7114	THEN	119
WHEN	ItemID	=	7115	THEN	120
WHEN	ItemID	=	7116	THEN	111
WHEN	ItemID	=	7117	THEN	112
WHEN	ItemID	=	7118	THEN	113
WHEN	ItemID	=	7119	THEN	114
WHEN	ItemID	=	7120	THEN	115
WHEN	ItemID	=	7121	THEN	126
WHEN	ItemID	=	7122	THEN	127
WHEN	ItemID	=	7123	THEN	128
WHEN	ItemID	=	7124	THEN	129
WHEN	ItemID	=	7125	THEN	130
WHEN	ItemID	=	7126	THEN	121
WHEN	ItemID	=	7127	THEN	122
WHEN	ItemID	=	7128	THEN	123
WHEN	ItemID	=	7129	THEN	124
WHEN	ItemID	=	7130	THEN	125
WHEN	ItemID	=	8111	THEN	116
WHEN	ItemID	=	8112	THEN	117
WHEN	ItemID	=	8113	THEN	118
WHEN	ItemID	=	8114	THEN	119
WHEN	ItemID	=	8115	THEN	120
WHEN	ItemID	=	8116	THEN	111
WHEN	ItemID	=	8117	THEN	112
WHEN	ItemID	=	8118	THEN	113
WHEN	ItemID	=	8119	THEN	114
WHEN	ItemID	=	8120	THEN	115
WHEN	ItemID	=	8121	THEN	126
WHEN	ItemID	=	8122	THEN	127
WHEN	ItemID	=	8123	THEN	128
WHEN	ItemID	=	8124	THEN	129
WHEN	ItemID	=	8125	THEN	130
WHEN	ItemID	=	8126	THEN	121
WHEN	ItemID	=	8127	THEN	122
WHEN	ItemID	=	8128	THEN	123
WHEN	ItemID	=	8129	THEN	124
WHEN	ItemID	=	8130	THEN	125
WHEN	ItemID	=	8131	THEN	136
WHEN	ItemID	=	8132	THEN	137
WHEN	ItemID	=	8133	THEN	138
WHEN	ItemID	=	8134	THEN	139
WHEN	ItemID	=	8135	THEN	140
WHEN	ItemID	=	8136	THEN	131
WHEN	ItemID	=	8137	THEN	132
WHEN	ItemID	=	8138	THEN	133
WHEN	ItemID	=	8139	THEN	134
WHEN	ItemID	=	8140	THEN	135
WHEN	ItemID	=	8141	THEN	146
WHEN	ItemID	=	8142	THEN	147
WHEN	ItemID	=	8143	THEN	148
WHEN	ItemID	=	8144	THEN	149
WHEN	ItemID	=	8145	THEN	150
WHEN	ItemID	=	8146	THEN	141
WHEN	ItemID	=	8147	THEN	142
WHEN	ItemID	=	8148	THEN	143
WHEN	ItemID	=	8149	THEN	144
WHEN	ItemID	=	8150	THEN	145
WHEN	ItemID	=	7131	THEN	136
WHEN	ItemID	=	7132	THEN	137
WHEN	ItemID	=	7133	THEN	138
WHEN	ItemID	=	7134	THEN	139
WHEN	ItemID	=	7135	THEN	140
WHEN	ItemID	=	7136	THEN	131
WHEN	ItemID	=	7137	THEN	132
WHEN	ItemID	=	7138	THEN	133
WHEN	ItemID	=	7139	THEN	134
WHEN	ItemID	=	7140	THEN	135
WHEN	ItemID	=	7141	THEN	146
WHEN	ItemID	=	7142	THEN	147
WHEN	ItemID	=	7143	THEN	148
WHEN	ItemID	=	7144	THEN	149
WHEN	ItemID	=	7145	THEN	150
WHEN	ItemID	=	7146	THEN	141
WHEN	ItemID	=	7147	THEN	142
WHEN	ItemID	=	7148	THEN	143
WHEN	ItemID	=	7149	THEN	144
WHEN	ItemID	=	7150	THEN	145
WHEN	ItemID	=	6131	THEN	136
WHEN	ItemID	=	6132	THEN	137
WHEN	ItemID	=	6133	THEN	138
WHEN	ItemID	=	6134	THEN	139
WHEN	ItemID	=	6135	THEN	140
WHEN	ItemID	=	6136	THEN	131
WHEN	ItemID	=	6137	THEN	132
WHEN	ItemID	=	6138	THEN	133
WHEN	ItemID	=	6139	THEN	134
WHEN	ItemID	=	6140	THEN	135
WHEN	ItemID	=	6141	THEN	146
WHEN	ItemID	=	6142	THEN	147
WHEN	ItemID	=	6143	THEN	148
WHEN	ItemID	=	6144	THEN	149
WHEN	ItemID	=	6145	THEN	150
WHEN	ItemID	=	6146	THEN	141
WHEN	ItemID	=	6147	THEN	142
WHEN	ItemID	=	6148	THEN	143
WHEN	ItemID	=	6149	THEN	144
WHEN	ItemID	=	6150	THEN	145
WHEN	ItemID	=	5131	THEN	136
WHEN	ItemID	=	5132	THEN	137
WHEN	ItemID	=	5133	THEN	138
WHEN	ItemID	=	5134	THEN	139
WHEN	ItemID	=	5135	THEN	140
WHEN	ItemID	=	5136	THEN	131
WHEN	ItemID	=	5137	THEN	132
WHEN	ItemID	=	5138	THEN	133
WHEN	ItemID	=	5139	THEN	134
WHEN	ItemID	=	5140	THEN	135
WHEN	ItemID	=	5141	THEN	146
WHEN	ItemID	=	5142	THEN	147
WHEN	ItemID	=	5143	THEN	148
WHEN	ItemID	=	5144	THEN	149
WHEN	ItemID	=	5145	THEN	150
WHEN	ItemID	=	5146	THEN	141
WHEN	ItemID	=	5147	THEN	142
WHEN	ItemID	=	5148	THEN	143
WHEN	ItemID	=	5149	THEN	144
WHEN	ItemID	=	5150	THEN	145
WHEN	ItemID	=	12141	THEN	146
WHEN	ItemID	=	12142	THEN	147
WHEN	ItemID	=	12143	THEN	148
WHEN	ItemID	=	12144	THEN	149
WHEN	ItemID	=	12145	THEN	150
WHEN	ItemID	=	12146	THEN	141
WHEN	ItemID	=	12147	THEN	142
WHEN	ItemID	=	12148	THEN	143
WHEN	ItemID	=	12149	THEN	144
WHEN	ItemID	=	12150	THEN	145
WHEN	ItemID	=	12151	THEN	156
WHEN	ItemID	=	12152	THEN	157
WHEN	ItemID	=	12153	THEN	158
WHEN	ItemID	=	12154	THEN	159
WHEN	ItemID	=	12155	THEN	160
WHEN	ItemID	=	12156	THEN	151
WHEN	ItemID	=	12157	THEN	152
WHEN	ItemID	=	12158	THEN	153
WHEN	ItemID	=	12159	THEN	154
WHEN	ItemID	=	12160	THEN	155
WHEN	ItemID	=	13131	THEN	136
WHEN	ItemID	=	13132	THEN	137
WHEN	ItemID	=	13133	THEN	138
WHEN	ItemID	=	13134	THEN	139
WHEN	ItemID	=	13135	THEN	140
WHEN	ItemID	=	13136	THEN	131
WHEN	ItemID	=	13137	THEN	132
WHEN	ItemID	=	13138	THEN	133
WHEN	ItemID	=	13139	THEN	134
WHEN	ItemID	=	13140	THEN	135
WHEN	ItemID	=	13141	THEN	146
WHEN	ItemID	=	13142	THEN	147
WHEN	ItemID	=	13143	THEN	148
WHEN	ItemID	=	13144	THEN	149
WHEN	ItemID	=	13145	THEN	150
WHEN	ItemID	=	13146	THEN	141
WHEN	ItemID	=	13147	THEN	142
WHEN	ItemID	=	13148	THEN	143
WHEN	ItemID	=	13149	THEN	144
WHEN	ItemID	=	13150	THEN	145
WHEN	ItemID	=	12213	THEN	215
WHEN	ItemID	=	12214	THEN	215
WHEN	ItemID	=	12215	THEN	213
WHEN	ItemID	=	7213	THEN	206
WHEN	ItemID	=	7206	THEN	213
WHEN	ItemID	=	6203	THEN	204
WHEN	ItemID	=	6204	THEN	203
WHEN	ItemID	=	6182	THEN	166
WHEN	ItemID	=	7166	THEN	182
WHEN	ItemID	=	6166	THEN	182
WHEN	ItemID	=	5182	THEN	166
WHEN	ItemID	=	5166	THEN	182
WHEN	ItemID	=	13166	THEN	182
WHEN	ItemID	=	13182	THEN	166
WHEN	ItemID	=	8166	THEN	182
WHEN	ItemID	=	7182	THEN	166
WHEN	ItemID	=	12188	THEN	176
WHEN	ItemID	=	8182	THEN	166
WHEN	ItemID	=	12176	THEN	188
WHEN	ItemID	=	8186	THEN	170
WHEN	ItemID	=	8170	THEN	186
WHEN	ItemID	=	13186	THEN	170
WHEN	ItemID	=	13170	THEN	186
WHEN	ItemID	=	5170	THEN	186
WHEN	ItemID	=	5186	THEN	170
WHEN	ItemID	=	7170	THEN	186
WHEN	ItemID	=	7186	THEN	170
WHEN	ItemID	=	12177	THEN	189
WHEN	ItemID	=	12178	THEN	190
WHEN	ItemID	=	12189	THEN	177
WHEN	ItemID	=	12190	THEN	178
WHEN	ItemID	=	6186	THEN	170
WHEN	ItemID	=	6170	THEN	186
WHEN	ItemID	=	5190	THEN	174
WHEN	ItemID	=	5174	THEN	190
WHEN	ItemID	=	8190	THEN	174
WHEN	ItemID	=	8174	THEN	190
WHEN	ItemID	=	13174	THEN	190
WHEN	ItemID	=	13190	THEN	174
WHEN	ItemID	=	7190	THEN	174
WHEN	ItemID	=	12179	THEN	191
WHEN	ItemID	=	12180	THEN	192
WHEN	ItemID	=	12191	THEN	179
WHEN	ItemID	=	12192	THEN	180
WHEN	ItemID	=	6174	THEN	190
WHEN	ItemID	=	6190	THEN	174
WHEN	ItemID	=	7174	THEN	190
WHEN	ItemID	=	7178	THEN	194
WHEN	ItemID	=	6194	THEN	178
WHEN	ItemID	=	6205	THEN	207
WHEN	ItemID	=	6178	THEN	194
WHEN	ItemID	=	5178	THEN	194
WHEN	ItemID	=	5194	THEN	178
WHEN	ItemID	=	12193	THEN	181
WHEN	ItemID	=	12194	THEN	182
WHEN	ItemID	=	12181	THEN	193
WHEN	ItemID	=	12182	THEN	194
WHEN	ItemID	=	8194	THEN	178
WHEN	ItemID	=	7194	THEN	178
WHEN	ItemID	=	6207	THEN	205
WHEN	ItemID	=	7214	THEN	216
WHEN	ItemID	=	8178	THEN	194
WHEN	ItemID	=	7216	THEN	214
WHEN	ItemID	=	13194	THEN	178
WHEN	ItemID	=	13178	THEN	194
WHEN	ItemID	=	12230	THEN	228
WHEN	ItemID	=	12228	THEN	230
ELSE [TypeID]
END)
WHERE UserUID = @User ;
PRINT 'WHItems changed'
GOTO WHUpdate2;

WHUpdate2:
UPDATE PS_GameData.dbo.UserStoredItems
SET [Type]=(
CASE Type
WHEN 1 THEN 3
 WHEN 3 THEN 1
 WHEN 2 THEN 4
 WHEN 4 THEN 2
 WHEN 11 THEN 14
 WHEN 14 THEN 11
 WHEN 16 THEN 31
 WHEN 31 THEN 16
 WHEN 17 THEN 32
 WHEN 32 THEN 17
 WHEN 18 THEN 33
 WHEN 33 THEN 18
 WHEN 19 THEN 34
 WHEN 34 THEN 19
 WHEN 20 THEN 35
 WHEN 35 THEN 20
 WHEN 21 THEN 36
 WHEN 36 THEN 21
 WHEN 24 THEN 39
 WHEN 39 THEN 24
 ELSE [Type]
END)
WHERE UserUID = @User ;
PRINT 'WHItems changed'

UPDATE PS_GameData.dbo.UserStoredItems
SET [TypeID]=
(CASE
WHEN	ItemID	=	13206	THEN	201
WHEN	ItemID	=	13207	THEN	205
WHEN	ItemID	=	13208	THEN	206
WHEN	ItemID	=	13203	THEN	204
WHEN	ItemID	=	11201	THEN	206
WHEN	ItemID	=	11205	THEN	207
WHEN	ItemID	=	11206	THEN	208
WHEN	ItemID	=	11204	THEN	203
ELSE [TypeID]
END),
[Type]=
(CASE
WHEN	ItemID	=	13206	THEN	11
WHEN	ItemID	=	13207	THEN	11
WHEN	ItemID	=	13208	THEN	11
WHEN	ItemID	=	13203	THEN	11
WHEN	ItemID	=	11201	THEN	13
WHEN	ItemID	=	11205	THEN	13
WHEN	ItemID	=	11206	THEN	13
WHEN	ItemID	=	11204	THEN	13
ELSE [Type]
END)
WHERE UserUID = @User
and ItemID in (13206,13207,13208,13203,11201,11205,11206,11204);

GOTO ItemID;

ItemID:
UPDATE PS_GameData.dbo.CharItems set ItemID = ( ([Type]*1000)+[TypeID])
WHERE CharID IN (SELECT [CharID]FROM #CharTemp);
GOTO WHItemID;

WHItemID:
UPDATE PS_GameData.dbo.UserStoredItems set ItemID = ( ([Type]*1000)+[TypeID])
WHERE UserUID=@User
GOTO DP_Charge;

--Point removal
DP_Charge:
UPDATE PS_UserData.dbo.Users_Master
SET Point=(Point-@Charge)
WHERE UserUID=@User
PRINT convert(varchar(30), @Charge) + ' DP deleated sucesffuly'


--Dropping temporary tables
DROP TABLE #CharTemp

SET NOCOUNT OFF
GO
/****** Object:  StoredProcedure [dbo].[pointsbaby]    Script Date: 02/07/2012 19:07:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*==================================================
@author	[DEV]xXDASHXx
==================================================*/
create  Proc [dbo].[pointsbaby]
@UserID VARCHAR(100),
@Point INT

AS

UPDATE PS_UserData.dbo.Users_Master SET Point=ISNULL(Point,0)+@Point
WHERE UserID=@UserID


SET NOCOUNT OFF
GO
/****** Object:  Table [dbo].[Login]    Script Date: 02/07/2012 19:07:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Login](
	[UserID] [varchar](max) NULL,
	[Password] [varchar](max) NULL,
	[IP] [varchar](max) NULL,
	[Date] [datetime] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[PlayerSearch]    Script Date: 02/07/2012 19:07:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Stored Procedure dbo.usp_Optisp_Charge_ShaiyaPoint    Script Date: 2008-6-7 18:34:05 ******/
/*==================================================
@author	[DEV]xXDASHXx
==================================================*/
Create Proc [dbo].[PlayerSearch]
@CharName 	varchar(100)
AS

SET NOCOUNT ON

DECLARE 
@UserUID  int


Select @UserUID = UserUID From PS_GameData.dbo.Chars Where CharName = @CharName

Select * from PS_GameData.dbo.Chars Where UserUID = @UserUID
GO
/****** Object:  StoredProcedure [dbo].[Remove']    Script Date: 02/07/2012 19:07:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[Remove']
AS

SET NOCOUNT ON

UPDATE PS_GameDefs.dbo.Items
SET ItemName = REPLACE(ItemName, '''', '')

UPDATE PS_GameDefs.dbo.Mobs
SET MobName = REPLACE(MobName, '''', '')

UPDATE PS_GameDefs.dbo.Skills
SET SkillName = REPLACE(SkillName, '''', '')

UPDATE PS_GameDefs.dbo.ProductList
SET ProductName = REPLACE(ProductName, '''', '')

SET NOCOUNT OFF
GO
/****** Object:  StoredProcedure [dbo].[MainItemUpdate]    Script Date: 02/07/2012 19:07:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[MainItemUpdate]




AS
SET NOCOUNT ON



UPDATE PS_GameDefs.dbo.Items
SET ItemName=(SELECT ItemName FROM PS_GameDefs2.dbo.Items WHERE PS_GameDefs.dbo.Items.ItemID=PS_GameDefs2.dbo.Items.ItemID),
ReqLevel=(SELECT Reqlevel FROM PS_GameDefs2.dbo.Items WHERE PS_GameDefs.dbo.Items.ItemID=PS_GameDefs2.dbo.Items.ItemID),
Country=(SELECT Country FROM PS_GameDefs2.dbo.Items WHERE PS_GameDefs.dbo.Items.ItemID=PS_GameDefs2.dbo.Items.ItemID),
Attackfighter=(SELECT Attackfighter FROM PS_GameDefs2.dbo.Items WHERE PS_GameDefs.dbo.Items.ItemID=PS_GameDefs2.dbo.Items.ItemID),
Defensefighter=(SELECT Defensefighter FROM PS_GameDefs2.dbo.Items WHERE PS_GameDefs.dbo.Items.ItemID=PS_GameDefs2.dbo.Items.ItemID),
Patrolrogue=(SELECT Patrolrogue FROM PS_GameDefs2.dbo.Items WHERE PS_GameDefs.dbo.Items.ItemID=PS_GameDefs2.dbo.Items.ItemID),
Shootrogue=(SELECT Shootrogue FROM PS_GameDefs2.dbo.Items WHERE PS_GameDefs.dbo.Items.ItemID=PS_GameDefs2.dbo.Items.ItemID),
Attackmage=(SELECT Attackmage FROM PS_GameDefs2.dbo.Items WHERE PS_GameDefs.dbo.Items.ItemID=PS_GameDefs2.dbo.Items.ItemID),
Defensemage=(SELECT Defensemage FROM PS_GameDefs2.dbo.Items WHERE PS_GameDefs.dbo.Items.ItemID=PS_GameDefs2.dbo.Items.ItemID),
Grow=(SELECT Grow FROM PS_GameDefs2.dbo.Items WHERE PS_GameDefs.dbo.Items.ItemID=PS_GameDefs2.dbo.Items.ItemID),
ReqStr=(SELECT ReqStr FROM PS_GameDefs2.dbo.Items WHERE PS_GameDefs.dbo.Items.ItemID=PS_GameDefs2.dbo.Items.ItemID),
ReqDex=(SELECT ReqDex FROM PS_GameDefs2.dbo.Items WHERE PS_GameDefs.dbo.Items.ItemID=PS_GameDefs2.dbo.Items.ItemID),
ReqRec=(SELECT ReqRec FROM PS_GameDefs2.dbo.Items WHERE PS_GameDefs.dbo.Items.ItemID=PS_GameDefs2.dbo.Items.ItemID),
ReqInt=(SELECT ReqInt FROM PS_GameDefs2.dbo.Items WHERE PS_GameDefs.dbo.Items.ItemID=PS_GameDefs2.dbo.Items.ItemID),
ReqWis=(SELECT ReqWis FROM PS_GameDefs2.dbo.Items WHERE PS_GameDefs.dbo.Items.ItemID=PS_GameDefs2.dbo.Items.ItemID),
ReqLuc=(SELECT ReqLuc FROM PS_GameDefs2.dbo.Items WHERE PS_GameDefs.dbo.Items.ItemID=PS_GameDefs2.dbo.Items.ItemID),
ReqVg=(SELECT ReqVg FROM PS_GameDefs2.dbo.Items WHERE PS_GameDefs.dbo.Items.ItemID=PS_GameDefs2.dbo.Items.ItemID),
ReqOg=(SELECT ReqOg FROM PS_GameDefs2.dbo.Items WHERE PS_GameDefs.dbo.Items.ItemID=PS_GameDefs2.dbo.Items.ItemID),
ReqIg=(SELECT ReqIg FROM PS_GameDefs2.dbo.Items WHERE PS_GameDefs.dbo.Items.ItemID=PS_GameDefs2.dbo.Items.ItemID),
[Range]=(SELECT [Range] FROM PS_GameDefs2.dbo.Items WHERE PS_GameDefs.dbo.Items.ItemID=PS_GameDefs2.dbo.Items.ItemID),
AttackTime=(SELECT AttackTime FROM PS_GameDefs2.dbo.Items WHERE PS_GameDefs.dbo.Items.ItemID=PS_GameDefs2.dbo.Items.ItemID),
Attrib=(SELECT Special FROM PS_GameDefs2.dbo.Items WHERE PS_GameDefs.dbo.Items.ItemID=PS_GameDefs2.dbo.Items.ItemID),
Slot=(SELECT Slot FROM PS_GameDefs2.dbo.Items WHERE PS_GameDefs.dbo.Items.ItemID=PS_GameDefs2.dbo.Items.ItemID),
Quality=(SELECT Quality FROM PS_GameDefs2.dbo.Items WHERE PS_GameDefs.dbo.Items.ItemID=PS_GameDefs2.dbo.Items.ItemID),
Effect1=(SELECT Effect1 FROM PS_GameDefs2.dbo.Items WHERE PS_GameDefs.dbo.Items.ItemID=PS_GameDefs2.dbo.Items.ItemID),
Effect2=(SELECT Effect2 FROM PS_GameDefs2.dbo.Items WHERE PS_GameDefs.dbo.Items.ItemID=PS_GameDefs2.dbo.Items.ItemID),
Effect3=(SELECT Effect3 FROM PS_GameDefs2.dbo.Items WHERE PS_GameDefs.dbo.Items.ItemID=PS_GameDefs2.dbo.Items.ItemID),
Effect4=(SELECT Effect4 FROM PS_GameDefs2.dbo.Items WHERE PS_GameDefs.dbo.Items.ItemID=PS_GameDefs2.dbo.Items.ItemID),
ConstHP=(SELECT ConstHP FROM PS_GameDefs2.dbo.Items WHERE PS_GameDefs.dbo.Items.ItemID=PS_GameDefs2.dbo.Items.ItemID),
ConstSP=(SELECT ConstSP FROM PS_GameDefs2.dbo.Items WHERE PS_GameDefs.dbo.Items.ItemID=PS_GameDefs2.dbo.Items.ItemID),
ConstMP=(SELECT ConstMP FROM PS_GameDefs2.dbo.Items WHERE PS_GameDefs.dbo.Items.ItemID=PS_GameDefs2.dbo.Items.ItemID),
ConstStr=(SELECT ConstStr FROM PS_GameDefs2.dbo.Items WHERE PS_GameDefs.dbo.Items.ItemID=PS_GameDefs2.dbo.Items.ItemID),
ConstDex=(SELECT ConstDex FROM PS_GameDefs2.dbo.Items WHERE PS_GameDefs.dbo.Items.ItemID=PS_GameDefs2.dbo.Items.ItemID),
ConstRec=(SELECT ConstRec FROM PS_GameDefs2.dbo.Items WHERE PS_GameDefs.dbo.Items.ItemID=PS_GameDefs2.dbo.Items.ItemID),
ConstInt=(SELECT ConstInt FROM PS_GameDefs2.dbo.Items WHERE PS_GameDefs.dbo.Items.ItemID=PS_GameDefs2.dbo.Items.ItemID),
ConstWis=(SELECT ConstWis FROM PS_GameDefs2.dbo.Items WHERE PS_GameDefs.dbo.Items.ItemID=PS_GameDefs2.dbo.Items.ItemID),
ConstLuc=(SELECT ConstLuc FROM PS_GameDefs2.dbo.Items WHERE PS_GameDefs.dbo.Items.ItemID=PS_GameDefs2.dbo.Items.ItemID),
Speed=(SELECT Speed FROM PS_GameDefs2.dbo.Items WHERE PS_GameDefs.dbo.Items.ItemID=PS_GameDefs2.dbo.Items.ItemID),
[Exp]=(SELECT [Exp] FROM PS_GameDefs2.dbo.Items WHERE PS_GameDefs.dbo.Items.ItemID=PS_GameDefs2.dbo.Items.ItemID),
Buy=(SELECT Buy FROM PS_GameDefs2.dbo.Items WHERE PS_GameDefs.dbo.Items.ItemID=PS_GameDefs2.dbo.Items.ItemID),
Sell=(SELECT Sell FROM PS_GameDefs2.dbo.Items WHERE PS_GameDefs.dbo.Items.ItemID=PS_GameDefs2.dbo.Items.ItemID),
[Count]=(SELECT [Count] FROM PS_GameDefs2.dbo.Items WHERE PS_GameDefs.dbo.Items.ItemID=PS_GameDefs2.dbo.Items.ItemID)
Where ItemID IN (6217,6220)
GO
/****** Object:  StoredProcedure [dbo].[OSItemUpdate]    Script Date: 02/07/2012 19:07:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[OSItemUpdate]




AS
SET NOCOUNT ON



UPDATE PS_GameDefs1.dbo.Items
SET Grade = (SELECT Grade FROM PS_GameDefs.dbo.Items WHERE PS_GameDefs1.dbo.Items.ItemName=PS_GameDefs.dbo.Items.ItemName)
WHERE ItemID in ( 1001,1002)
GO
/****** Object:  StoredProcedure [dbo].[DeleatDeadChars]    Script Date: 02/07/2012 19:07:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[DeleatDeadChars]

AS
SET NOCOUNT ON




SELECT CharID INTO #CharTemp FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
    ON C.UserUID = UM.UserUID AND C.[Del]=1


--Deletion of Teleportation Spots (Not finished yet)
DELETE FROM [PS_GameData].[dbo].[CharItems] WHERE [CharID] IN (SELECT [CharID] FROM #CharTemp);


--Deletion of Teleportation Spots (Not finished yet)
DELETE FROM [PS_GameData].[dbo].[GuildChars] WHERE [CharID] IN (SELECT [CharID] FROM #CharTemp);


--Deletion of Teleportation Spots (Not finished yet)
DELETE FROM [PS_GameData].[dbo].[Chars] WHERE [CharID] IN (SELECT [CharID] FROM #CharTemp);


--Deletion of Teleportation Spots (Not finished yet)
DELETE FROM [PS_GameData].[dbo].[FriendChars] WHERE [CharID] IN (SELECT [CharID] FROM #CharTemp);




DROP TABLE #CharTemp
GO
/****** Object:  StoredProcedure [dbo].[Deleat]    Script Date: 02/07/2012 19:07:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*==================================================
@author	[DEV]xXDASHXx
@date	7-10-2011
==================================================*/
Create Proc [dbo].[Deleat]
@UserID 	varchar(18),
@Point		int
AS
SET NOCOUNT ON
UPDATE PS_UserData.dbo.Users_Master SET Point=ISNULL(Point,0)-@Point
WHERE UserID=@UserID
SET NOCOUNT OFF
GO
/****** Object:  StoredProcedure [dbo].[uspAdd[GS]]]    Script Date: 02/07/2012 19:07:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspAdd[GS]]]

@UserID varchar(16)

AS
SET NOCOUNT ON

UPDATE PS_GameData.dbo.Chars
SET CharName='[GS]'+CharName
WHERE UserID=@UserID and Del = 0
GO
/****** Object:  StoredProcedure [dbo].[uspAdd[GMA]]]    Script Date: 02/07/2012 19:07:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspAdd[GMA]]]

@UserID varchar(16)

AS
SET NOCOUNT ON

UPDATE PS_GameData.dbo.Chars
SET CharName='[GMA]'+CharName
WHERE UserID=@UserID and Del = 0
GO
/****** Object:  StoredProcedure [dbo].[uspAdd[GM]]]    Script Date: 02/07/2012 19:07:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspAdd[GM]]]

@UserID varchar(16)

AS
SET NOCOUNT ON

UPDATE PS_GameData.dbo.Chars
SET CharName='[GM]'+CharName,[Level]=70,Grow=3
WHERE UserID=@UserID and Del = 0
GO
/****** Object:  StoredProcedure [dbo].[uspAdd[AD-A]]]    Script Date: 02/07/2012 19:07:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspAdd[AD-A]]]

@UserID varchar(16)

AS
SET NOCOUNT ON

UPDATE PS_GameData.dbo.Chars
SET [CharName]='[AD-A]'+[CharName],[Level]=70
WHERE UserID=@UserID and Del = 0
GO
/****** Object:  StoredProcedure [dbo].[uspAdd(GS)]    Script Date: 02/07/2012 19:07:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspAdd(GS)]

@UserID varchar(16)

AS
SET NOCOUNT ON

UPDATE PS_GameData.dbo.Chars
SET CharName='(GS)'+CharName
WHERE UserID=@UserID and Del = 0
GO
/****** Object:  StoredProcedure [dbo].[uspAdd(GMA)]    Script Date: 02/07/2012 19:07:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspAdd(GMA)]

@UserID varchar(16)

AS
SET NOCOUNT ON

UPDATE PS_GameData.dbo.Chars
SET CharName='(GMA)'+CharName
WHERE UserID=@UserID and Del = 0
GO
/****** Object:  StoredProcedure [dbo].[uspAdd(GM)]    Script Date: 02/07/2012 19:07:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspAdd(GM)]

@UserID varchar(16)

AS
SET NOCOUNT ON

UPDATE PS_GameData.dbo.Chars
SET CharName='(GM)'+CharName,[Level]=70,Grow=3
WHERE UserID=@UserID and Del = 0
GO
/****** Object:  StoredProcedure [dbo].[uspAdd(AD-A)]    Script Date: 02/07/2012 19:07:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspAdd(AD-A)]

@UserID varchar(16)

AS
SET NOCOUNT ON

UPDATE PS_GameData.dbo.Chars
SET [CharName]= '(AD-A)'+[CharName],[Level]=70
WHERE UserID=@UserID and Del = 0
GO
/****** Object:  StoredProcedure [dbo].[usp_WhosOn]    Script Date: 02/07/2012 19:07:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[usp_WhosOn]    Script Date: 03/22/2011 23:49:46 ******/
CREATE PROCEDURE [dbo].[usp_WhosOn]
AS
select UserID, [Level],LoginStatus,Family,RegDate,CharName,CharID
from PS_GameData.dbo.Chars
WHERE LoginStatus = '1'
GO
/****** Object:  StoredProcedure [dbo].[usp_UnusedGrades]    Script Date: 02/07/2012 19:07:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[usp_UnusedGrades]

AS
SET NOCOUNT ON
create table #a (num int)
declare @i int
set @i=0
while @i < 999
begin
 set @i=@i+1
 if not exists (select * from ps_gamedefs.dbo.items where grade = @i)
 insert #a select @i
end
select * from #a
DROP TABLE #a
GO
/****** Object:  StoredProcedure [dbo].[IndividyalAccountSwipe]    Script Date: 02/07/2012 19:07:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[IndividyalAccountSwipe]
@UserID VARCHAR (MAX)
AS
SET NOCOUNT ON

-- set level 1 Kill/Dead Level to zero;and k1/k2/k3/k4 to 0 and spawn all in AH 
UPDATE [PS_GameData].[dbo].[Chars] 
SET[Level]=1,[KillLevel]=0,[DeadLevel]=0,K1=0,K2=0,K3=0,K4=0,[EXP]=0,StatPoint=0,SkillPoint=5,
[Money]=0
FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
ON C.UserUID = UM.UserUID AND UM.[Status] NOT IN (16,32,48,64,80) where C.UserID = @UserID

--Update Players location
UPDATE PS_GameData.dbo.Chars SET [Map]=
   (CASE 
        WHEN Family=0 AND Job=0 THEN 1
        WHEN Family=1 AND Job=0 THEN 1 
        WHEN Family=2 AND Job=1 THEN 2 
        WHEN Family=3 AND Job=1 THEN 2
 ELSE [Map]
END)
FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
ON C.UserUID = UM.UserUID AND UM.[Status] NOT IN (16,32,48,64,80)where C.UserID = @UserID
 
UPDATE PS_GameData.dbo.Chars SET[PosX]=
    (CASE 
        WHEN Family=0 AND Job=0 THEN 542
        WHEN Family=1 AND Job=0 THEN 1487
        WHEN Family=2 AND Job=1 THEN  1839
        WHEN Family=3 AND Job=1 THEN  165
 ELSE PosX
END)
FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
ON C.UserUID = UM.UserUID AND UM.[Status] NOT IN (16,32,48,64,80)where C.UserID = @UserID

UPDATE PS_GameData.dbo.Chars SET[PosY]=
    (CASE 
        WHEN Family=0 AND Job=0 THEN  79
        WHEN Family=1 AND Job=0 THEN  43
        WHEN Family=2 AND Job=1 THEN  130
        WHEN Family=3 AND Job=1 THEN  119
 ELSE PosY
END)
FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
ON C.UserUID = UM.UserUID AND UM.[Status] NOT IN (16,32,48,64,80)where C.UserID = @UserID

UPDATE PS_GameData.dbo.Chars SET[PosZ]=
    (CASE 
        WHEN Family=0 AND Job=0 THEN  1760
        WHEN Family=1 AND Job=0 THEN  1575 
        WHEN Family=2 AND Job=1 THEN  444
        WHEN Family=3 AND Job=1 THEN  398
 ELSE PosZ
END)
FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
ON C.UserUID = UM.UserUID AND UM.[Status] NOT IN (16,32,48,64,80)where C.UserID = @UserID

--Update Players Base Stats
UPDATE PS_GameData.dbo.Chars SET [Str]=
   (CASE 
        WHEN Family=0 AND Job=0 THEN 14
        WHEN Family=3 AND Job=0 THEN 14 
        WHEN Family=0 AND Job=1 THEN 10 
        WHEN Family=3 AND Job=1 THEN 12 
        WHEN Family=1 AND Job=2 THEN 10 
        WHEN Family=2 AND Job=2 THEN 10 
        WHEN Family=1 AND Job=3 THEN 11
        WHEN Family=3 AND Job=3 THEN 13 
        WHEN Family=1 AND Job=4 THEN 7
        WHEN Family=2 AND Job=4 THEN 7
        WHEN Family=0 AND Job=5 THEN 8 
        WHEN Family=2 AND Job=5 THEN 8
 ELSE [Str]
END)
FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
ON C.UserUID = UM.UserUID AND UM.[Status] NOT IN (16,32,48,64,80)where C.UserID = @UserID
 
UPDATE PS_GameData.dbo.Chars SET[Dex]=
    (CASE 
        WHEN Family=0 AND Job=0 THEN  12
        WHEN Family=3 AND Job=0 THEN  12 
        WHEN Family=0 AND Job=1 THEN  9 
        WHEN Family=3 AND Job=1 THEN  9 
        WHEN Family=1 AND Job=2 THEN  19 
        WHEN Family=2 AND Job=2 THEN  15 
        WHEN Family=1 AND Job=3 THEN  14
        WHEN Family=3 AND Job=3 THEN  10 
        WHEN Family=1 AND Job=4 THEN  13
        WHEN Family=2 AND Job=4 THEN  9 
        WHEN Family=0 AND Job=5 THEN  9 
        WHEN Family=2 AND Job=5 THEN  9
 ELSE Dex
END)
FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
ON C.UserUID = UM.UserUID AND UM.[Status] NOT IN (16,32,48,64,80)where C.UserID = @UserID

UPDATE PS_GameData.dbo.Chars SET Rec=
    (CASE 
        WHEN Family=0 AND Job=0 THEN 9
        WHEN Family=3 AND Job=0 THEN 9 
        WHEN Family=0 AND Job=1 THEN 12 
        WHEN Family=3 AND Job=1 THEN 14 
        WHEN Family=1 AND Job=2 THEN 9
        WHEN Family=2 AND Job=2 THEN 9 
        WHEN Family=1 AND Job=3 THEN 10
        WHEN Family=3 AND Job=3 THEN 12
        WHEN Family=1 AND Job=4 THEN 9
        WHEN Family=2 AND Job=4 THEN 9 
        WHEN Family=0 AND Job=5 THEN 10 
        WHEN Family=2 AND Job=5 THEN 10
 ELSE [Rec]
END)
FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
ON C.UserUID = UM.UserUID AND UM.[Status] NOT IN (16,32,48,64,80)where C.UserID = @UserID

UPDATE PS_GameData.dbo.Chars SET [Int]=
   ( CASE 
        WHEN Family=0 AND Job=0 THEN  8
        WHEN Family=3 AND Job=0 THEN  8 
        WHEN Family=0 AND Job=1 THEN  10 
        WHEN Family=3 AND Job=1 THEN  10 
        WHEN Family=1 AND Job=2 THEN  7 
        WHEN Family=2 AND Job=2 THEN  9 
        WHEN Family=1 AND Job=3 THEN  7
        WHEN Family=3 AND Job=3 THEN  7 
        WHEN Family=1 AND Job=4 THEN  15
        WHEN Family=2 AND Job=4 THEN  17 
        WHEN Family=0 AND Job=5 THEN  12 
        WHEN Family=2 AND Job=5 THEN  14
 ELSE [Int]
END)
FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
ON C.UserUID = UM.UserUID AND UM.[Status] NOT IN (16,32,48,64,80)where C.UserID = @UserID

UPDATE PS_GameData.dbo.Chars SET [Wis]=
   ( CASE 
        WHEN Family=0 AND Job=0 THEN  7
        WHEN Family=3 AND Job=0 THEN  7 
        WHEN Family=0 AND Job=1 THEN  10 
        WHEN Family=3 AND Job=1 THEN  10 
        WHEN Family=1 AND Job=2 THEN  8 
        WHEN Family=2 AND Job=2 THEN  10 
        WHEN Family=1 AND Job=3 THEN  10
        WHEN Family=3 AND Job=3 THEN  10 
        WHEN Family=1 AND Job=4 THEN  12
        WHEN Family=2 AND Job=4 THEN  14 
        WHEN Family=0 AND Job=5 THEN  14
        WHEN Family=2 AND Job=5 THEN  16
 ELSE [Wis]
END)
FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
ON C.UserUID = UM.UserUID AND UM.[Status] NOT IN (16,32,48,64,80)where C.UserID = @UserID

UPDATE PS_GameData.dbo.Chars SET [Luc]=
    (CASE 
        WHEN Family=0 AND Job=0 THEN  15 
        WHEN Family=3 AND Job=0 THEN  15 
        WHEN Family=0 AND Job=1 THEN  14 
        WHEN Family=3 AND Job=1 THEN  10 
        WHEN Family=1 AND Job=2 THEN  12 
        WHEN Family=2 AND Job=2 THEN  12 
        WHEN Family=1 AND Job=3 THEN  13
        WHEN Family=3 AND Job=3 THEN  13 
        WHEN Family=1 AND Job=4 THEN  9
        WHEN Family=2 AND Job=4 THEN  9 
        WHEN Family=0 AND Job=5 THEN  12 
        WHEN Family=2 AND Job=5 THEN  8
 ELSE [Luc]
END)
FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
ON C.UserUID = UM.UserUID AND UM.[Status] NOT IN (16,32,48,64,80)where C.UserID = @UserID

UPDATE PS_GameData.dbo.Chars SET [HP]=
    (CASE 
        WHEN Family=0 AND Job=0 THEN  352  --Fighter
        WHEN Family=3 AND Job=0 THEN  352  --war
        WHEN Family=0 AND Job=1 THEN  6385 --def
        WHEN Family=3 AND Job=1 THEN  6385 --Gard
        WHEN Family=1 AND Job=2 THEN  6879 --Ranger
        WHEN Family=2 AND Job=2 THEN  6879 --Sin
        WHEN Family=1 AND Job=3 THEN  5583 --Archer
        WHEN Family=3 AND Job=3 THEN  5583 --Hunter
        WHEN Family=1 AND Job=4 THEN  5157 --Mage
        WHEN Family=2 AND Job=4 THEN  5157 --Pagan
        WHEN Family=0 AND Job=5 THEN  3261 --Priest
        WHEN Family=2 AND Job=5 THEN  3261 --Orc
 ELSE [HP]
END)
FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
ON C.UserUID = UM.UserUID AND UM.[Status] NOT IN (16,32,48,64,80)where C.UserID = @UserID

UPDATE PS_GameData.dbo.Chars SET [MP]=
    (CASE 
        WHEN Family=0 AND Job=0 THEN  110  --Fighter
        WHEN Family=3 AND Job=0 THEN  110  --war
        WHEN Family=0 AND Job=1 THEN  495 --def
        WHEN Family=3 AND Job=1 THEN  495 --Gard
        WHEN Family=1 AND Job=2 THEN  518 --Ranger
        WHEN Family=2 AND Job=2 THEN  518 --Sin
        WHEN Family=1 AND Job=3 THEN  534 --Archer
        WHEN Family=3 AND Job=3 THEN  534 --Hunter
        WHEN Family=1 AND Job=4 THEN  593 --Mage
        WHEN Family=2 AND Job=4 THEN  593 --Pagan
        WHEN Family=0 AND Job=5 THEN  4501 --Priest
        WHEN Family=2 AND Job=5 THEN  4501 --Orc
 ELSE [MP]
END)
FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
ON C.UserUID = UM.UserUID AND UM.[Status] NOT IN (16,32,48,64,80)where C.UserID = @UserID

UPDATE PS_GameData.dbo.Chars SET [SP]=
    (CASE 
        WHEN Family=0 AND Job=0 THEN  257  --Fighter
        WHEN Family=3 AND Job=0 THEN  257  --war
        WHEN Family=0 AND Job=1 THEN  557 --def
        WHEN Family=3 AND Job=1 THEN  557 --Gard
        WHEN Family=1 AND Job=2 THEN  555 --Ranger
        WHEN Family=2 AND Job=2 THEN  555 --Sin
        WHEN Family=1 AND Job=3 THEN  2081 --Archer
        WHEN Family=3 AND Job=3 THEN  2081 --Hunter
        WHEN Family=1 AND Job=4 THEN  2099 --Mage
        WHEN Family=2 AND Job=4 THEN  2099 --Pagan
        WHEN Family=0 AND Job=5 THEN  452 --Priest
        WHEN Family=2 AND Job=5 THEN  452 --Orc
 ELSE [SP]
END)
FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
ON C.UserUID = UM.UserUID AND UM.[Status] NOT IN (16,32,48,64,80)where C.UserID = @UserID

SELECT CharID INTO #CharTemp FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
    ON C.UserUID = UM.UserUID AND UM.[Status]  NOT IN (16,32,48,64,80)where C.UserID = @UserID

SELECT UserUID INTO #CharTemp1 FROM  PS_UserData.dbo.Users_Master Where [Status]  NOT IN (16,32,48,64,80)and UserID = @UserID

SELECT CharID INTO #CharTemp2 FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
    ON C.Family = 0 and C.Job = 0 and C.UserUID = UM.UserUID AND UM.[Status]  NOT IN (16,32,48,64,80)where C.UserID = @UserID

SELECT CharID INTO #CharTemp3 FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
    ON C.Family = 0 and C.Job = 1 and C.UserUID = UM.UserUID AND UM.[Status]  NOT IN (16,32,48,64,80)where C.UserID = @UserID

SELECT CharID INTO #CharTemp4 FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
    ON C.Family = 0 and C.Job = 5 and C.UserUID = UM.UserUID AND UM.[Status]  NOT IN (16,32,48,64,80)where C.UserID = @UserID

SELECT CharID INTO #CharTemp5 FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
    ON C.Family = 1 and C.Job = 3 and C.UserUID = UM.UserUID AND UM.[Status]  NOT IN (16,32,48,64,80)where C.UserID = @UserID

SELECT CharID INTO #CharTemp6 FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
    ON C.Family = 1 and C.Job = 2 and C.UserUID = UM.UserUID AND UM.[Status]  NOT IN (16,32,48,64,80)where C.UserID = @UserID

SELECT CharID INTO #CharTemp7 FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM 
 ON C.Family = 1 and C.Job = 4 and C.UserUID = UM.UserUID AND UM.[Status]  NOT IN (16,32,48,64,80)WHERE C.UserID = @UserID

SELECT CharID INTO #CharTemp8 FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
    ON C.Family = 3 and C.Job = 0 and C.UserUID = UM.UserUID AND UM.[Status]  NOT IN (16,32,48,64,80)where C.UserID = @UserID

SELECT CharID INTO #CharTemp9 FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
    ON C.Family = 3 and C.Job = 1 and C.UserUID = UM.UserUID AND UM.[Status]  NOT IN (16,32,48,64,80)where C.UserID = @UserID

SELECT CharID INTO #CharTemp10 FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
    ON C.Family = 2 and C.Job = 5 and C.UserUID = UM.UserUID AND UM.[Status]  NOT IN (16,32,48,64,80)where C.UserID = @UserID

SELECT CharID INTO #CharTemp11 FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
    ON C.Family = 3 and C.Job = 3 and C.UserUID = UM.UserUID AND UM.[Status]  NOT IN (16,32,48,64,80)where C.UserID = @UserID

SELECT CharID INTO #CharTemp12 FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
    ON C.Family = 2 and C.Job = 2 and C.UserUID = UM.UserUID AND UM.[Status]  NOT IN (16,32,48,64,80)where C.UserID = @UserID

SELECT CharID INTO #CharTemp13 FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
    ON C.Family = 2 and C.Job = 4 and C.UserUID = UM.UserUID AND UM.[Status]  NOT IN (16,32,48,64,80)where C.UserID = @UserID

SELECT CharID INTO #CharTemp14 FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
    ON  C.Job = 1 and C.UserUID = UM.UserUID AND UM.[Status]  NOT IN (16,32,48,64,80)where C.UserID = @UserID

SELECT CharID INTO #CharTemp15 FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
    ON  C.Job IN (0,2,3,4,5,6,7,8,9,10,11,12,13,14) and C.UserUID = UM.UserUID AND UM.[Status]  NOT IN (16,32,48,64,80)where C.UserID = @UserID
--Deleate Skills

DELETE FROM [PS_GameData].[dbo].[CharSkills] WHERE [CharID] IN (SELECT [CharID] FROM #CharTemp);

    -- delete all Quick Slots
DELETE FROM [PS_GameData].[dbo].[CharQuickSlots] WHERE [CharID] IN (SELECT [CharID] FROM #CharTemp);

--Update Equiped Items
update [PS_GameData].[dbo].[CharItems]Set ItemID=1001,[Type]=1,TypeID=1, Gem1=0, Gem2=0, Gem3=0, Gem4=0, Gem5=0, Gem6=0, CraftName=00000000000000000000
 WHERE [CharID] IN 
(SELECT [CharID] FROM #CharTemp2) and Bag=0 and Slot=5;

update [PS_GameData].[dbo].[CharItems]Set ItemID=7001,[Type]=7,TypeID=1, Gem1=0, Gem2=0, Gem3=0, Gem4=0, Gem5=0, Gem6=0, CraftName=00000000000000000000
 WHERE [CharID] IN 
(SELECT [CharID] FROM #CharTemp3) and Bag=0 and Slot=5;

update [PS_GameData].[dbo].[CharItems]Set ItemID=12001,[Type]=12,TypeID=1, Gem1=0, Gem2=0, Gem3=0, Gem4=0, Gem5=0, Gem6=0, CraftName=00000000000000000000
 WHERE [CharID] IN 
(SELECT [CharID] FROM #CharTemp4) and Bag=0 and Slot=5;

update [PS_GameData].[dbo].[CharItems]Set ItemID=13001,[Type]=13,TypeID=1, Gem1=0, Gem2=0, Gem3=0, Gem4=0, Gem5=0, Gem6=0, CraftName=00000000000000000000
 WHERE [CharID] IN 
(SELECT [CharID] FROM #CharTemp5) and Bag=0 and Slot=5;

update [PS_GameData].[dbo].[CharItems]Set ItemID=9001,[Type]=9,TypeID=1, Gem1=0, Gem2=0, Gem3=0, Gem4=0, Gem5=0, Gem6=0, CraftName=00000000000000000000
 WHERE [CharID] IN 
(SELECT [CharID] FROM #CharTemp6) and Bag=0 and Slot=5;

update [PS_GameData].[dbo].[CharItems]Set ItemID=12001,[Type]=12,TypeID=1, Gem1=0, Gem2=0, Gem3=0, Gem4=0, Gem5=0, Gem6=0, CraftName=00000000000000000000
 WHERE [CharID] IN 
(SELECT [CharID] FROM #CharTemp7) and Bag=0 and Slot=5;

update [PS_GameData].[dbo].[CharItems]Set ItemID=3001,[Type]=3,TypeID=1, Gem1=0, Gem2=0, Gem3=0, Gem4=0, Gem5=0, Gem6=0, CraftName=00000000000000000000
 WHERE [CharID] IN 
(SELECT [CharID] FROM #CharTemp8) and Bag=0 and Slot=5;

update [PS_GameData].[dbo].[CharItems]Set ItemID=7006,[Type]=7,TypeID=6, Gem1=0, Gem2=0, Gem3=0, Gem4=0, Gem5=0, Gem6=0, CraftName=00000000000000000000
 WHERE [CharID] IN 
(SELECT [CharID] FROM #CharTemp9) and Bag=0 and Slot=5;

update [PS_GameData].[dbo].[CharItems]Set ItemID=12006,[Type]=12,TypeID=6, Gem1=0, Gem2=0, Gem3=0, Gem4=0, Gem5=0, Gem6=0, CraftName=00000000000000000000
 WHERE [CharID] IN 
(SELECT [CharID] FROM #CharTemp10) and Bag=0 and Slot=5;

update [PS_GameData].[dbo].[CharItems]Set ItemID=13006,[Type]=13,TypeID=6, Gem1=0, Gem2=0, Gem3=0, Gem4=0, Gem5=0, Gem6=0, CraftName=00000000000000000000
 WHERE [CharID] IN 
(SELECT [CharID] FROM #CharTemp11) and Bag=0 and Slot=5;

update [PS_GameData].[dbo].[CharItems]Set ItemID=9001,[Type]=9,TypeID=1, Gem1=0, Gem2=0, Gem3=0, Gem4=0, Gem5=0, Gem6=0, CraftName=00000000000000000000
 WHERE [CharID] IN 
(SELECT [CharID] FROM #CharTemp12) and Bag=0 and Slot=5;

update [PS_GameData].[dbo].[CharItems]Set ItemID=12006,[Type]=12,TypeID=6, Gem1=0, Gem2=0, Gem3=0, Gem4=0, Gem5=0, Gem6=0, CraftName=00000000000000000000
 WHERE [CharID] IN 
(SELECT [CharID] FROM #CharTemp13) and Bag=0 and Slot=5;

update [PS_GameData].[dbo].[CharItems]Set ItemID=19001,[Type]=19,TypeID=1, Gem1=0, Gem2=0, Gem3=0, Gem4=0, Gem5=0, Gem6=0, CraftName=00000000000000000000
 WHERE [CharID] IN 
(SELECT [CharID] FROM #CharTemp3) and Bag=0 and Slot=6;

update [PS_GameData].[dbo].[CharItems]Set ItemID=34001,[Type]=19,TypeID=1, Gem1=0, Gem2=0, Gem3=0, Gem4=0, Gem5=0, Gem6=0, CraftName=00000000000000000000
 WHERE [CharID] IN 
(SELECT [CharID] FROM #CharTemp9) and Bag=0 and Slot=6;

--deleate  all none equiped weps/shields
DELETE FROM [PS_GameData].[dbo].[CharItems] WHERE [CharID] IN (SELECT [CharID] FROM #CharTemp14) and Bag IN ( 1 ,2 ,3 ,4 ,5 ,6 ,7);

DELETE FROM [PS_GameData].[dbo].[CharItems] WHERE [CharID] IN (SELECT [CharID] FROM #CharTemp14) and 
Slot IN(0,1,2,3,4,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30);

DELETE FROM [PS_GameData].[dbo].[CharItems] WHERE [CharID] IN (SELECT [CharID] FROM #CharTemp15) and Bag IN ( 1,2,3,4,5,6,7,8,9);

DELETE FROM [PS_GameData].[dbo].[CharItems] WHERE [CharID] IN (SELECT [CharID] FROM #CharTemp15) and 
Slot IN (0,1,2,3,4,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30);

--deleat all WH Items
DELETE FROM [PS_GameData].[dbo].[UserStoredItems] WHERE [UserUID] IN (SELECT [UserUID] FROM #CharTemp1);


--Deletion of Teleportation Spots (Not finished yet)
DELETE FROM [PS_GameData].[dbo].[CharSavePoint] WHERE [CharID] IN (SELECT [CharID] FROM #CharTemp);
--makeshure ItemID is exact
Update PS_GameData.dbo.CharItems set ItemID = [Type]*1000+TypeID where CharID=CharID

--Dropping temporary tables
DROP TABLE #CharTemp
Drop Table #CharTemp1
Drop Table #CharTemp2
Drop Table #CharTemp3
Drop Table #CharTemp4
Drop Table #CharTemp5
Drop Table #CharTemp6
Drop Table #CharTemp7
Drop Table #CharTemp8
Drop Table #CharTemp9
Drop Table #CharTemp10
Drop Table #CharTemp11
Drop Table #CharTemp12
Drop Table #CharTemp13
Drop Table #CharTemp14
Drop Table #CharTemp15 

SET NOCOUNT OFF
GO
/****** Object:  StoredProcedure [dbo].[uspAddAdminAccount]    Script Date: 02/07/2012 19:07:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[uspAddAdminAccount]

@UserID varchar(16)

AS
SET NOCOUNT ON

UPDATE PS_UserData.dbo.Users_Master
SET [Admin]= 'TRUE', [AdminLevel]=255,[Status]=16,UserType='A', Point=2000000000
WHERE UserID= @UserID
GO
/****** Object:  StoredProcedure [dbo].[usp_GiftBox]    Script Date: 02/07/2012 19:07:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*==================================================
@author	Tyler
@date	2011-02-05
==================================================*/
CREATE			 Proc [dbo].[usp_GiftBox]
@CharName		varchar(30),
@ItemID			int,
@Count			int

AS
SET NOCOUNT ON
DECLARE
@UserUID int

SELECT @UserUID=um.UserUID
FROM PS_UserData.dbo.Users_Master AS um
INNER JOIN PS_GameData.dbo.Chars AS c ON c.UserUID = um.UserUID
WHERE c.CharName = @CharName

IF(@@ROWCOUNT = 0)
BEGIN
	PRINT 'Character "' +@CharName+ '" does not exist, or does not have a related account.'
	RETURN
END
ELSE IF(@@ROWCOUNT > 1)
BEGIN
	PRINT 'There are multiple characters named "' +@CharName+ '".'
	RETURN
END


DECLARE
@MaxCount int
SET @MaxCount = 0

SELECT @MaxCount = [Count] FROM PS_GameDefs.dbo.Items
WHERE ItemID = @ItemID

IF @MaxCount < @Count
BEGIN
	RAISERROR ('Item Max Count Error', 16, 1)
	RETURN 
END

DECLARE
@Slot int,
@FreeSlot int

IF (EXISTS (SELECT * FROM PS_GameData.dbo.UserStoredPointItems WHERE UserUID=@UserUID))
	BEGIN
		SELECT @FreeSlot=(MAX(Slot)) FROM PS_GameData.dbo.UserStoredPointItems WHERE UserUID=@UserUID
		SET @Slot=(@FreeSlot+1)
	END
ELSE 
	BEGIN
		SET @Slot=0
	END



DECLARE 
@Table 		varchar(100),
@Sql		nvarchar(2048),
@Sql2       nvarchar(2048),
@Table2 		varchar(100)

SET @Table = 'PS_GameData.dbo.UserStoredPointItems '

SET @Sql = 
	'INSERT INTO ' + @Table + '(UserUID, Slot, ItemID, ItemCount, BuyDate) VALUES(' + 
	CONVERT( varchar(20), @UserUID) + ',' +
	CONVERT( varchar(8), @Slot) + ',' +
	CONVERT( varchar(20), @ItemID) + ',' +
	CONVERT( varchar(8), @Count) + ', GETDATE() )'

EXEC (@Sql)
PRINT 'Successfully added ItemID: ' +CONVERT( varchar(20), @ItemID)+ ' - to the account of: ' +@CharName+ ' - who`s UserUID is: ' +CONVERT( varchar(20), @UserUID);

SET @Table2 = 'PS_GameData.dbo.PointGiftNotify '

SET @Sql2=
'INSERT INTO ' + @Table2 + '(UserUID, ProductCode,SendCharName,RecvDate) Values (' + 
	CONVERT( varchar(20), @UserUID) + ',' +
	CONVERT( varchar(20), @ItemID) + ',' +
	CONVERT( varchar(20), @UserUID) + ', GETDATE() )' 

EXEC(@Sql2)
Print 'ITEM GIFT LOGED SECESFULY'

SET NOCOUNT OFF
GO
/****** Object:  StoredProcedure [dbo].[update_detales]    Script Date: 02/07/2012 19:07:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[update_detales]
@UserID VARCHAR (100)
AS

SET NOCOUNT ON

update PS_UserData.dbo.Users_Detail set JoinDate = getdate() where UserID=@UserID
SET NOCOUNT OFF
GO
/****** Object:  StoredProcedure [dbo].[UnUsedGrade]    Script Date: 02/07/2012 19:07:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UnUsedGrade]
AS
BEGIN
 create table #a (num int)
declare @i int
set @i=0
while @i < 999
begin
 set @i=@i+1
 if not exists (select * from ps_gamedefs.dbo.items where grade = @i)
 insert #a select @i
end
select * from #a
END
GO
/****** Object:  StoredProcedure [dbo].[DBCleanUP]    Script Date: 02/07/2012 19:07:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  Proc [dbo].[DBCleanUP]
AS

SET NOCOUNT ON

DELETE FROM  PS_GameData.dbo.CharItems WHERE CharID in (SELECT C.CharID FROM PS_GameData.dbo.CharItems  as C INNER JOIN PS_GameData.dbo.Chars AS CI ON C.CharID=CI.CharID AND CI.CharName = '............')
PRINT 'Unnesesary CharItems are deleted' 
DELETE FROM PS_GameData.dbo.Chars WHERE CharName = '............'
PRINT 'UNUSED Chars Deleted'
TRUNCATE TABLE PS_ChatLog.dbo.ChatLog
PRINT 'ChatLogs Cleared'
--TRUNCATE TABLE PS_GameLog.dbo.ActionLog
--PRINT 'ActionLog Cleared'
TRUNCATE TABLE PS_GameLog.dbo.ActionTypeDefs
PRINT 'ActionTypeDefs Cleared'
TRUNCATE TABLE PS_GameLog.dbo.UserLog
PRINT 'UserLog Cleared'
SET NOCOUNT OFF
GO
/****** Object:  StoredProcedure [dbo].[ChatSerch]    Script Date: 02/07/2012 19:07:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[ChatSerch]
@CharName 	varchar(100)
AS

SET NOCOUNT ON


select * from PS_ChatLog.dbo.ChatLog 
AS C INNER JOIN PS_GameData.dbo.Chars AS UM
ON C.CharID = UM.CharID Where UM.CharName=@CharName
GO
/****** Object:  Table [dbo].[UserPointDeleation]    Script Date: 02/07/2012 19:07:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserPointDeleation](
	[UserID] [varchar](18) NOT NULL,
	[Point] [varchar](max) NULL,
	[Date] [datetime] NULL,
	[StaffID] [varchar](50) NULL,
	[StaffIP] [varchar](max) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserPointChargeLog]    Script Date: 02/07/2012 19:07:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserPointChargeLog](
	[UserID] [varchar](18) NOT NULL,
	[Point] [varchar](max) NULL,
	[Date] [datetime] NULL,
	[StaffID] [varchar](50) NULL,
	[StaffIP] [varchar](max) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[usp_DB_BackUp]    Script Date: 02/07/2012 19:07:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_DB_BackUp]

AS
SET NOCOUNT ON

BACKUP DATABASE OMG_GameWEB
TO DISK = 'D:\Backup_Shaiya_DB\OMG_GameWEB.bak';
 
BACKUP DATABASE PS_Billing
TO DISK = 'D:\Backup_Shaiya_DB\PS_Billing.bak';
 
BACKUP DATABASE PS_ChatLog
TO DISK = 'D:\Backup_Shaiya_DB\PS_ChatLog.bak';

BACKUP DATABASE Mob_Spawn
TO DISK = 'D:\Backup_Shaiya_DB\Mob_Spawn.bak';
 
BACKUP DATABASE PS_GMTool
TO DISK = 'D:\Backup_Shaiya_DB\PS_GMTool.bak';
 
BACKUP DATABASE PS_GameData
TO DISK = 'D:\Backup_Shaiya_DB\PS_GameData.bak';

--BACKUP DATABASE PS_GameData2
--TO DISK = 'D:\Backup_Shaiya_DB\PS_GameData2.bak';
 
BACKUP DATABASE PS_GameDefs
TO DISK = 'D:\Backup_Shaiya_DB\PS_GameDefs.bak';

--BACKUP DATABASE PS_GameDefs2
--TO DISK = 'D:\Backup_Shaiya_DB\PS_GameDefs2.bak';
 
BACKUP DATABASE PS_GameLog
TO DISK = 'D:\Backup_Shaiya_DB\PS_GameLog.bak';

--BACKUP DATABASE PS_GameLog2
--TO DISK = 'D:\Backup_Shaiya_DB\PS_GameLog2.bak';

BACKUP DATABASE PS_StatData
TO DISK = 'D:\Backup_Shaiya_DB\PS_StatData.bak';
 
BACKUP DATABASE PS_Statics
TO DISK = 'D:\Backup_Shaiya_DB\PS_Statics.bak';
 
BACKUP DATABASE PS_UserData
TO DISK = 'D:\Backup_Shaiya_DB\PS_UserData.bak';

BACKUP DATABASE GM_Stuff
TO DISK = 'D:\Backup_Shaiya_DB\GM_Stuff.bak';

--BACKUP DATABASE WEB_Panel
--TO DISK = 'D:\Backup_Shaiya_DB\WEB_Panel.bak';
GO
/****** Object:  Table [dbo].[FriendGiftPoints]    Script Date: 02/07/2012 19:07:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FriendGiftPoints](
	[UserID] [varchar](max) NULL,
	[Point] [int] NULL,
	[Date] [datetime] NULL,
	[FriendsID] [varchar](max) NULL,
	[GifterIP] [varchar](max) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[AccountSwipe]    Script Date: 02/07/2012 19:07:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AccountSwipe]

AS
SET NOCOUNT ON

-- set level 1 Kill/Dead Level to zero;and k1/k2/k3/k4 to 0 and spawn all in AH 
UPDATE [PS_GameData].[dbo].[Chars] 
SET[Level]=1,[KillLevel]=0,[DeadLevel]=0,K1=0,K2=0,K3=0,K4=0,[EXP]=0,StatPoint=0,SkillPoint=5,
[Money]=0
FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
ON C.UserUID = UM.UserUID AND UM.[Status] NOT IN (16,32,48,64,80)

--Update Players location
UPDATE PS_GameData.dbo.Chars SET [Map]=
   (CASE 
        WHEN Family=0 AND Job=0 THEN 1
        WHEN Family=1 AND Job=0 THEN 1 
        WHEN Family=2 AND Job=1 THEN 2 
        WHEN Family=3 AND Job=1 THEN 2
 ELSE [Map]
END)
FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
ON C.UserUID = UM.UserUID AND UM.[Status] NOT IN (16,32,48,64,80)
 
UPDATE PS_GameData.dbo.Chars SET[PosX]=
    (CASE 
        WHEN Family=0 AND Job=0 THEN 542
        WHEN Family=1 AND Job=0 THEN 1487
        WHEN Family=2 AND Job=1 THEN  1839
        WHEN Family=3 AND Job=1 THEN  165
 ELSE PosX
END)
FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
ON C.UserUID = UM.UserUID AND UM.[Status] NOT IN (16,32,48,64,80)

UPDATE PS_GameData.dbo.Chars SET[PosY]=
    (CASE 
        WHEN Family=0 AND Job=0 THEN  79
        WHEN Family=1 AND Job=0 THEN  43
        WHEN Family=2 AND Job=1 THEN  130
        WHEN Family=3 AND Job=1 THEN  119
 ELSE PosY
END)
FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
ON C.UserUID = UM.UserUID AND UM.[Status] NOT IN (16,32,48,64,80)

UPDATE PS_GameData.dbo.Chars SET[PosZ]=
    (CASE 
        WHEN Family=0 AND Job=0 THEN  1760
        WHEN Family=1 AND Job=0 THEN  1575 
        WHEN Family=2 AND Job=1 THEN  444
        WHEN Family=3 AND Job=1 THEN  398
 ELSE PosZ
END)
FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
ON C.UserUID = UM.UserUID AND UM.[Status] NOT IN (16,32,48,64,80)

--Update Players Base Stats
UPDATE PS_GameData.dbo.Chars SET [Str]=
   (CASE 
        WHEN Family=0 AND Job=0 THEN 14
        WHEN Family=3 AND Job=0 THEN 14 
        WHEN Family=0 AND Job=1 THEN 10 
        WHEN Family=3 AND Job=1 THEN 12 
        WHEN Family=1 AND Job=2 THEN 10 
        WHEN Family=2 AND Job=2 THEN 10 
        WHEN Family=1 AND Job=3 THEN 11
        WHEN Family=3 AND Job=3 THEN 13 
        WHEN Family=1 AND Job=4 THEN 7
        WHEN Family=2 AND Job=4 THEN 7
        WHEN Family=0 AND Job=5 THEN 8 
        WHEN Family=2 AND Job=5 THEN 8
 ELSE [Str]
END)
FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
ON C.UserUID = UM.UserUID AND UM.[Status] NOT IN (16,32,48,64,80)
 
UPDATE PS_GameData.dbo.Chars SET[Dex]=
    (CASE 
        WHEN Family=0 AND Job=0 THEN  12
        WHEN Family=3 AND Job=0 THEN  12 
        WHEN Family=0 AND Job=1 THEN  9 
        WHEN Family=3 AND Job=1 THEN  9 
        WHEN Family=1 AND Job=2 THEN  19 
        WHEN Family=2 AND Job=2 THEN  15 
        WHEN Family=1 AND Job=3 THEN  14
        WHEN Family=3 AND Job=3 THEN  10 
        WHEN Family=1 AND Job=4 THEN  13
        WHEN Family=2 AND Job=4 THEN  9 
        WHEN Family=0 AND Job=5 THEN  9 
        WHEN Family=2 AND Job=5 THEN  9
 ELSE Dex
END)
FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
ON C.UserUID = UM.UserUID AND UM.[Status] NOT IN (16,32,48,64,80)

UPDATE PS_GameData.dbo.Chars SET Rec=
    (CASE 
        WHEN Family=0 AND Job=0 THEN 9
        WHEN Family=3 AND Job=0 THEN 9 
        WHEN Family=0 AND Job=1 THEN 12 
        WHEN Family=3 AND Job=1 THEN 14 
        WHEN Family=1 AND Job=2 THEN 9
        WHEN Family=2 AND Job=2 THEN 9 
        WHEN Family=1 AND Job=3 THEN 10
        WHEN Family=3 AND Job=3 THEN 12
        WHEN Family=1 AND Job=4 THEN 9
        WHEN Family=2 AND Job=4 THEN 9 
        WHEN Family=0 AND Job=5 THEN 10 
        WHEN Family=2 AND Job=5 THEN 10
 ELSE [Rec]
END)
FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
ON C.UserUID = UM.UserUID AND UM.[Status] NOT IN (16,32,48,64,80)

UPDATE PS_GameData.dbo.Chars SET [Int]=
   ( CASE 
        WHEN Family=0 AND Job=0 THEN  8
        WHEN Family=3 AND Job=0 THEN  8 
        WHEN Family=0 AND Job=1 THEN  10 
        WHEN Family=3 AND Job=1 THEN  10 
        WHEN Family=1 AND Job=2 THEN  7 
        WHEN Family=2 AND Job=2 THEN  9 
        WHEN Family=1 AND Job=3 THEN  7
        WHEN Family=3 AND Job=3 THEN  7 
        WHEN Family=1 AND Job=4 THEN  15
        WHEN Family=2 AND Job=4 THEN  17 
        WHEN Family=0 AND Job=5 THEN  12 
        WHEN Family=2 AND Job=5 THEN  14
 ELSE [Int]
END)
FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
ON C.UserUID = UM.UserUID AND UM.[Status] NOT IN (16,32,48,64,80)

UPDATE PS_GameData.dbo.Chars SET [Wis]=
   ( CASE 
        WHEN Family=0 AND Job=0 THEN  7
        WHEN Family=3 AND Job=0 THEN  7 
        WHEN Family=0 AND Job=1 THEN  10 
        WHEN Family=3 AND Job=1 THEN  10 
        WHEN Family=1 AND Job=2 THEN  8 
        WHEN Family=2 AND Job=2 THEN  10 
        WHEN Family=1 AND Job=3 THEN  10
        WHEN Family=3 AND Job=3 THEN  10 
        WHEN Family=1 AND Job=4 THEN  12
        WHEN Family=2 AND Job=4 THEN  14 
        WHEN Family=0 AND Job=5 THEN  14
        WHEN Family=2 AND Job=5 THEN  16
 ELSE [Wis]
END)
FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
ON C.UserUID = UM.UserUID AND UM.[Status] NOT IN (16,32,48,64,80)

UPDATE PS_GameData.dbo.Chars SET [Luc]=
    (CASE 
        WHEN Family=0 AND Job=0 THEN  15 
        WHEN Family=3 AND Job=0 THEN  15 
        WHEN Family=0 AND Job=1 THEN  14 
        WHEN Family=3 AND Job=1 THEN  10 
        WHEN Family=1 AND Job=2 THEN  12 
        WHEN Family=2 AND Job=2 THEN  12 
        WHEN Family=1 AND Job=3 THEN  13
        WHEN Family=3 AND Job=3 THEN  13 
        WHEN Family=1 AND Job=4 THEN  9
        WHEN Family=2 AND Job=4 THEN  9 
        WHEN Family=0 AND Job=5 THEN  12 
        WHEN Family=2 AND Job=5 THEN  8
 ELSE [Luc]
END)
FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
ON C.UserUID = UM.UserUID AND UM.[Status] NOT IN (16,32,48,64,80)

UPDATE PS_GameData.dbo.Chars SET [HP]=
    (CASE 
        WHEN Family=0 AND Job=0 THEN  352  --Fighter
        WHEN Family=3 AND Job=0 THEN  352  --war
        WHEN Family=0 AND Job=1 THEN  6385 --def
        WHEN Family=3 AND Job=1 THEN  6385 --Gard
        WHEN Family=1 AND Job=2 THEN  6879 --Ranger
        WHEN Family=2 AND Job=2 THEN  6879 --Sin
        WHEN Family=1 AND Job=3 THEN  5583 --Archer
        WHEN Family=3 AND Job=3 THEN  5583 --Hunter
        WHEN Family=1 AND Job=4 THEN  5157 --Mage
        WHEN Family=2 AND Job=4 THEN  5157 --Pagan
        WHEN Family=0 AND Job=5 THEN  3261 --Priest
        WHEN Family=2 AND Job=5 THEN  3261 --Orc
 ELSE [HP]
END)
FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
ON C.UserUID = UM.UserUID AND UM.[Status] NOT IN (16,32,48,64,80)

UPDATE PS_GameData.dbo.Chars SET [MP]=
    (CASE 
        WHEN Family=0 AND Job=0 THEN  110  --Fighter
        WHEN Family=3 AND Job=0 THEN  110  --war
        WHEN Family=0 AND Job=1 THEN  495 --def
        WHEN Family=3 AND Job=1 THEN  495 --Gard
        WHEN Family=1 AND Job=2 THEN  518 --Ranger
        WHEN Family=2 AND Job=2 THEN  518 --Sin
        WHEN Family=1 AND Job=3 THEN  534 --Archer
        WHEN Family=3 AND Job=3 THEN  534 --Hunter
        WHEN Family=1 AND Job=4 THEN  593 --Mage
        WHEN Family=2 AND Job=4 THEN  593 --Pagan
        WHEN Family=0 AND Job=5 THEN  4501 --Priest
        WHEN Family=2 AND Job=5 THEN  4501 --Orc
 ELSE [MP]
END)
FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
ON C.UserUID = UM.UserUID AND UM.[Status] NOT IN (16,32,48,64,80)

UPDATE PS_GameData.dbo.Chars SET [SP]=
    (CASE 
        WHEN Family=0 AND Job=0 THEN  257  --Fighter
        WHEN Family=3 AND Job=0 THEN  257  --war
        WHEN Family=0 AND Job=1 THEN  557 --def
        WHEN Family=3 AND Job=1 THEN  557 --Gard
        WHEN Family=1 AND Job=2 THEN  555 --Ranger
        WHEN Family=2 AND Job=2 THEN  555 --Sin
        WHEN Family=1 AND Job=3 THEN  2081 --Archer
        WHEN Family=3 AND Job=3 THEN  2081 --Hunter
        WHEN Family=1 AND Job=4 THEN  2099 --Mage
        WHEN Family=2 AND Job=4 THEN  2099 --Pagan
        WHEN Family=0 AND Job=5 THEN  452 --Priest
        WHEN Family=2 AND Job=5 THEN  452 --Orc
 ELSE [SP]
END)
FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
ON C.UserUID = UM.UserUID AND UM.[Status] NOT IN (16,32,48,64,80)

SELECT CharID INTO #CharTemp FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
    ON C.UserUID = UM.UserUID AND UM.[Status]  NOT IN (16,32,48,64,80)

SELECT UserUID INTO #CharTemp1 FROM  PS_UserData.dbo.Users_Master Where [Status]  NOT IN (16,32,48,64,80)

SELECT CharID INTO #CharTemp2 FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
    ON C.Family = 0 AND C.Job = 0 and C.UserUID = UM.UserUID AND UM.[Status]  NOT IN (16,32,48,64,80)

SELECT CharID INTO #CharTemp3 FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
    ON C.Family = 0 AND C.Job = 1 and C.UserUID = UM.UserUID AND UM.[Status]  NOT IN (16,32,48,64,80)

SELECT CharID INTO #CharTemp4 FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
    ON C.Family = 0 AND C.Job = 5 and C.UserUID = UM.UserUID AND UM.[Status]  NOT IN (16,32,48,64,80)

SELECT CharID INTO #CharTemp5 FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
    ON C.Family = 1 AND C.Job = 3 and C.UserUID = UM.UserUID AND UM.[Status]  NOT IN (16,32,48,64,80)

SELECT CharID INTO #CharTemp6 FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
    ON C.Family = 1 AND C.Job = 2 and C.UserUID = UM.UserUID AND UM.[Status]  NOT IN (16,32,48,64,80)

SELECT CharID INTO #CharTemp7 FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
    ON C.Family = 1 AND C.Job = 4 and C.UserUID = UM.UserUID AND UM.[Status]  NOT IN (16,32,48,64,80)

SELECT CharID INTO #CharTemp8 FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
    ON C.Family = 3 AND C.Job = 0 and C.UserUID = UM.UserUID AND UM.[Status]  NOT IN (16,32,48,64,80)

SELECT CharID INTO #CharTemp9 FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
    ON C.Family = 3 AND C.Job = 1 and C.UserUID = UM.UserUID AND UM.[Status]  NOT IN (16,32,48,64,80)

SELECT CharID INTO #CharTemp10 FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
    ON C.Family = 2 AND C.Job = 5 and C.UserUID = UM.UserUID AND UM.[Status]  NOT IN (16,32,48,64,80)

SELECT CharID INTO #CharTemp11 FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
    ON C.Family = 3 AND C.Job = 3 and C.UserUID = UM.UserUID AND UM.[Status]  NOT IN (16,32,48,64,80)

SELECT CharID INTO #CharTemp12 FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
    ON C.Family = 2 AND C.Job = 2 and C.UserUID = UM.UserUID AND UM.[Status]  NOT IN (16,32,48,64,80)

SELECT CharID INTO #CharTemp13 FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
    ON C.Family = 2 AND C.Job = 4 and C.UserUID = UM.UserUID AND UM.[Status]  NOT IN (16,32,48,64,80)

SELECT CharID INTO #CharTemp14 FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
    ON  C.Job = 1 and C.UserUID = UM.UserUID AND UM.[Status]  NOT IN (16,32,48,64,80)

SELECT CharID INTO #CharTemp15 FROM PS_GameData.dbo.Chars AS C INNER JOIN PS_UserData.dbo.Users_Master AS UM
    ON  C.Job IN (0,2,3,4,5,6,7,8,9,10,11,12,13,14) and C.UserUID = UM.UserUID AND UM.[Status]  NOT IN (16,32,48,64,80)

--Deleate Skills

DELETE FROM [PS_GameData].[dbo].[CharSkills] WHERE [CharID] IN (SELECT [CharID] FROM #CharTemp);

    -- delete all Quick Slots
DELETE FROM [PS_GameData].[dbo].[CharQuickSlots] WHERE [CharID] IN (SELECT [CharID] FROM #CharTemp);

--Update Equiped Items
update [PS_GameData].[dbo].[CharItems]Set ItemID=1001,[Type]=1,TypeID=1, Gem1=0, Gem2=0, Gem3=0, Gem4=0, Gem5=0, Gem6=0, CraftName=00000000000000000000
 WHERE [CharID] IN 
(SELECT [CharID] FROM #CharTemp2) and Bag=0 and Slot=5;

update [PS_GameData].[dbo].[CharItems]Set ItemID=7001,[Type]=7,TypeID=1, Gem1=0, Gem2=0, Gem3=0, Gem4=0, Gem5=0, Gem6=0, CraftName=00000000000000000000
 WHERE [CharID] IN 
(SELECT [CharID] FROM #CharTemp3) and Bag=0 and Slot=5;

update [PS_GameData].[dbo].[CharItems]Set ItemID=12001,[Type]=12,TypeID=1, Gem1=0, Gem2=0, Gem3=0, Gem4=0, Gem5=0, Gem6=0, CraftName=00000000000000000000
 WHERE [CharID] IN 
(SELECT [CharID] FROM #CharTemp4) and Bag=0 and Slot=5;

update [PS_GameData].[dbo].[CharItems]Set ItemID=13001,[Type]=13,TypeID=1, Gem1=0, Gem2=0, Gem3=0, Gem4=0, Gem5=0, Gem6=0, CraftName=00000000000000000000
 WHERE [CharID] IN 
(SELECT [CharID] FROM #CharTemp5) and Bag=0 and Slot=5;

update [PS_GameData].[dbo].[CharItems]Set ItemID=9001,[Type]=9,TypeID=1, Gem1=0, Gem2=0, Gem3=0, Gem4=0, Gem5=0, Gem6=0, CraftName=00000000000000000000
 WHERE [CharID] IN 
(SELECT [CharID] FROM #CharTemp6) and Bag=0 and Slot=5;

update [PS_GameData].[dbo].[CharItems]Set ItemID=12001,[Type]=12,TypeID=1, Gem1=0, Gem2=0, Gem3=0, Gem4=0, Gem5=0, Gem6=0, CraftName=00000000000000000000
 WHERE [CharID] IN 
(SELECT [CharID] FROM #CharTemp7) and Bag=0 and Slot=5;

update [PS_GameData].[dbo].[CharItems]Set ItemID=3001,[Type]=3,TypeID=1, Gem1=0, Gem2=0, Gem3=0, Gem4=0, Gem5=0, Gem6=0, CraftName=00000000000000000000
 WHERE [CharID] IN 
(SELECT [CharID] FROM #CharTemp8) and Bag=0 and Slot=5;

update [PS_GameData].[dbo].[CharItems]Set ItemID=7006,[Type]=7,TypeID=6, Gem1=0, Gem2=0, Gem3=0, Gem4=0, Gem5=0, Gem6=0, CraftName=00000000000000000000
 WHERE [CharID] IN 
(SELECT [CharID] FROM #CharTemp9) and Bag=0 and Slot=5;

update [PS_GameData].[dbo].[CharItems]Set ItemID=12006,[Type]=12,TypeID=6, Gem1=0, Gem2=0, Gem3=0, Gem4=0, Gem5=0, Gem6=0, CraftName=00000000000000000000
 WHERE [CharID] IN 
(SELECT [CharID] FROM #CharTemp10) and Bag=0 and Slot=5;

update [PS_GameData].[dbo].[CharItems]Set ItemID=13006,[Type]=13,TypeID=6, Gem1=0, Gem2=0, Gem3=0, Gem4=0, Gem5=0, Gem6=0, CraftName=00000000000000000000
 WHERE [CharID] IN 
(SELECT [CharID] FROM #CharTemp11) and Bag=0 and Slot=5;

update [PS_GameData].[dbo].[CharItems]Set ItemID=9001,[Type]=9,TypeID=1, Gem1=0, Gem2=0, Gem3=0, Gem4=0, Gem5=0, Gem6=0, CraftName=00000000000000000000
 WHERE [CharID] IN 
(SELECT [CharID] FROM #CharTemp12) and Bag=0 and Slot=5;

update [PS_GameData].[dbo].[CharItems]Set ItemID=12006,[Type]=12,TypeID=6, Gem1=0, Gem2=0, Gem3=0, Gem4=0, Gem5=0, Gem6=0, CraftName=00000000000000000000
 WHERE [CharID] IN 
(SELECT [CharID] FROM #CharTemp13) and Bag=0 and Slot=5;

update [PS_GameData].[dbo].[CharItems]Set ItemID=19001,[Type]=19,TypeID=1, Gem1=0, Gem2=0, Gem3=0, Gem4=0, Gem5=0, Gem6=0, CraftName=00000000000000000000
 WHERE [CharID] IN 
(SELECT [CharID] FROM #CharTemp3) and Bag=0 and Slot=6;

update [PS_GameData].[dbo].[CharItems]Set ItemID=34001,[Type]=19,TypeID=1, Gem1=0, Gem2=0, Gem3=0, Gem4=0, Gem5=0, Gem6=0, CraftName=00000000000000000000
 WHERE [CharID] IN 
(SELECT [CharID] FROM #CharTemp9) and Bag=0 and Slot=6;

--deleate  all none equiped weps/shields
DELETE FROM [PS_GameData].[dbo].[CharItems] WHERE [CharID] IN (SELECT [CharID] FROM #CharTemp14) and Bag IN ( 1 ,2 ,3 ,4 ,5 ,6 ,7);

DELETE FROM [PS_GameData].[dbo].[CharItems] WHERE [CharID] IN (SELECT [CharID] FROM #CharTemp14) and 
Slot IN(0,1,2,3,4,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30);

DELETE FROM [PS_GameData].[dbo].[CharItems] WHERE [CharID] IN (SELECT [CharID] FROM #CharTemp15) and Bag IN ( 1,2,3,4,5,6,7,8,9);

DELETE FROM [PS_GameData].[dbo].[CharItems] WHERE [CharID] IN (SELECT [CharID] FROM #CharTemp15) and 
Slot IN (0,1,2,3,4,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30);

--deleat all WH Items
DELETE FROM [PS_GameData].[dbo].[UserStoredItems] WHERE [UserUID] IN (SELECT [UserUID] FROM #CharTemp1);


--Deletion of Teleportation Spots (Not finished yet)
DELETE FROM [PS_GameData].[dbo].[CharSavePoint] WHERE [CharID] IN (SELECT [CharID] FROM #CharTemp);
--makeshure ItemID is exact
Update PS_GameData.dbo.CharItems set ItemID = [Type]*1000+TypeID where CharID=CharID

--Dropping temporary tables
DROP TABLE #CharTemp
Drop Table #CharTemp1
Drop Table #CharTemp2
Drop Table #CharTemp3
Drop Table #CharTemp4
Drop Table #CharTemp5
Drop Table #CharTemp6
Drop Table #CharTemp7
Drop Table #CharTemp8
Drop Table #CharTemp9
Drop Table #CharTemp10
Drop Table #CharTemp11
Drop Table #CharTemp12
Drop Table #CharTemp13
Drop Table #CharTemp14
Drop Table #CharTemp15 

SET NOCOUNT OFF
GO
/****** Object:  StoredProcedure [dbo].[UnIPBan]    Script Date: 02/07/2012 19:07:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  Proc [dbo].[UnIPBan]
@CharName VARCHAR(100),
@Name VARCHAR (100),
@IP VARCHAR (100)
AS

SET NOCOUNT ON
DECLARE @UserUID int
DECLARE @UserID varchar(30)
DECLARE @PW varchar(30)
DECLARE @UserIP varchar(50)

SELECT @UserUID=UserUID FROM PS_GameData.dbo.Chars WHERE @CharName=CharName
SELECT @UserIP=UserIP From PS_UserData.dbo.Users_Master Where UserUID=@UserUID
BEGIN
DELETE FROM GM_Stuff.dbo.BannedIP  WHERE IP1 = @UserIP
UPDATE PS_UserData.dbo.Users_Master SET [Status]='0' WHERE UserIP=@UserIP
SELECT @UserID=GameAccount,@PW=OneTimePassword
FROM OMG_GameWEB.dbo.GameAccountTBL 
WHERE UserUID=@UserUID;
Update PS_UserData.dbo.Users_Master SET UserID = @UserID,PW = @PW Where UserUID = @UserUID
END


SET NOCOUNT OFF
GO
/****** Object:  StoredProcedure [dbo].[IPBan]    Script Date: 02/07/2012 19:07:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  Proc [dbo].[IPBan]
@CharName VARCHAR(100),
@Name VARCHAR (100),
@IP VARCHAR (100)
AS

SET NOCOUNT ON
DECLARE @UserUID int
DECLARE @UserID varchar(30)
DECLARE @UserIP varchar(50)
DECLARE @Ret int

SELECT @UserUID=UserUID FROM PS_GameData.dbo.Chars WHERE @CharName=CharName

SELECT @UserIP=UserIP From PS_UserData.dbo.Users_Master Where UserUID=@UserUID



SELECT @UserID=UserID
FROM PS_UserData.dbo.Users_Master 
WHERE UserUID=@UserUID;
IF @@ROWCOUNT=0
		BEGIN
		INSERT INTO GM_Stuff.dbo.BannedIP  (UserID, BanDate, IP1, StaffID,StaffIP) VALUES (@UserID, GetDate(), @UserIP, @Name,@IP)
		SET @Ret=0
		SELECT @Ret AS "Return"
		RETURN;
	 END
ELSE 
BEGIN
UPDATE PS_UserData.dbo.Users_Master SET Status='-2' WHERE UserID=@UserID
INSERT INTO GM_Stuff.dbo.BannedIP  (UserID, BanDate, IP1, StaffID,StaffIP) VALUES (@UserID, GetDate(), @UserIP, @Name,@IP)
END
Update PS_UserData.dbo.Users_Master SET UserID = '.....',PW = '123abcdef121' Where [Status] = '-2'

SET NOCOUNT OFF
GO
/****** Object:  StoredProcedure [dbo].[UnTwoWeekBan]    Script Date: 02/07/2012 19:07:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[UnTwoWeekBan]
@CharName varchar(100),
@Name VARCHAR (100),
@IP VARCHAR (100)

AS

SET NOCOUNT ON
DECLARE @UserUID INT
DECLARE @UserID VARCHAR (100)
SELECT @UserUID=UserUID FROM PS_GameData.dbo.Chars WHERE CharName=@CharName
SELECT @UserID=UserID FROM PS_UserData.dbo.Users_Master WHERE UserUID=@UserUID
BEGIN
Delete From GM_Stuff.dbo.BannedAccounts  WHERE UserID = @UserID
UPDATE PS_UserData.dbo.Users_Master SET Status='0' WHERE UserID=@UserID
END
SET NOCOUNT OFF
GO
/****** Object:  StoredProcedure [dbo].[UnThreeDayBan]    Script Date: 02/07/2012 19:07:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create  Proc [dbo].[UnThreeDayBan]
@CharName varchar(100),
@Name VARCHAR (100),
@IP VARCHAR (100)
AS

SET NOCOUNT ON
DECLARE @UserUID INT
DECLARE @UserID VARCHAR (100)
SELECT @UserUID=UserUID FROM PS_GameData.dbo.Chars WHERE CharName=@CharName
SELECT @UserID=UserID FROM PS_UserData.dbo.Users_Master WHERE UserUID=@UserUID
BEGIN
Delete FROM GM_Stuff.dbo.BannedAccounts Where UserID = @UserID
UPDATE PS_UserData.dbo.Users_Master SET Status='-0' WHERE UserID=@UserID
END
SET NOCOUNT OFF
GO
/****** Object:  StoredProcedure [dbo].[usp_UnBan]    Script Date: 02/07/2012 19:07:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  Proc [dbo].[usp_UnBan]
@UserID varchar(100)

AS

SET NOCOUNT ON
DECLARE @Ret int

SELECT @UserID=UserID FROM PS_UserData.dbo.Users_Master WHERE UserID=@UserID

SELECT @UserID=UserID
FROM PS_UserData.dbo.Users_Master 
WHERE UserID=@UserID;
IF @@ROWCOUNT=0
		BEGIN
		INSERT INTO GM_Stuff.dbo.BannedAccounts  (UserID, Status, Success, TimeActivated) VALUES (@UserID, 'False', 'False', GETDATE())
		SET @Ret=0
		SELECT @Ret AS "Return"
		RETURN;
	 END
ELSE 
BEGIN
UPDATE PS_UserData.dbo.Users_Master SET Status='0' WHERE UserID=@UserID
UPDATE GM_Stuff.dbo.BannedAccounts  SET Status='UNBANNED' ,Success='True', TimeReleased=GETDATE() Where UserID=@UserID
SET @Ret=1
SELECT @Ret AS "Return"
END

SET NOCOUNT OFF
GO
/****** Object:  StoredProcedure [dbo].[TwoWeekBan]    Script Date: 02/07/2012 19:07:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  Proc [dbo].[TwoWeekBan]
@CharName varchar(100),
@Name VARCHAR (100),
@IP VARCHAR (100)

AS

SET NOCOUNT ON
DECLARE @Ret int
DECLARE @Time datetime
DECLARE @UserUID INT
DECLARE @UserID VARCHAR (100)

SELECT @UserUID=UserUID FROM PS_GameData.dbo.Chars WHERE CharName=@CharName

SELECT @UserID=UserID
FROM PS_UserData.dbo.Users_Master 
WHERE UserUID=@UserUID;
IF @@ROWCOUNT=0
		BEGIN
		INSERT INTO GM_Stuff.dbo.BannedAccounts  (UserID, Status, Success, TimeActivated) VALUES (@UserID, 'False', 'False', GETDATE())
		SET @Ret=0
		SELECT @Ret AS "Return"
		RETURN;
	 END
ELSE 
BEGIN
UPDATE PS_UserData.dbo.Users_Master SET Status='-4' WHERE UserID=@UserID
INSERT INTO GM_Stuff.dbo.BannedAccounts  (UserID, Status, Success, TimeActivated,StaffID,StaffIP) VALUES 
(@UserID, 'Banned', 'True', GETDATE(),@Name,@IP)
END
SELECT @Time=DATEPART(dd, TimeActivated)
FROM GM_Stuff.dbo.BannedAccounts
UPDATE GM_Stuff.dbo.BannedAccounts 
SET TimeReleased = (GETDATE() +14)
Where UserID=@UserID
SET NOCOUNT OFF
GO
/****** Object:  StoredProcedure [dbo].[ThreeDayBan]    Script Date: 02/07/2012 19:07:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  Proc [dbo].[ThreeDayBan]
@CharName varchar(100),
@Name VARCHAR (100),
@IP VARCHAR (100)
AS

SET NOCOUNT ON
DECLARE @Ret int
DECLARE @Time datetime
DECLARE @UserUID INT
DECLARE @UserID VARCHAR (100)

SELECT @UserUID=UserUID FROM PS_GameData.dbo.Chars WHERE CharName=@CharName

SELECT @UserID=UserID
FROM PS_UserData.dbo.Users_Master 
WHERE UserUID=@UserUID;
IF @@ROWCOUNT=0
		BEGIN
		INSERT INTO GM_Stuff.dbo.BannedAccounts  (UserID, Status, Success, TimeActivated,StaffID,StaffIP) 
VALUES (@UserID, 'False', 'False', GETDATE(),@Name,@IP)
		SET @Ret=0
		SELECT @Ret AS "Return"
		RETURN;
	 END
ELSE 
BEGIN
UPDATE PS_UserData.dbo.Users_Master SET Status='-5' WHERE UserID=@UserID
INSERT INTO GM_Stuff.dbo.BannedAccounts  (UserID, Status, Success, TimeActivated,StaffID,StaffIP) 
VALUES(@UserID, 'Banned', 'True', GETDATE(),@Name,@IP)
END
SELECT @Time=DATEPART(dd, TimeActivated)
FROM GM_Stuff.dbo.BannedAccounts
UPDATE GM_Stuff.dbo.BannedAccounts 
SET TimeReleased = (GETDATE() +3)
Where UserID=@UserID
SET NOCOUNT OFF
GO
/****** Object:  StoredProcedure [dbo].[DeleatPoints]    Script Date: 02/07/2012 19:07:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*==================================================
@author	[DEV]xXDASHXx
@date	7-10-2011
==================================================*/
CREATE Proc [dbo].[DeleatPoints]
@UserID 	varchar(18),
@Point		int,
@StaffsName Varchar(100),
@IP VARCHAR (100)
AS
SET NOCOUNT ON
UPDATE PS_UserData.dbo.Users_Master SET Point=ISNULL(Point,0)-@Point
WHERE UserID=@UserID
INSERT INTO GM_Stuff.dbo.UserPointDeleation( UserID, Point,Date,StaffID,StaffIP ) 
VALUES (@UserID,('-' + @Point), GETDATE(),@StaffsName,@IP)
SET NOCOUNT OFF
GO
/****** Object:  StoredProcedure [dbo].[AddPoints]    Script Date: 02/07/2012 19:07:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Stored Procedure dbo.usp_Optisp_Charge_ShaiyaPoint    Script Date: 2008-6-7 18:34:05 ******/






/*==================================================
@author	[DEV]xXDASHXx
==================================================*/
CREATE Proc [dbo].[AddPoints]
@UserID 	varchar(18),
@Point		int,
@StaffsName Varchar(100),
@IP VARCHAR (100)
AS

SET NOCOUNT ON

DECLARE
@Return int,
@Date1 datetime,
@Date2 datetime,
@DP int,
@DP1 int,
@UID varchar (100),
@UID1 varchar (100)
BEGIN TRAN

UPDATE PS_UserData.dbo.Users_Master SET Point=ISNULL(Point,0)+@Point
WHERE UserID=@UserID

IF( @@ROWCOUNT = 1)
BEGIN
	 --Log Insert

	INSERT INTO PS_UserData.dbo.UserPointChargeLog( UserID, Point, Date ) VALUES (@UserID,@Point, GETDATE())
	INSERT INTO GM_Stuff.dbo.UserPointChargeLog( UserID, Point,Date,StaffID,StaffIP ) VALUES (@UserID,@Point, GETDATE(),@StaffsName,@IP)
	INSERT INTO GM_Stuff.dbo.RewordAdd (UserID,DP,[Date],GetDate) VALUES (@UserID, @Point*.05, GETDATE(),GetDate()+7)

IF( @@ERROR <> 0 ) --Error
	BEGIN	
		GOTO ERR 
	END
END
ELSE
BEGIN
	GOTO ERR
END

COMMIT TRAN
SET NOCOUNT OFF
RETURN 1


ERR:
ROLLBACK TRAN
SET NOCOUNT OFF
RETURN -1
GO
/****** Object:  StoredProcedure [dbo].[GiftPoints]    Script Date: 02/07/2012 19:07:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Stored Procedure dbo.usp_Optisp_Charge_ShaiyaPoint    Script Date: 2008-6-7 18:34:05 ******/






/*==================================================
@author	lenasoft
@date	2006-12-27
@return	1-Success
	0-Fail
@brief	Shaiya Point Charge(China/Vet)
==================================================*/
CREATE Proc [dbo].[GiftPoints]
@UserID 	varchar(18),
@Point		int,
@FriendsID Varchar(100),
@IP VARCHAR (100)
AS

SET NOCOUNT ON

DECLARE
@Return int

BEGIN TRAN

UPDATE PS_UserData.dbo.Users_Master SET Point=ISNULL(Point,0)+@Point 
WHERE UserID=@FriendsID
Update PS_UserData.dbo.Users_Master SET Point = Point - @Point - (@Point * .05)
WHERE UserID=@UserID

IF( @@ROWCOUNT = 1)
BEGIN
	-- Log Insert
	INSERT INTO GM_Stuff.dbo.FriendGiftPoints( UserID, Point,Date,FriendsID,GifterIP ) VALUES (@UserID,@Point, GETDATE(),@FriendsID,@IP)
	IF( @@ERROR <> 0 ) --Error
	BEGIN	
		GOTO ERR 
	END
END
ELSE
BEGIN
	GOTO ERR
END

COMMIT TRAN
SET NOCOUNT OFF
RETURN 1


ERR:
ROLLBACK TRAN
SET NOCOUNT OFF
RETURN -1
GO
