USE [PS_GameLog]
GO

/****** Object:  Table [dbo].[Boss_Death_Log]    Script Date: 07/02/2023 15:52:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Boss_Death_Log](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[MobID] [int] NOT NULL,
	[MobName] [varchar](30) NOT NULL,
	[UserUID] [int] NOT NULL,
	[CharName] [nvarchar](50) NOT NULL,
	[MapID] [tinyint] NOT NULL,
	[PosX] [real] NOT NULL,
	[PosY] [real] NOT NULL,
	[PosZ] [real] NOT NULL,
	[ActionTime] [datetime] NOT NULL,
 CONSTRAINT [PK_Boss_Death_Log] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

