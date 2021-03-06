USE [master]
GO
/****** Object:  Database [BlogDB]    Script Date: 6/8/2015 5:47:25 AM ******/
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
/****** Object:  StoredProcedure [dbo].[SearchAllTables]    Script Date: 6/8/2015 5:47:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SearchAllTables]
(
    @SearchStr nvarchar(100)
)
AS
BEGIN

-- Copyright © 2002 Narayana Vyas Kondreddi. All rights reserved.
-- Purpose: To search all columns of all tables for a given search string
-- Written by: Narayana Vyas Kondreddi
-- Site: http://vyaskn.tripod.com
-- Tested on: SQL Server 7.0 and SQL Server 2000
-- Date modified: 28th July 2002 22:50 GMT

DECLARE @Results TABLE(ColumnName nvarchar(370), ColumnValue nvarchar(3630))

SET NOCOUNT ON

DECLARE @TableName nvarchar(256), @ColumnName nvarchar(128), @SearchStr2 nvarchar(110)
SET  @TableName = ''
SET @SearchStr2 = QUOTENAME('%' + @SearchStr + '%','''')

WHILE @TableName IS NOT NULL
BEGIN
    SET @ColumnName = ''
    SET @TableName = 
    (
        SELECT MIN(QUOTENAME(TABLE_SCHEMA) + '.' + QUOTENAME(TABLE_NAME))
        FROM    INFORMATION_SCHEMA.TABLES
        WHERE       TABLE_TYPE = 'BASE TABLE'
            AND QUOTENAME(TABLE_SCHEMA) + '.' + QUOTENAME(TABLE_NAME) > @TableName
            AND OBJECTPROPERTY(
                    OBJECT_ID(
                        QUOTENAME(TABLE_SCHEMA) + '.' + QUOTENAME(TABLE_NAME)
                         ), 'IsMSShipped'
                           ) = 0
    )

    WHILE (@TableName IS NOT NULL) AND (@ColumnName IS NOT NULL)
    BEGIN
        SET @ColumnName =
        (
            SELECT MIN(QUOTENAME(COLUMN_NAME))
            FROM    INFORMATION_SCHEMA.COLUMNS
            WHERE       TABLE_SCHEMA    = PARSENAME(@TableName, 2)
                AND TABLE_NAME  = PARSENAME(@TableName, 1)
                AND DATA_TYPE IN ('char', 'varchar', 'nchar', 'nvarchar')
                AND QUOTENAME(COLUMN_NAME) > @ColumnName
        )

        IF @ColumnName IS NOT NULL
        BEGIN
            INSERT INTO @Results
            EXEC
            (
                'SELECT ''' + @TableName + '.' + @ColumnName + ''', LEFT(' + @ColumnName + ', 3630) 
                FROM ' + @TableName + ' (NOLOCK) ' +
                ' WHERE ' + @ColumnName + ' LIKE ' + @SearchStr2
            )
        END
    END 
END

SELECT ColumnName, ColumnValue FROM @Results
END
GO
/****** Object:  Table [dbo].[tbl_comment]    Script Date: 6/8/2015 5:47:25 AM ******/
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
	[CommentDate] [datetime] NULL,
 CONSTRAINT [PK_tbl_comment] PRIMARY KEY CLUSTERED 
(
	[CommentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_posts]    Script Date: 6/8/2015 5:47:25 AM ******/
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
	[Description] [varchar](max) NULL,
	[Image] [varchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
	[ViewCount] [int] NULL,
	[IsPublished] [bit] NULL,
 CONSTRAINT [PK_tbl_posts] PRIMARY KEY CLUSTERED 
(
	[PostId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_user]    Script Date: 6/8/2015 5:47:25 AM ******/
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
/****** Object:  View [dbo].[CommentView]    Script Date: 6/8/2015 5:47:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[CommentView]
AS
SELECT        tbl_comment.PostId, tbl_comment.UserId,tbl_comment.Description,tbl_comment.CommentDate, tbl_comment.CommentId, tbl_user.FullName
FROM            tbl_comment INNER JOIN
                         dbo.tbl_user ON tbl_comment.UserId = tbl_user.UserId 
GO
/****** Object:  View [dbo].[homePageView]    Script Date: 6/8/2015 5:47:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[homePageView]
AS
SELECT        dbo.tbl_posts.PostId, dbo.tbl_posts.UserId, dbo.tbl_posts.Title, dbo.tbl_posts.Description, dbo.tbl_posts.CreatedDate, dbo.tbl_posts.ModifiedDate, dbo.tbl_posts.ViewCount, dbo.tbl_posts.IsPublished, 
                         dbo.tbl_user.FullName
FROM            dbo.tbl_posts INNER JOIN
                         dbo.tbl_user ON dbo.tbl_posts.UserId = dbo.tbl_user.UserId

GO
SET IDENTITY_INSERT [dbo].[tbl_comment] ON 

INSERT [dbo].[tbl_comment] ([CommentId], [UserId], [PostId], [Description], [CommentDate]) VALUES (1, 2, 3013, N'new comemnt', CAST(0x0000A4B100000000 AS DateTime))
INSERT [dbo].[tbl_comment] ([CommentId], [UserId], [PostId], [Description], [CommentDate]) VALUES (18, 2, 3013, N'2nd', CAST(0x0000A4B100000000 AS DateTime))
INSERT [dbo].[tbl_comment] ([CommentId], [UserId], [PostId], [Description], [CommentDate]) VALUES (19, 2, 3014, N'3rd', CAST(0x0000A4B100000000 AS DateTime))
INSERT [dbo].[tbl_comment] ([CommentId], [UserId], [PostId], [Description], [CommentDate]) VALUES (20, 2, 3014, N'4th', CAST(0x0000A4B1000B4528 AS DateTime))
INSERT [dbo].[tbl_comment] ([CommentId], [UserId], [PostId], [Description], [CommentDate]) VALUES (21, 1, 3012, N'manik', CAST(0x0000A4B100222F90 AS DateTime))
INSERT [dbo].[tbl_comment] ([CommentId], [UserId], [PostId], [Description], [CommentDate]) VALUES (22, 1, 2014, N'neaw by manik', CAST(0x0000A4B100392F10 AS DateTime))
INSERT [dbo].[tbl_comment] ([CommentId], [UserId], [PostId], [Description], [CommentDate]) VALUES (23, 1, 2014, N'neaw by manik', CAST(0x0000A4B10039399C AS DateTime))
INSERT [dbo].[tbl_comment] ([CommentId], [UserId], [PostId], [Description], [CommentDate]) VALUES (24, 1, 2014, N'neaw by manik', CAST(0x0000A4B100393BF4 AS DateTime))
INSERT [dbo].[tbl_comment] ([CommentId], [UserId], [PostId], [Description], [CommentDate]) VALUES (25, 1, 3014, N'mnb', CAST(0x0000A4B1003DC1C4 AS DateTime))
INSERT [dbo].[tbl_comment] ([CommentId], [UserId], [PostId], [Description], [CommentDate]) VALUES (26, 1, 3014, N'manikk', CAST(0x0000A4B1003DCD7C AS DateTime))
INSERT [dbo].[tbl_comment] ([CommentId], [UserId], [PostId], [Description], [CommentDate]) VALUES (27, 1, 3014, N'sdfsdfsdfsadf', CAST(0x0000A4B100430C74 AS DateTime))
INSERT [dbo].[tbl_comment] ([CommentId], [UserId], [PostId], [Description], [CommentDate]) VALUES (28, 1, 3014, N'sdfsdfs', CAST(0x0000A4B1004314A8 AS DateTime))
INSERT [dbo].[tbl_comment] ([CommentId], [UserId], [PostId], [Description], [CommentDate]) VALUES (29, 1, 3014, N'sdfs', CAST(0x0000A4B1004390E0 AS DateTime))
INSERT [dbo].[tbl_comment] ([CommentId], [UserId], [PostId], [Description], [CommentDate]) VALUES (30, 1, 3014, N'sd', CAST(0x0000A4B100439590 AS DateTime))
INSERT [dbo].[tbl_comment] ([CommentId], [UserId], [PostId], [Description], [CommentDate]) VALUES (31, 1, 3014, N'mn', CAST(0x0000A4B100492EC4 AS DateTime))
INSERT [dbo].[tbl_comment] ([CommentId], [UserId], [PostId], [Description], [CommentDate]) VALUES (32, 1, 3014, N'mn', CAST(0x0000A4B1004935CC AS DateTime))
INSERT [dbo].[tbl_comment] ([CommentId], [UserId], [PostId], [Description], [CommentDate]) VALUES (33, 1, 3014, N'mn', CAST(0x0000A4B1004949B8 AS DateTime))
INSERT [dbo].[tbl_comment] ([CommentId], [UserId], [PostId], [Description], [CommentDate]) VALUES (34, 1, 3014, N'mndfasd', CAST(0x0000A4B10049B588 AS DateTime))
INSERT [dbo].[tbl_comment] ([CommentId], [UserId], [PostId], [Description], [CommentDate]) VALUES (35, 1, 2013, N'mgdg', CAST(0x0000A4B1004B4524 AS DateTime))
INSERT [dbo].[tbl_comment] ([CommentId], [UserId], [PostId], [Description], [CommentDate]) VALUES (36, 1, 2013, N'mgdg', CAST(0x0000A4B1004B4650 AS DateTime))
INSERT [dbo].[tbl_comment] ([CommentId], [UserId], [PostId], [Description], [CommentDate]) VALUES (37, 1, 3013, N'asd', CAST(0x0000A4B1004BD8CC AS DateTime))
INSERT [dbo].[tbl_comment] ([CommentId], [UserId], [PostId], [Description], [CommentDate]) VALUES (38, 1, 3013, N'sdf', CAST(0x0000A4B1004C1490 AS DateTime))
INSERT [dbo].[tbl_comment] ([CommentId], [UserId], [PostId], [Description], [CommentDate]) VALUES (39, 1, 3013, N'mbb', CAST(0x0000A4B1004C2D2C AS DateTime))
INSERT [dbo].[tbl_comment] ([CommentId], [UserId], [PostId], [Description], [CommentDate]) VALUES (40, 1, 3013, N'nb', CAST(0x0000A4B1004D1084 AS DateTime))
INSERT [dbo].[tbl_comment] ([CommentId], [UserId], [PostId], [Description], [CommentDate]) VALUES (41, 1, 3013, N'nbmnb', CAST(0x0000A4B1004D1FC0 AS DateTime))
INSERT [dbo].[tbl_comment] ([CommentId], [UserId], [PostId], [Description], [CommentDate]) VALUES (42, 1, 2014, N'mnn', CAST(0x0000A4B1004DC3D0 AS DateTime))
INSERT [dbo].[tbl_comment] ([CommentId], [UserId], [PostId], [Description], [CommentDate]) VALUES (43, 1, 3014, N'mnbhgfdsaKJHGFKJHG', CAST(0x0000A4B1004E852C AS DateTime))
SET IDENTITY_INSERT [dbo].[tbl_comment] OFF
SET IDENTITY_INSERT [dbo].[tbl_posts] ON 

INSERT [dbo].[tbl_posts] ([PostId], [UserId], [Title], [Description], [Image], [CreatedDate], [ModifiedDate], [ViewCount], [IsPublished]) VALUES (1, 1, N'New test Post', N'Thanks for your interest. You can look at my new series here Part 1 - Complete Web Application step by step using ASP.NET MVC 5, EF, Ninject, LINQ etc. . Write your voice or request in my site http://www.rdatta.com/You/YourVoice . Keep in touch with my site http://www.rdatta.com , http://www.f6build.com , http://www.di-ioc.com , http://www.codeffi.com and stay well.', NULL, NULL, NULL, 9, 1)
INSERT [dbo].[tbl_posts] ([PostId], [UserId], [Title], [Description], [Image], [CreatedDate], [ModifiedDate], [ViewCount], [IsPublished]) VALUES (1004, 2, N'asdfasd', N'asdfasd2', N'', CAST(0x0000A4AE00000000 AS DateTime), CAST(0x0000A4AE00000000 AS DateTime), 5, 1)
INSERT [dbo].[tbl_posts] ([PostId], [UserId], [Title], [Description], [Image], [CreatedDate], [ModifiedDate], [ViewCount], [IsPublished]) VALUES (1005, 2, N'asdfasd', N'asdfasd 5', N'', CAST(0x0000A4AE00000000 AS DateTime), CAST(0x0000A4AE00000000 AS DateTime), 2, 1)
INSERT [dbo].[tbl_posts] ([PostId], [UserId], [Title], [Description], [Image], [CreatedDate], [ModifiedDate], [ViewCount], [IsPublished]) VALUES (1006, 2, N'asdfasd', N'<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec facilisis diam in odio iaculis blandit. Nunc eu mauris sit amet purus viverra gravida ut a dui. Vivamus nec rutrum augue, pharetra faucibus purus. Maecenas non orci sagittis, vehicula lorem et, dignissim nunc. Suspendisse suscipit, diam non varius facilisis, enim libero tincidunt magna, sit amet iaculis eros libero sit amet eros. Vestibulum a rhoncus felis. Nam lacus nulla, consequat ac lacus sit amet, accumsan pellentesque risus. Aenean viverra mi at urna mattis fermentum. Curabitur porta metus in tortor elementum, in semper nulla ullamcorper. Vestibulum mattis tempor tortor quis gravida. In rhoncus risus nibh. Nullam condimentum dapibus massa vel fringilla. Sed hendrerit sed est quis facilisis. Ut sit amet nibh sem. Pellentesque imperdiet mollis libero.</p>', N'', CAST(0x0000A4AE00000000 AS DateTime), CAST(0x0000A4AE00000000 AS DateTime), 2, 1)
INSERT [dbo].[tbl_posts] ([PostId], [UserId], [Title], [Description], [Image], [CreatedDate], [ModifiedDate], [ViewCount], [IsPublished]) VALUES (1008, 1, N' Pellentesque imperdiet mollis libero.', N'<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec facilisis diam in odio iaculis blandit. Nunc eu mauris sit amet purus viverra gravida ut a dui. Vivamus nec rutrum augue, pharetra faucibus purus. Maecenas non orci sagittis, vehicula lorem et, dignissim nunc. Suspendisse suscipit, diam non varius facilisis, enim libero tincidunt magna, sit amet iaculis eros libero sit amet eros. Vestibulum a rhoncus felis. Nam lacus nulla, consequat ac lacus sit amet, accumsan pellentesque risus. Aenean viverra mi at urna mattis fermentum. Curabitur porta metus in tortor elementum, in semper nulla ullamcorper. Vestibulum mattis tempor tortor quis gravida. In rhoncus risus nibh. Nullam condimentum dapibus massa vel fringilla. Sed hendrerit sed est quis facilisis. Ut sit amet nibh sem. Pellentesque imperdiet mollis libero.</p>', N'', CAST(0x0000A4AE00000000 AS DateTime), CAST(0x0000A4AE00000000 AS DateTime), 2, 1)
INSERT [dbo].[tbl_posts] ([PostId], [UserId], [Title], [Description], [Image], [CreatedDate], [ModifiedDate], [ViewCount], [IsPublished]) VALUES (1009, 1, N'manik', N'<p>Editor ZoneClose&nbsp;&nbsp; Label&nbsp;Editor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; La<span style="color: rgb(184, 49, 47);">belEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; La</span>belEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; LabelEditor ZoneClose&nbsp;&nbsp; Label</p>', N'', CAST(0x0000A4AE00000000 AS DateTime), CAST(0x0000A4AE00000000 AS DateTime), 2, 1)
INSERT [dbo].[tbl_posts] ([PostId], [UserId], [Title], [Description], [Image], [CreatedDate], [ModifiedDate], [ViewCount], [IsPublished]) VALUES (2006, 1, N'Lorem ipsum dolor sit amet manik', N'<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui.Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,manik</p>', N'', CAST(0x0000A4B000000000 AS DateTime), CAST(0x0000A4B000000000 AS DateTime), 3, 1)
INSERT [dbo].[tbl_posts] ([PostId], [UserId], [Title], [Description], [Image], [CreatedDate], [ModifiedDate], [ViewCount], [IsPublished]) VALUES (2007, 2, N'This is a follow-up to this questio', N'p>This is a follow-up to this question:&nbsp;<a href="https://academia.stackexchange.com/questions/45929/should-i-recommend-rejection-for-a-paper-i-referee-if-the-authors-dont-make-cha">Should I recommend rejection for a paper I referee if the authors don&apos;t make changes that they could have made?</a></p><p>To recap: I was sent a paper to referee by a top journal. My first report pointed out that the authors had only considered one of two possible behavior patterns that their system might have. When the authors resubmitted, they basically ignored what I had said (although see below). So I sent it back, asking that the changes I had asked for before actually be made.</p><p>When I read the second draft very carefully, I saw they had actually added a very short paragraph that seemed to be arguing against the second type of behavior I was worried about being possible. It was so minor I didn&apos;t even notice it before I asked my earlier StackExchange question. However, the manuscript authors made an error in their attempt to demonstrate this point quantitatively; as I pointed out in my second report, their argument actually showed that I was correct.</p><p>Now, they have submitted the paper a third time. This time, they very enthusiastically acknowledge that I am right--both types of system behavior are expected to occur. However, they now claim that their numerical calculations actually include both possibilities, and that they actually did all along! The letter says that they just explained things really badly.</p><p>They have made more changes to the manuscript. It now states that both behaviors can occur and that both are fully included. I am not in a position to check whether their results are consistent with this. The paper does a lot of heavy numerical calculation, which would take a long time to replicate. Since the bottom line result is not going to depend much on the intermediate details, it is plausible that their graphs could have been showing the fully correct answers all along.</p><p>However, the format of the paper suggests otherwise. Add to that the fact that the second draft of the paper actually argued obliquely against the type of behavior that they now admit is natural. I feel like there are two likely possibilities. The first is that the authors are being dishonest. They missed the second possibility, and now that I have pointed out that it definitely occurs, they have reasoned that they can fib about the matter and it will be difficult to refute their claim. I am rather unhappy about this possibility; I hope it&apos;s not the case. The second possibility is that the communication between the two authors of the paper was extremely poor. The person who did the actual writing would have to have been quite ignorant of what his coauthor was actually calculating. This is a less troubling but still far from ideal situation.</p><p>So, once again, I find myself unsure what to do. Should I share my misgivings with the editor? Or should I take the current draft&apos;s claims as is--chalk the whole thing up to incompetence rather than dishonesty? I have, after all, no concrete evidence of fraud.</p>', N'', CAST(0x0000A4B000000000 AS DateTime), CAST(0x0000A4B000000000 AS DateTime), 3, 1)
INSERT [dbo].[tbl_posts] ([PostId], [UserId], [Title], [Description], [Image], [CreatedDate], [ModifiedDate], [ViewCount], [IsPublished]) VALUES (2008, 2, N'This is a follow-up to this questio', N'p>This is a follow-up to this question:&nbsp;<a href="https://academia.stackexchange.com/questions/45929/should-i-recommend-rejection-for-a-paper-i-referee-if-the-authors-dont-make-cha">Should I recommend rejection for a paper I referee if the authors don&apos;t make changes that they could have made?</a></p><p>To recap: I was sent a paper to referee by a top journal. My first report pointed out that the authors had only considered one of two possible behavior patterns that their system might have. When the authors resubmitted, they basically ignored what I had said (although see below). So I sent it back, asking that the changes I had asked for before actually be made.</p><p>When I read the second draft very carefully, I saw they had actually added a very short paragraph that seemed to be arguing against the second type of behavior I was worried about being possible. It was so minor I didn&apos;t even notice it before I asked my earlier StackExchange question. However, the manuscript authors made an error in their attempt to demonstrate this point quantitatively; as I pointed out in my second report, their argument actually showed that I was correct.</p><p>Now, they have submitted the paper a third time. This time, they very enthusiastically acknowledge that I am right--both types of system behavior are expected to occur. However, they now claim that their numerical calculations actually include both possibilities, and that they actually did all along! The letter says that they just explained things really badly.</p><p>They have made more changes to the manuscript. It now states that both behaviors can occur and that both are fully included. I am not in a position to check whether their results are consistent with this. The paper does a lot of heavy numerical calculation, which would take a long time to replicate. Since the bottom line result is not going to depend much on the intermediate details, it is plausible that their graphs could have been showing the fully correct answers all along.</p><p>However, the format of the paper suggests otherwise. Add to that the fact that the second draft of the paper actually argued obliquely against the type of behavior that they now admit is natural. I feel like there are two likely possibilities. The first is that the authors are being dishonest. They missed the second possibility, and now that I have pointed out that it definitely occurs, they have reasoned that they can fib about the matter and it will be difficult to refute their claim. I am rather unhappy about this possibility; I hope it&apos;s not the case. The second possibility is that the communication between the two authors of the paper was extremely poor. The person who did the actual writing would have to have been quite ignorant of what his coauthor was actually calculating. This is a less troubling but still far from ideal situation.</p><p>So, once again, I find myself unsure what to do. Should I share my misgivings with the editor? Or should I take the current draft&apos;s claims as is--chalk the whole thing up to incompetence rather than dishonesty? I have, after all, no concrete evidence of fraud.</p>', N'', CAST(0x0000A4B000000000 AS DateTime), CAST(0x0000A4B000000000 AS DateTime), 5, 1)
INSERT [dbo].[tbl_posts] ([PostId], [UserId], [Title], [Description], [Image], [CreatedDate], [ModifiedDate], [ViewCount], [IsPublished]) VALUES (2009, 1, N'sent a paper to referee b', N'<p>To recap: I was sent a paper to referee by a top journal. My first report pointed out that the authors had only considered one of two possible behavior patterns that their syste  <a href="http://localhost:6412/UI/single-post.aspx?id=2008">Read More</a></p>', N'', CAST(0x0000A4B000000000 AS DateTime), CAST(0x0000A4B000000000 AS DateTime), 1, 1)
INSERT [dbo].[tbl_posts] ([PostId], [UserId], [Title], [Description], [Image], [CreatedDate], [ModifiedDate], [ViewCount], [IsPublished]) VALUES (2010, 1, N'sent a paper to ', N'<p>To recap: I was sent a paper to referee by a top journal. My first report pointed out that the authors had only considered one of two possible behavior patterns that their syste  <a href="http://localhost:6412/UI/single-post.aspx?id=2008">Read More</a></p>', N'', CAST(0x0000A4B000000000 AS DateTime), CAST(0x0000A4B000000000 AS DateTime), 0, 0)
INSERT [dbo].[tbl_posts] ([PostId], [UserId], [Title], [Description], [Image], [CreatedDate], [ModifiedDate], [ViewCount], [IsPublished]) VALUES (2011, 1, N'That may be true at the moment', N'<p>That may be true at the moment, but data has a  way of expanding over time. It&apos;s much better to have a solution that  will scale from the start than to have to figure out where that sudden  increase in memory usage is coming from sometime in the future.That may be true at the moment, but data has a  way of expanding over time. It&apos;s much better to have a solution that  will scale from the start than to have to figure out where that sudden  increase in memory usage is coming from sometime in the future.That may be true at the moment, but data has a  way of expanding over time. It&apos;s much better to have a solution that  will scale from the start than to have to figure out where that sudden  increase in memory usage is coming from sometime in the future.That may be true at the moment, but data has a  way of expanding over time. It&apos;s much better to have a solution that  will scale from the start than to have to figure out where that sudden  increase in memory usage is coming from sometime in the future.</p>', N'', CAST(0x0000A4B000000000 AS DateTime), CAST(0x0000A4B000000000 AS DateTime), 1, 0)
INSERT [dbo].[tbl_posts] ([PostId], [UserId], [Title], [Description], [Image], [CreatedDate], [ModifiedDate], [ViewCount], [IsPublished]) VALUES (2012, 2, N'MY Team post', N'<p>ase in memory usage is coming from sometime in the  future.That may be true at the moment, but data has a way of expanding over  time. It much better to have a solution that will scale from the start than to  have to figure out where that sudden increase in memory usage is coming from  sometime in the future.That may be true at the moment, but data has a ase in memory  usage is coming from sometime in the future.That may be true at the moment, but  data has a way of expanding over time. Its much better to have a solution that  will scale from the start than to have to figure out where that sudden increase  in memory usage is coming from sometime in the future.That may be true at the  moment, but data has a ase in memory usage is coming from sometime in the  future.That may be true at the moment, but data has a way of expanding over  time. Its much better to have a solution that will scale from the start than to  have to figure out where that sudden increase in memory usage is coming from  sometime in the future.That may be true at the moment, but data has a</p>', N'', CAST(0x0000A4B000000000 AS DateTime), CAST(0x0000A4B000000000 AS DateTime), 1, 1)
INSERT [dbo].[tbl_posts] ([PostId], [UserId], [Title], [Description], [Image], [CreatedDate], [ModifiedDate], [ViewCount], [IsPublished]) VALUES (2013, 2, N'MY Team post', N'<p>ase in memory usage is coming from sometime in the  future.That may be true at the moment, but data has a way of expanding over  time. It much better to have a solution that will scale from the start than to  have to figure out where that sudden increase in memory usage is coming from  sometime in the future.That may be true at the moment, but data has a ase in memory  usage is coming from sometime in the future.That may be true at the moment, but  data has a way of expanding over time. Its much better to have a solution that  will scale from the start than to have to figure out where that sudden increase  in memory usage is coming from sometime in the future.That may be true at the  moment, but data has a ase in memory usage is coming from sometime in the  future.That may be true at the moment, but data has a way of expanding over  time. Its much better to have a solution that will scale from the start than to  have to figure out where that sudden increase in memory usage is coming from  sometime in the future.That may be true at the moment, but data has a</p>', N'', CAST(0x0000A4B000000000 AS DateTime), CAST(0x0000A4B000000000 AS DateTime), 11, 1)
INSERT [dbo].[tbl_posts] ([PostId], [UserId], [Title], [Description], [Image], [CreatedDate], [ModifiedDate], [ViewCount], [IsPublished]) VALUES (2014, 2, N'This is a follow-up to this questio', N'', N'', CAST(0x0000A4B000000000 AS DateTime), CAST(0x0000A4B000000000 AS DateTime), 16, 1)
INSERT [dbo].[tbl_posts] ([PostId], [UserId], [Title], [Description], [Image], [CreatedDate], [ModifiedDate], [ViewCount], [IsPublished]) VALUES (3012, 2, N'MY Team post', N'<p>MY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team post</p>', N'', CAST(0x0000A4B000F9F894 AS DateTime), CAST(0x0000A4B000F9F894 AS DateTime), 6, 1)
INSERT [dbo].[tbl_posts] ([PostId], [UserId], [Title], [Description], [Image], [CreatedDate], [ModifiedDate], [ViewCount], [IsPublished]) VALUES (3013, 2, N'MY Team postMY Team postMY', N'<p>MY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Tea<span style="color: #61BD6D;">m postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team postMY Team post</span></p>', N'', CAST(0x0000A4B000FA23F0 AS DateTime), CAST(0x0000A4B000FA23F0 AS DateTime), 26, 1)
INSERT [dbo].[tbl_posts] ([PostId], [UserId], [Title], [Description], [Image], [CreatedDate], [ModifiedDate], [ViewCount], [IsPublished]) VALUES (3014, 2, N'This is a follow-up to this questio', N'<p>This is a follow-up to this questioThis is a follow-up to this questioThis is a follow-up to this questioThis is a follow-up to this questioThis is a follow-up to this questioThis is a follow-up to this questioThis is a follow-up to this questio<span style="color: #41A85F;">This is a follow-up to this questioThis is a follow-up to this questioThis is a follow-up to this questioThis is a follow-up to this questioThis is a follow-up to this questioThis is a follow-up to this questioThis is a follow-up to this questioThis is a follow-up to this questioThis is a follow-up to this questioThis is a follow-up to this questioThis is a follow-up to this questioThis is a follow-up to this questioThis is a follow-up to this questioThis is a follow-up to this questioThis is a follow-up to this questioThis is a follow-up to this questioThis is a follow-up to this questioThis is a follow-up to this questioThis is a follow-up to this questioThis is a follow-up to this questioThis is a follow-up to this questioThis is a follow-up to this questioThis is a follow-up to this questioThis is a follow-up to this questioThis is a follow-up to this questioThis is a follow-up to this questioThis is a</span> follow-up to this questioThis is a follow-up to this questioThis is a follow-up to this questioThis is a follow-up to this questio</p>', N'', CAST(0x0000A4B000FA96C8 AS DateTime), CAST(0x0000A4B000FA96C8 AS DateTime), 61, 1)
SET IDENTITY_INSERT [dbo].[tbl_posts] OFF
SET IDENTITY_INSERT [dbo].[tbl_user] ON 

INSERT [dbo].[tbl_user] ([UserId], [Email], [FullName], [Password], [UserName]) VALUES (1, N'studentmanik@gmail.com', N'Md Manik', N'manik123', N'studentmanik')
INSERT [dbo].[tbl_user] ([UserId], [Email], [FullName], [Password], [UserName]) VALUES (2, N'sajib@gmail.com', N'Md sajib', N'sajib', N'sajib')
INSERT [dbo].[tbl_user] ([UserId], [Email], [FullName], [Password], [UserName]) VALUES (1018, N'mizan@gmail.com', N'Md', N'mizan', N'mizan')
SET IDENTITY_INSERT [dbo].[tbl_user] OFF
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_tbl_user]    Script Date: 6/8/2015 5:47:25 AM ******/
ALTER TABLE [dbo].[tbl_user] ADD  CONSTRAINT [IX_tbl_user] UNIQUE NONCLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_comment]  WITH CHECK ADD  CONSTRAINT [FK_tbl_comment_tbl_posts] FOREIGN KEY([PostId])
REFERENCES [dbo].[tbl_posts] ([PostId])
GO
ALTER TABLE [dbo].[tbl_comment] CHECK CONSTRAINT [FK_tbl_comment_tbl_posts]
GO
ALTER TABLE [dbo].[tbl_comment]  WITH CHECK ADD  CONSTRAINT [FK_tbl_comment_tbl_user] FOREIGN KEY([UserId])
REFERENCES [dbo].[tbl_user] ([UserId])
GO
ALTER TABLE [dbo].[tbl_comment] CHECK CONSTRAINT [FK_tbl_comment_tbl_user]
GO
ALTER TABLE [dbo].[tbl_posts]  WITH CHECK ADD  CONSTRAINT [FK_tbl_posts_tbl_posts] FOREIGN KEY([UserId])
REFERENCES [dbo].[tbl_user] ([UserId])
GO
ALTER TABLE [dbo].[tbl_posts] CHECK CONSTRAINT [FK_tbl_posts_tbl_posts]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tbl_posts"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tbl_user"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'homePageView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'homePageView'
GO
USE [master]
GO
ALTER DATABASE [BlogDB] SET  READ_WRITE 
GO
