USE [PS_GameLog]
GO

/****** Object:  Table [dbo].[Command_Log]    Script Date: 07/02/2023 15:53:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Command_Log](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [varchar](18) NULL,
	[UserUID] [int] NULL,
	[CharID] [int] NULL,
	[CharName] [nvarchar](50) NULL,
	[MapID] [tinyint] NULL,
	[PosX] [real] NULL,
	[PosY] [real] NULL,
	[PosZ] [real] NULL,
	[ActionTime] [datetime] NULL,
	[Text1] [varchar](100) NULL,
	[Text2] [varchar](100) NULL,
	[Text3] [varchar](100) NULL,
 CONSTRAINT [PK_Command_Log] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

