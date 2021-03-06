USE [master]
GO
/****** Object:  Database [BlogDB]    Script Date: 6/4/2015 3:17:09 PM ******/
CREATE DATABASE [BlogDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BlogDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\BlogDB.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'BlogDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\BlogDB_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [BlogDB] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BlogDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BlogDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BlogDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BlogDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BlogDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BlogDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [BlogDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [BlogDB] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [BlogDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BlogDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BlogDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BlogDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BlogDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BlogDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BlogDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BlogDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BlogDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [BlogDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BlogDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BlogDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BlogDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BlogDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BlogDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BlogDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BlogDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [BlogDB] SET  MULTI_USER 
GO
ALTER DATABASE [BlogDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BlogDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BlogDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BlogDB] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [BlogDB]
GO
/****** Object:  Table [dbo].[tbl_comment]    Script Date: 6/4/2015 3:17:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_comment](
	[CommentId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[PostId] [int] NOT NULL,
	[Description] [varchar](250) NULL,
	[CommentDate] [date] NULL,
	[ModifiedDate] [date] NULL,
 CONSTRAINT [PK_tbl_comment] PRIMARY KEY CLUSTERED 
(
	[CommentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_posts]    Script Date: 6/4/2015 3:17:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_posts](
	[PostId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[Title] [varchar](150) NULL,
	[Description] [varchar](800) NULL,
	[Image] [varchar](50) NULL,
	[CreatedDate] [date] NULL,
	[ModifiedDate] [date] NULL,
	[ViewCount] [int] NULL,
	[IsPublished] [bit] NULL,
 CONSTRAINT [PK_tbl_posts] PRIMARY KEY CLUSTERED 
(
	[PostId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_user]    Script Date: 6/4/2015 3:17:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_user](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[Email] [varchar](50) NULL,
	[FullName] [varchar](50) NULL,
	[Password] [varchar](50) NULL,
	[UserName] [varchar](50) NULL,
 CONSTRAINT [PK_tbl_user] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_posts] ON 

INSERT [dbo].[tbl_posts] ([PostId], [UserId], [Title], [Description], [Image], [CreatedDate], [ModifiedDate], [ViewCount], [IsPublished]) VALUES (1, 1, N'New test Post', N'Thanks for your interest. You can look at my new series here Part 1 - Complete Web Application step by step using ASP.NET MVC 5, EF, Ninject, LINQ etc. . Write your voice or request in my site http://www.rdatta.com/You/YourVoice . Keep in touch with my site http://www.rdatta.com , http://www.f6build.com , http://www.di-ioc.com , http://www.codeffi.com and stay well.', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[tbl_posts] ([PostId], [UserId], [Title], [Description], [Image], [CreatedDate], [ModifiedDate], [ViewCount], [IsPublished]) VALUES (2, 2, N'rrewtwerwt', N'<p>sajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajib</p>', N'', CAST(0x083A0B00 AS Date), CAST(0x083A0B00 AS Date), 0, 1)
INSERT [dbo].[tbl_posts] ([PostId], [UserId], [Title], [Description], [Image], [CreatedDate], [ModifiedDate], [ViewCount], [IsPublished]) VALUES (3, 2, N'asdfasd', N'<p>sajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajib</p>', N'', CAST(0x083A0B00 AS Date), CAST(0x083A0B00 AS Date), 0, 1)
INSERT [dbo].[tbl_posts] ([PostId], [UserId], [Title], [Description], [Image], [CreatedDate], [ModifiedDate], [ViewCount], [IsPublished]) VALUES (4, 2, N'asdfasd', N'<p>sajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajib</p>', N'', CAST(0x083A0B00 AS Date), CAST(0x083A0B00 AS Date), 0, 1)
INSERT [dbo].[tbl_posts] ([PostId], [UserId], [Title], [Description], [Image], [CreatedDate], [ModifiedDate], [ViewCount], [IsPublished]) VALUES (5, 2, N'asdfasd', N'<p>sajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsaj<span style="color: rgb(184, 49, 47);">ibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajibsajib</span></p><p><span style="color: rgb(184, 49, 47);"><br></span></p><p>bcbxcbx<span style="color: rgb(184, 49, 47);"><br></span></p><p><span style="color: rgb(184, 49, 47);"><br></span></p>', N'', CAST(0x083A0B00 AS Date), CAST(0x083A0B00 AS Date), 0, 0)
SET IDENTITY_INSERT [dbo].[tbl_posts] OFF
SET IDENTITY_INSERT [dbo].[tbl_user] ON 

INSERT [dbo].[tbl_user] ([UserId], [Email], [FullName], [Password], [UserName]) VALUES (1, N'studentmanik@gmail.com', N'Md Manik', N'manik123', N'studentmanik')
INSERT [dbo].[tbl_user] ([UserId], [Email], [FullName], [Password], [UserName]) VALUES (2, N'sajib@gmail.com', N'Md sajib', N'sajib', N'sajib')
SET IDENTITY_INSERT [dbo].[tbl_user] OFF
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_tbl_user]    Script Date: 6/4/2015 3:17:10 PM ******/
ALTER TABLE [dbo].[tbl_user] ADD  CONSTRAINT [IX_tbl_user] UNIQUE NONCLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_comment]  WITH CHECK ADD  CONSTRAINT [FK_tbl_comment_tbl_posts] FOREIGN KEY([CommentId])
REFERENCES [dbo].[tbl_posts] ([PostId])
GO
ALTER TABLE [dbo].[tbl_comment] CHECK CONSTRAINT [FK_tbl_comment_tbl_posts]
GO
ALTER TABLE [dbo].[tbl_comment]  WITH CHECK ADD  CONSTRAINT [FK_tbl_comment_tbl_user] FOREIGN KEY([CommentId])
REFERENCES [dbo].[tbl_user] ([UserId])
GO
ALTER TABLE [dbo].[tbl_comment] CHECK CONSTRAINT [FK_tbl_comment_tbl_user]
GO
ALTER TABLE [dbo].[tbl_posts]  WITH CHECK ADD  CONSTRAINT [FK_tbl_posts_tbl_posts] FOREIGN KEY([UserId])
REFERENCES [dbo].[tbl_user] ([UserId])
GO
ALTER TABLE [dbo].[tbl_posts] CHECK CONSTRAINT [FK_tbl_posts_tbl_posts]
GO
USE [master]
GO
ALTER DATABASE [BlogDB] SET  READ_WRITE 
GO
