USE [PS_GameLog]
GO

/****** Object:  Table [dbo].[Transaction_Log]    Script Date: 10/02/2023 14:35:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Transaction_Log](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[ActionTime] [datetime] NOT NULL,
	[UserID] [varchar](18) NOT NULL,
	[UserUID] [int] NOT NULL,
	[CharID] [int] NOT NULL,
	[CharName] [nvarchar](50) NOT NULL,
	[CharID_2] [int] NOT NULL,
	[CharName_2] [nvarchar](50) NOT NULL,
	[ItemUID] [bigint] NULL,
	[ItemID] [int] NULL,
	[ItemName] [varchar](30) NULL,
	[ItemCount] [tinyint] NULL,
	[Gold] [int] NULL,
 CONSTRAINT [PK_TransactionLog] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

