USE [PS_GameLog]
GO

/****** Object:  Table [dbo].[Char_Enter_Leave_Log]    Script Date: 10/02/2023 14:34:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Char_Enter_Leave_Log](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [varchar](30) NOT NULL,
	[UserUID] [int] NOT NULL,
	[CharID] [int] NOT NULL,
	[CharName] [nvarchar](50) NOT NULL,
	[ActionType] [varchar](10) NOT NULL,
	[ActionTime] [datetime] NOT NULL,
	[UserIP] [varchar](50) NULL,
 CONSTRAINT [PK_Char_Enter_Leave_Log] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

