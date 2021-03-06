USE [master]
GO
/****** Object:  Database [BlogDB]    Script Date: 6/5/2015 8:32:55 PM ******/
CREATE DATABASE [BlogDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BlogDB', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\BlogDB.mdf' , SIZE = 3136KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'BlogDB_log', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\BlogDB_log.ldf' , SIZE = 832KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
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
/****** Object:  Table [dbo].[tbl_comment]    Script Date: 6/5/2015 8:32:55 PM ******/
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
/****** Object:  Table [dbo].[tbl_posts]    Script Date: 6/5/2015 8:32:55 PM ******/
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
/****** Object:  Table [dbo].[tbl_user]    Script Date: 6/5/2015 8:32:55 PM ******/
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
/****** Object:  View [dbo].[AllInfoView]    Script Date: 6/5/2015 8:32:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[AllInfoView] AS
SELECT tbl_posts.PostId, tbl_posts.UserId,tbl_posts.Title,tbl_posts.Description AS postDescription, tbl_posts.CreatedDate,tbl_posts.ViewCount, tbl_posts.IsPublished, tbl_user.FullName, tbl_comment.CommentId,tbl_comment.Description, tbl_comment.CommentDate FROM tbl_posts LEFT OUTER JOIN tbl_user ON tbl_posts.UserId = tbl_user.UserId LEFT OUTER JOIN tbl_comment ON tbl_comment.UserId = tbl_user.UserId

GO
/****** Object:  View [dbo].[homePageView]    Script Date: 6/5/2015 8:32:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[homePageView] AS


SELECT tbl_posts.PostId, tbl_posts.UserId, tbl_posts.Title, tbl_posts.Description,tbl_posts.CreatedDate, tbl_posts.ModifiedDate,tbl_posts.ViewCount, tbl_posts.IsPublished, tbl_user.FullName FROM tbl_posts JOIN tbl_user ON tbl_posts.UserId = tbl_user.UserId

GO
SET IDENTITY_INSERT [dbo].[tbl_comment] ON 

INSERT [dbo].[tbl_comment] ([CommentId], [UserId], [PostId], [Description], [CommentDate], [ModifiedDate]) VALUES (1, 1, 1, N'fiuafbuisabfpsaufsaufdnsadsaofn', CAST(0x083A0B00 AS Date), CAST(0x083A0B00 AS Date))
INSERT [dbo].[tbl_comment] ([CommentId], [UserId], [PostId], [Description], [CommentDate], [ModifiedDate]) VALUES (2, 1, 1, N'fewgfagagfsghf', CAST(0x083A0B00 AS Date), CAST(0x073A0B00 AS Date))
INSERT [dbo].[tbl_comment] ([CommentId], [UserId], [PostId], [Description], [CommentDate], [ModifiedDate]) VALUES (3, 1, 2, N'sdfsafas asdfasdfsa asdfasdf asewrwer erwerwer  e', CAST(0xB0390B00 AS Date), CAST(0x0A3A0B00 AS Date))
SET IDENTITY_INSERT [dbo].[tbl_comment] OFF
SET IDENTITY_INSERT [dbo].[tbl_posts] ON 

INSERT [dbo].[tbl_posts] ([PostId], [UserId], [Title], [Description], [Image], [CreatedDate], [ModifiedDate], [ViewCount], [IsPublished]) VALUES (1, 1, N'New test Post', N'Thanks for your interest. You can look at my new series here Part 1 - Complete Web Application step by step using ASP.NET MVC 5, EF, Ninject, LINQ etc. . Write your voice or request in my site http://www.rdatta.com/You/YourVoice . Keep in touch with my site http://www.rdatta.com , http://www.f6build.com , http://www.di-ioc.com , http://www.codeffi.com and stay well.', NULL, NULL, NULL, 0, 1)
INSERT [dbo].[tbl_posts] ([PostId], [UserId], [Title], [Description], [Image], [CreatedDate], [ModifiedDate], [ViewCount], [IsPublished]) VALUES (2, 2, N'rrewtwerwt', N'<p>saj ibsajibsajibsaj ibsajibsajibs ajibsajibsajibsa jibsajibsajibs ajibsajibsajibs ajibsajibsaji bsajibsajib sajibsaj ibsajibsaji bsajibs ajibsajibsajib sajibsajibs ajibsajibsaji bsajibsajibs ajibsajibs ajibsajibsa jibsajibsaji bsajibsajibsaj ibsajibsa jibsajibs ajibsajibsajib sajibsajibsaji bsajibsajibs ajibsajibsajibsajibsajib  sadjibsajibsajibsajib', N'', CAST(0x083A0B00 AS Date), CAST(0x083A0B00 AS Date), 0, 1)
INSERT [dbo].[tbl_posts] ([PostId], [UserId], [Title], [Description], [Image], [CreatedDate], [ModifiedDate], [ViewCount], [IsPublished]) VALUES (3, 2, N'asdfasd', N'saj ibsajibsajibsaj ibsajibsajibs ajibsajibsajibsa jibsajibsajibs ajibsajibsajibs ajibsajibsaji bsajibsajib sajibsaj ibsajibsaji bsajibs ajibsajibsajib sajibsajibs ajibsajibsaji bsajibsajibs ajibsajibs ajibsajibsa jibsajibsaji bsajibsajibsaj ibsajibsa jibsajibs ajibsajibsajib sajibsajibsaji bsajibsajibs ajibsajibsajibsajibsajib sadjibsajibsajibsajib ', N'', CAST(0x083A0B00 AS Date), CAST(0x083A0B00 AS Date), 0, 1)
INSERT [dbo].[tbl_posts] ([PostId], [UserId], [Title], [Description], [Image], [CreatedDate], [ModifiedDate], [ViewCount], [IsPublished]) VALUES (4, 2, N'asdfasd', N'saj ibsajibsajibsaj ibsajibsajibs ajibsajibsajibsa jibsajibsajibs ajibsajibsajibs ajibsajibsaji bsajibsajib sajibsaj ibsajibsaji bsajibs ajibsajibsajib sajibsajibs ajibsajibsaji bsajibsajibs ajibsajibs ajibsajibsa jibsajibsaji bsajibsajibsaj ibsajibsa jibsajibs ajibsajibsajib sajibsajibsaji bsajibsajibs ajibsajibsajibsajibsajib sadjibsajibsajibsajib ', N'', CAST(0x083A0B00 AS Date), CAST(0x083A0B00 AS Date), 0, 1)
INSERT [dbo].[tbl_posts] ([PostId], [UserId], [Title], [Description], [Image], [CreatedDate], [ModifiedDate], [ViewCount], [IsPublished]) VALUES (5, 2, N'asdfasd', N'saj ibsajibsajibsaj ibsajibsajibs ajibsajibsajibsa jibsajibsajibs ajibsajibsajibs ajibsajibsaji bsajibsajib sajibsaj ibsajibsaji bsajibs ajibsajibsajib sajibsajibs ajibsajibsaji bsajibsajibs ajibsajibs ajibsajibsa jibsajibsaji bsajibsajibsaj ibsajibsa jibsajibs ajibsajibsajib sajibsajibsaji bsajibsajibs ajibsajibsajibsajibsajib sadjibsajibsajibsajib ', N'', CAST(0x083A0B00 AS Date), CAST(0x083A0B00 AS Date), 0, 0)
INSERT [dbo].[tbl_posts] ([PostId], [UserId], [Title], [Description], [Image], [CreatedDate], [ModifiedDate], [ViewCount], [IsPublished]) VALUES (6, 2, N'Dhaka Bangladesh', N'<p>dfsadfsafasdfsadfsadfsadf sadfsadfsadfsad&nbsp; sdafasdfas asdfsadfasdf asdfasdfsadf sadfsadfsad&nbsp;</p>', N'', CAST(0x093A0B00 AS Date), CAST(0x093A0B00 AS Date), 0, 1)
INSERT [dbo].[tbl_posts] ([PostId], [UserId], [Title], [Description], [Image], [CreatedDate], [ModifiedDate], [ViewCount], [IsPublished]) VALUES (7, 2, N'Image', N'<p>Image test dfasdfsadfsa sdfsadfsadfsdfsdfsdf</p><p><img class="fr-fin fr-dib" alt="Image title" src="http://i.froala.com/download/010fb5b16261fe8df5fe8d343e5e642c8efb9c98.png?1433511893" width="300"></p><p><br></p>', N'', CAST(0x093A0B00 AS Date), CAST(0x093A0B00 AS Date), 0, 1)
INSERT [dbo].[tbl_posts] ([PostId], [UserId], [Title], [Description], [Image], [CreatedDate], [ModifiedDate], [ViewCount], [IsPublished]) VALUES (9, 2, N'dfsdfsd', N'<p>dsfsadfsadfsdfs dfsd&nbsp; fsdfsdf sadf sdfsdf sdfsdf&nbsp;</p>', N'', CAST(0x093A0B00 AS Date), CAST(0x093A0B00 AS Date), 0, 1)
INSERT [dbo].[tbl_posts] ([PostId], [UserId], [Title], [Description], [Image], [CreatedDate], [ModifiedDate], [ViewCount], [IsPublished]) VALUES (10, 1, N'New Postq', N'<p>Editor ZoneClose&nbsp;&nbsp; Label&nbsp;Editor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; Label<img class="fr-fin fr-dib" alt="Image title" src="http://i.froala.com/download/edf2496efe82affd38b83e4ae85edcdcb4ebb7e4.png?1433513721" width="300"></p>', N'', CAST(0x093A0B00 AS Date), CAST(0x093A0B00 AS Date), 0, 1)
INSERT [dbo].[tbl_posts] ([PostId], [UserId], [Title], [Description], [Image], [CreatedDate], [ModifiedDate], [ViewCount], [IsPublished]) VALUES (11, 2, N'NEW Sajib', N'<p><span style="color: rgb(65, 168, 95); font-size: 15px;">Hello Sajib&nbsp;Hello SajibHello SajibHello SajibHello SajibHello SajibHello SajibHello SajibHello SajibHello SajibHello SajibHello SajibHello SajibHello SajibHello SajibHello SajibHello SajibHello SajibHello SajibHello SajibHello SajibHello SajibHello SajibHello SajibHello SajibHello SajibHello SajibHello SajibHello SajibHello SajibHello SajibHello SajibHello SajibHello SajibHello Sajib</span></p>', N'', CAST(0x093A0B00 AS Date), CAST(0x093A0B00 AS Date), 0, 1)
SET IDENTITY_INSERT [dbo].[tbl_posts] OFF
SET IDENTITY_INSERT [dbo].[tbl_user] ON 

INSERT [dbo].[tbl_user] ([UserId], [Email], [FullName], [Password], [UserName]) VALUES (1, N'studentmanik@gmail.com', N'Md Manik', N'manik123', N'studentmanik')
INSERT [dbo].[tbl_user] ([UserId], [Email], [FullName], [Password], [UserName]) VALUES (2, N'sajib@gmail.com', N'Md sajib', N'sajib', N'sajib')
INSERT [dbo].[tbl_user] ([UserId], [Email], [FullName], [Password], [UserName]) VALUES (3, N'mizan@gmail.com', N'Md Mizanur Rahman', N'mizan', N'mizan')
SET IDENTITY_INSERT [dbo].[tbl_user] OFF
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_tbl_user]    Script Date: 6/5/2015 8:32:55 PM ******/
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
