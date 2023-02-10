USE [PS_GameLog]
GO

/****** Object:  Table [dbo].[ActionLog]    Script Date: 10/02/2023 14:33:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ActionLog](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [varchar](18) NULL,
	[UserUID] [int] NULL,
	[CharID] [int] NULL,
	[CharName] [varchar](50) NULL,
	[CharLevel] [tinyint] NULL,
	[CharExp] [int] NULL,
	[MapID] [smallint] NULL,
	[PosX] [real] NULL,
	[PosY] [real] NULL,
	[PosZ] [real] NULL,
	[ActionTime] [datetime] NULL,
	[ActionType] [tinyint] NULL,
	[Value1] [bigint] NULL,
	[Value2] [int] NULL,
	[Value3] [int] NULL,
	[Value4] [bigint] NULL,
	[Value5] [int] NULL,
	[Value6] [int] NULL,
	[Value7] [int] NULL,
	[Value8] [int] NULL,
	[Value9] [int] NULL,
	[Value10] [int] NULL,
	[Text1] [varchar](100) NULL,
	[Text2] [varchar](100) NULL,
	[Text3] [varchar](100) NULL,
	[Text4] [varchar](100) NULL,
 CONSTRAINT [PK_ActionLog] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

