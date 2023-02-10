USE [PS_UserData]
GO

/****** Object:  Table [dbo].[UserPointChargeLog]    Script Date: 01/06/2023 13:36:00 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserPointChargeLog]') AND type in (N'U'))
DROP TABLE [dbo].[UserPointChargeLog]
GO

USE [PS_UserData]
GO

/****** Object:  Table [dbo].[UserPointChargeLog]    Script Date: 01/06/2023 13:36:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[UserPointChargeLog](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [varchar](18) NOT NULL,
	[Point] [int] NOT NULL,
	[Date] [date] NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


