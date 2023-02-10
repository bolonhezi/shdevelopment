USE [PS_GameLog]
GO

/****** Object:  Table [dbo].[Illegal_Transaction_Log]    Script Date: 07/02/2023 15:53:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Illegal_Transaction_Log](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[ActionTime] [datetime] NOT NULL,
	[UserID] [varchar](18) NOT NULL,
	[UserUID] [int] NOT NULL,
	[CharID] [int] NOT NULL,
	[CharName] [nvarchar](50) NOT NULL,
	[CharID_2] [int] NOT NULL,
	[CharName_2] [nvarchar](50) NOT NULL,
	[ItemUID] [bigint] NOT NULL,
	[ItemID] [int] NOT NULL,
	[ItemName] [varchar](30) NOT NULL,
	[ItemCount] [tinyint] NOT NULL,
 CONSTRAINT [PK_Illegal_Transaction_Log] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

