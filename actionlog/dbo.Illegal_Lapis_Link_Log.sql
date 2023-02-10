USE [PS_GameLog]
GO

/****** Object:  Table [dbo].[Illegal_Lapis_Link_Log]    Script Date: 10/02/2023 14:35:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Illegal_Lapis_Link_Log](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[UserUID] [int] NOT NULL,
	[UserID] [varchar](20) NOT NULL,
	[CharID] [int] NOT NULL,
	[CharName] [nvarchar](50) NOT NULL,
	[ItemUID] [bigint] NOT NULL,
	[ItemID] [int] NOT NULL,
	[ItemName] [varchar](50) NOT NULL,
	[ItemLevel] [smallint] NOT NULL,
	[LapisID] [int] NOT NULL,
	[LapisName] [varchar](50) NOT NULL,
	[LapisLevel] [smallint] NOT NULL,
	[LinkSuccess] [bit] NOT NULL,
	[ActionTime] [datetime] NOT NULL,
 CONSTRAINT [PK_Illegal_Lapis_Link_Log] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

