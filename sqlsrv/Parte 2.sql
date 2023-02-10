USE [PS_UserData]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Users_Detail_EmailAuth]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Users_Detail] DROP CONSTRAINT [DF_Users_Detail_EmailAuth]
END

GO

USE [PS_UserData]
GO

/****** Object:  Table [dbo].[Users_Detail]    Script Date: 01/06/2023 13:32:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Users_Detail]') AND type in (N'U'))
DROP TABLE [dbo].[Users_Detail]
GO

USE [PS_UserData]
GO

/****** Object:  Table [dbo].[Users_Detail]    Script Date: 01/06/2023 13:32:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Users_Detail](
	[UserID] [varchar](18) NOT NULL,
	[UserUID] [int] NOT NULL,
	[UserName] [varchar](20) NULL,
	[SocialNo1] [char](6) NULL,
	[SocialNo2] [char](7) NULL,
	[PwQuestion] [varchar](100) NOT NULL,
	[PwAnswer] [varchar](20) NULL,
	[Email] [varchar](100) NOT NULL,
	[PostNo] [char](7) NULL,
	[Addr1] [varchar](100) NULL,
	[Addr2] [varchar](100) NULL,
	[Phone1] [varchar](3) NULL,
	[Phone2] [varchar](4) NULL,
	[Phone3] [varchar](4) NULL,
	[Mobile1] [varchar](3) NULL,
	[Mobile2] [varchar](4) NULL,
	[Mobile3] [varchar](4) NULL,
	[NewsLetter] [bit] NOT NULL,
	[Sms] [bit] NOT NULL,
	[AdultAuth] [bit] NOT NULL,
	[AdultAuthDate] [datetime] NULL,
	[EmailAuth] [char](1) NOT NULL,
	[EmailAuthKey] [varchar](10) NULL,
	[Job] [varchar](50) NULL,
	[JobNo] [tinyint] NULL,
	[LocalNo] [tinyint] NULL,
	[PwQuNo] [tinyint] NULL,
	[JoinDate] [date] NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[Users_Detail] ADD  CONSTRAINT [DF_Users_Detail_EmailAuth]  DEFAULT (1) FOR [EmailAuth]
GO


