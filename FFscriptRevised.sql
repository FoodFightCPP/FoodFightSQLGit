-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

CREATE SCHEMA [dbo];
GO

CREATE SCHEMA [dbo];
GO

-- ************************************** [dbo].[User]

CREATE TABLE [dbo].[User]
(
 [UserID]         uniqueidentifier NOT NULL ,
 [Username]       nvarchar(50) NOT NULL ,
 [Name]           nvarchar(75) NOT NULL ,
 [Bio]            nvarchar(255) NULL ,
 [Gender]         nvarchar(25) NULL ,
 [Email]          nvarchar(50) NOT NULL ,
 [Phone]          nvarchar(20) NULL ,
 [Password]       nvarchar(255) NOT NULL ,
 [Lat]            nvarchar(50) NULL ,
 [Lng]            nvarchar(50) NULL ,
 [Facebook]       nvarchar(255) NULL ,
 [Twitter]        nvarchar(255) NULL ,
 [Instagram]      nvarchar(255) NULL ,
 [Website]        nvarchar(255) NULL ,
 [ProfilePicture] nvarchar(255) NULL ,
 [Street]         nvarchar(255) NULL ,
 [City]           nvarchar(255) NULL ,
 [State]          nvarchar(255) NULL ,
 [ZipCode]        char(10) NULL ,


 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED ([UserID] ASC)
);
GO








-- ************************************** [dbo].[Settings]

CREATE TABLE [dbo].[Settings]
(
 [SettingsID] uniqueidentifier NOT NULL ,
 [Name]       nvarchar(50) NOT NULL ,
 [Enabled]    bit NOT NULL ,


 CONSTRAINT [PK_Settings] PRIMARY KEY CLUSTERED ([SettingsID] ASC)
);
GO








-- ************************************** [dbo].[Restaraunts]

CREATE TABLE [dbo].[Restaraunts]
(
 [RestarauntID] nvarchar(255) NOT NULL ,
 [Name]         nchar(255) NOT NULL ,
 [Street]       nvarchar(255) NULL ,
 [Phone]        nvarchar(20) NULL ,
 [City]         nvarchar(255) NULL ,
 [State]        nvarchar(255) NULL ,
 [Lat]          nvarchar(50) NULL ,
 [Lng]          nvarchar(50) NULL ,
 [OpenNow]      nvarchar(50) NULL ,
 [Website]      nvarchar(255) NULL ,
 [rating]       float NULL ,
 [ZipCode]      char(10) NULL ,
 [Photo]        nvarchar(100) NULL ,


 CONSTRAINT [PK_Restaraunts] PRIMARY KEY CLUSTERED ([RestarauntID] ASC)
);
GO








-- ************************************** [UserSettings]

CREATE TABLE [UserSettings]
(
 [UserSettingsID] uniqueidentifier NOT NULL ,
 [SettingsID]     uniqueidentifier NOT NULL ,
 [UserID]         uniqueidentifier NOT NULL ,


 CONSTRAINT [PK_UserSettings] PRIMARY KEY CLUSTERED ([UserSettingsID] ASC),
 CONSTRAINT [FK_UserSettings_SettingsID] FOREIGN KEY ([SettingsID])  REFERENCES [dbo].[Settings]([SettingsID]),
 CONSTRAINT [FK_UserSettings_UserID] FOREIGN KEY ([UserID])  REFERENCES [dbo].[User]([UserID])
);
GO


CREATE NONCLUSTERED INDEX [fkIdx_UserSettings_SettingsID] ON [UserSettings] 
 (
  [SettingsID] ASC
 )

GO

CREATE NONCLUSTERED INDEX [fkIdx_UserSettings_UserID] ON [UserSettings] 
 (
  [UserID] ASC
 )

GO







-- ************************************** [dbo].[FavoriteRestaurant]

CREATE TABLE [dbo].[FavoriteRestaurant]
(
 [FavoriteRestaurantID] uniqueidentifier NOT NULL ,
 [RestarauntID]         nvarchar(255) NOT NULL ,
 [UserID]               uniqueidentifier NOT NULL ,


 CONSTRAINT [PK_FavoriteRestaurant] PRIMARY KEY CLUSTERED ([FavoriteRestaurantID] ASC),
 CONSTRAINT [FK_FavoriteRestaurant_RestaurantID] FOREIGN KEY ([RestarauntID])  REFERENCES [dbo].[Restaraunts]([RestarauntID]),
 CONSTRAINT [FK_FavoriteRestaurant_UserID] FOREIGN KEY ([UserID])  REFERENCES [dbo].[User]([UserID])
);
GO


CREATE NONCLUSTERED INDEX [fkIdx_FavoriteRestaurant_RestaurantID] ON [dbo].[FavoriteRestaurant] 
 (
  [RestarauntID] ASC
 )

GO

CREATE NONCLUSTERED INDEX [fkIdx_FavoriteRestaurant_UserID] ON [dbo].[FavoriteRestaurant] 
 (
  [UserID] ASC
 )

GO







-- ************************************** [dbo].[ConnectedUsers]

CREATE TABLE [dbo].[ConnectedUsers]
(
 [ConnectedUserID]       uniqueidentifier NOT NULL ,
 [BaseUserID]      uniqueidentifier NOT NULL ,
 [FriendUserID] uniqueidentifier NOT NULL ,


 CONSTRAINT [PK_ConnectedUsers] PRIMARY KEY CLUSTERED ([ConnectedUserID] ASC),
 CONSTRAINT [FK_ConnectedUsersBase_UserID] FOREIGN KEY ([BaseUserID])  REFERENCES [dbo].[User]([UserID]),
 CONSTRAINT [FK_ConnectedUsersFriend_UserID] FOREIGN KEY ([FriendUserID])  REFERENCES [dbo].[User]([UserID])
);
GO








-- ************************************** [dbo].[BlockedUsers]

CREATE TABLE [dbo].[BlockedUsers]
(
 [BlockUserID]   uniqueidentifier NOT NULL ,
 [BaseUserID]    uniqueidentifier NOT NULL ,
 [BlockedUserID] uniqueidentifier NOT NULL ,


 CONSTRAINT [PK_BlockedUsers] PRIMARY KEY CLUSTERED ([BlockUserID] ASC),
 CONSTRAINT [FK_BlockedUsersBase_UserID] FOREIGN KEY ([BaseUserID])  REFERENCES [dbo].[User]([UserID]),
 CONSTRAINT [FK_BlockedUsersID_UserID] FOREIGN KEY ([BlockedUserID])  REFERENCES [dbo].[User]([UserID])
);
GO


CREATE NONCLUSTERED INDEX [fkIdx_BlockedUsersBase_UserID] ON [dbo].[BlockedUsers] 
 (
  [BaseUserID] ASC
 )

GO

CREATE NONCLUSTERED INDEX [fkIdx_BlockedUsersBlocked_UserID] ON [dbo].[BlockedUsers] 
 (
  [BlockedUserID] ASC
 )

GO







-- ************************************** [dbo].[BlockedRestaurant]

CREATE TABLE [dbo].[BlockedRestaurant]
(
 [BlockedRestaurantID] uniqueidentifier NOT NULL ,
 [RestarauntID]        nvarchar(255) NOT NULL ,
 [UserID]              uniqueidentifier NOT NULL ,


 CONSTRAINT [PK_BlockedRestaurant] PRIMARY KEY CLUSTERED ([BlockedRestaurantID] ASC),
 CONSTRAINT [FK_BlockedRestaurants_RestaurantID] FOREIGN KEY ([RestarauntID])  REFERENCES [dbo].[Restaraunts]([RestarauntID]),
 CONSTRAINT [FK_BlockedRestaurants_UserID] FOREIGN KEY ([UserID])  REFERENCES [dbo].[User]([UserID])
);
GO


CREATE NONCLUSTERED INDEX [fkIdx_BlockedRestaurants_RestaurantID] ON [dbo].[BlockedRestaurant] 
 (
  [RestarauntID] ASC
 )

GO

CREATE NONCLUSTERED INDEX [fkIdx_BlockedRestaurants_UserID] ON [dbo].[BlockedRestaurant] 
 (
  [UserID] ASC
 )

GO







-- ************************************** [dbo].[MatchSession]

CREATE TABLE [dbo].[MatchSession]
(
 [MatchSessionID] uniqueidentifier NOT NULL ,
 [ConnectedUserID]      uniqueidentifier NOT NULL ,
 [DateTime]       datetime NOT NULL ,
 [Lat]            nvarchar(50) NULL ,
 [Lng]            nvarchar(50) NULL ,


 CONSTRAINT [PK_MatchSession] PRIMARY KEY CLUSTERED ([MatchSessionID] ASC),
 CONSTRAINT [FK_MatchSession_ConnectedID] FOREIGN KEY ([ConnectedUserID])  REFERENCES [dbo].[ConnectedUsers]([ConnectedUserID])
);
GO


CREATE NONCLUSTERED INDEX [fkIdx_MatchSession_ConnectedUserID] ON [dbo].[MatchSession] 
 (
  [ConnectedUserID] ASC
 )

GO







-- ************************************** [dbo].[SwipeList]

CREATE TABLE [dbo].[SwipeList]
(
 [SwipeListID]    uniqueidentifier NOT NULL ,
 [RestaurantID]         nvarchar(255) NOT NULL ,
 [MatchSessionID] uniqueidentifier NOT NULL ,


 CONSTRAINT [PK_SwipeList] PRIMARY KEY CLUSTERED ([SwipeListID] ASC),
 CONSTRAINT [FK_SwipeList_MatchSessionId] FOREIGN KEY ([MatchSessionID])  REFERENCES [dbo].[MatchSession]([MatchSessionID]),
 CONSTRAINT [FK_SwipeList_RestaurantID] FOREIGN KEY ([RestaurantID])  REFERENCES [dbo].[Restaraunts]([RestarauntID])
);
GO








-- ************************************** [dbo].[RejectedRestaurant]

CREATE TABLE [dbo].[RejectedRestaurant]
(
 [RejectedRestaurantID] uniqueidentifier NOT NULL ,
 [DateTime]             datetime NOT NULL ,
 [SwipeListID]          uniqueidentifier NOT NULL ,
 [UserID]               nvarchar(50) NOT NULL ,


 CONSTRAINT [PK_RejectedRestaurant] PRIMARY KEY CLUSTERED ([RejectedRestaurantID] ASC),
 CONSTRAINT [FK_RejectedRestaurant_SwipeListID] FOREIGN KEY ([SwipeListID])  REFERENCES [dbo].[SwipeList]([SwipeListID])
);
GO


CREATE NONCLUSTERED INDEX [fkIdx_RejectedRestaurant_SwipeListID] ON [dbo].[RejectedRestaurant] 
 (
  [SwipeListID] ASC
 )

GO







-- ************************************** [dbo].[AcceptedRestaurant]

CREATE TABLE [dbo].[AcceptedRestaurant]
(
 [AcceptedRestaurantID]  uniqueidentifier NOT NULL ,
 [SwipeListID] uniqueidentifier NOT NULL ,
 [DateTime]    datetime NOT NULL ,
 [UserID]      nvarchar(50) NOT NULL ,


 CONSTRAINT [PK_AcceptedRestaurant] PRIMARY KEY CLUSTERED ([AcceptedRestaurantID] ASC),
 CONSTRAINT [FK_AcceptedRestaurant_SwipeListID] FOREIGN KEY ([SwipeListID])  REFERENCES [dbo].[SwipeList]([SwipeListID])
);
GO


CREATE NONCLUSTERED INDEX [fkIdx_AcceptedRestaurant_SwipeListID] ON [dbo].[AcceptedRestaurant] 
 (
  [SwipeListID] ASC
 )

GO







-- ************************************** [dbo].[MatchedRestaurant]

CREATE TABLE [dbo].[MatchedRestaurant]
(
 [MatchRestaurantID] uniqueidentifier NOT NULL ,
 [DateTIme]          datetime NOT NULL ,
 [AcceptedRestaurantID]        uniqueidentifier NOT NULL ,


 CONSTRAINT [PK_MatchedRestaurant] PRIMARY KEY CLUSTERED ([MatchRestaurantID] ASC),
 CONSTRAINT [FK_MatchedRestaurant_AcceptedRestaurantID] FOREIGN KEY ([AcceptedRestaurantID])  REFERENCES [dbo].[AcceptedRestaurant]([AcceptedRestaurantID])
);
GO


CREATE NONCLUSTERED INDEX [fkIdx_MatchedRestaurant_AcceptedRestaurantID] ON [dbo].[MatchedRestaurant] 
 (
  [AcceptedRestaurantID] ASC
 )

GO







