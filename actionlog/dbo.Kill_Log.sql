USE [PS_GameLog]
GO

/****** Object:  Table [dbo].[Kill_Log]    Script Date: 10/02/2023 14:35:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Kill_Log](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [varchar](20) NOT NULL,
	[UserUID] [int] NOT NULL,
	[CharID] [int] NOT NULL,
	[CharName] [nvarchar](50) NOT NULL,
	[DeadCharID] [int] NOT NULL,
	[DeadCharName] [nvarchar](50) NOT NULL,
	[MapID] [tinyint] NOT NULL,
	[PosX] [real] NOT NULL,
	[PosY] [real] NOT NULL,
	[PosZ] [real] NOT NULL,
	[ActionTime] [datetime] NOT NULL,
 CONSTRAINT [PK_Kill_Log] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

