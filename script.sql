USE [master]
GO
/****** Object:  Database [WebDota]    Script Date: 12/30/2016 8:54:39 PM ******/
CREATE DATABASE [WebDota]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'WebDota', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\WebDota.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'WebDota_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\WebDota_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [WebDota] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [WebDota].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [WebDota] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [WebDota] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [WebDota] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [WebDota] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [WebDota] SET ARITHABORT OFF 
GO
ALTER DATABASE [WebDota] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [WebDota] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [WebDota] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [WebDota] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [WebDota] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [WebDota] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [WebDota] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [WebDota] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [WebDota] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [WebDota] SET  DISABLE_BROKER 
GO
ALTER DATABASE [WebDota] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [WebDota] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [WebDota] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [WebDota] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [WebDota] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [WebDota] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [WebDota] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [WebDota] SET RECOVERY FULL 
GO
ALTER DATABASE [WebDota] SET  MULTI_USER 
GO
ALTER DATABASE [WebDota] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [WebDota] SET DB_CHAINING OFF 
GO
ALTER DATABASE [WebDota] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [WebDota] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [WebDota] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'WebDota', N'ON'
GO
USE [WebDota]
GO
/****** Object:  UserDefinedFunction [dbo].[baseAgility]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[baseAgility]
(
	-- Add the parameters for the function here
	@playerId int
)
RETURNS int
AS
BEGIN
	DECLARE @ret int;  


    SELECT @ret = 
	
	 (sum (hero.agility) + SUM (items.BonusAgl))
    FROM dbo.Player player , dbo.Items  items , PlayerHasItem playerHasItem
	, Hero hero , PlayerControlHero playerHero
    WHERE player.ID = @playerId
	and    playerHasItem.PlayerID = player.ID and playerHasItem.ItemID = items.ID
	and hero.ID = playerHero.HeroID and player.ID = playerHero.PlayerID
        
		
		  
     IF (@ret IS NULL)   
        SET @ret = 0;  
    RETURN @ret; 

END






GO
/****** Object:  UserDefinedFunction [dbo].[baseArmor]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[baseArmor]
(
	-- Add the parameters for the function here
	@playerId int
)
RETURNS int
AS
BEGIN
	DECLARE @ret int;
	DECLARE @terror bit;


    SELECT @terror = player.Terror,@ret = 
	
	 (sum (hero.agility) + SUM (items.BonusAgl)) +   
	 SUM(items.BonusArmor)
    FROM dbo.Player player , dbo.Items  items , PlayerHasItem playerHasItem
	, Hero hero , PlayerControlHero playerHero
    WHERE player.ID = @playerId
	and    playerHasItem.PlayerID = player.ID and playerHasItem.ItemID = items.ID
	and hero.ID = playerHero.HeroID and player.ID = playerHero.PlayerID
	GROUP BY player.Terror
        
		
		  
     IF (@ret IS NULL and @terror = 1)   
        SET @ret = 0;  
    RETURN @ret; 

END






GO
/****** Object:  UserDefinedFunction [dbo].[baseHP]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[baseHP]
(
	-- Add the parameters for the function here
	@playerId int
)
RETURNS int
AS
BEGIN
	DECLARE @ret int;  


    SELECT @ret = 
	
	 Ceiling( (sum (hero.strength) + SUM (items.BonusStr)) *  75.55) +   
	 SUM(items.BonusHP)
    FROM dbo.Player player , dbo.Items  items , PlayerHasItem playerHasItem
	, Hero hero , PlayerControlHero playerHero
    WHERE player.ID = @playerId
	and    playerHasItem.PlayerID = player.ID and playerHasItem.ItemID = items.ID
	and hero.ID = playerHero.HeroID and player.ID = playerHero.PlayerID
        
		
		  
     IF (@ret IS NULL)   
        SET @ret = 0;  
    RETURN @ret; 

END







GO
/****** Object:  UserDefinedFunction [dbo].[baseIntelligence]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[baseIntelligence]
(
	-- Add the parameters for the function here
	@playerId int
)
RETURNS int
AS
BEGIN
	DECLARE @ret int;  


    SELECT @ret = 
	
	 (sum (hero.Intelligence) + SUM (items.BonusIntl))
    FROM dbo.Player player , dbo.Items  items , PlayerHasItem playerHasItem
	, Hero hero , PlayerControlHero playerHero
    WHERE player.ID = @playerId
	and    playerHasItem.PlayerID = player.ID and playerHasItem.ItemID = items.ID
	and hero.ID = playerHero.HeroID and player.ID = playerHero.PlayerID
        
		
		  
     IF (@ret IS NULL)   
        SET @ret = 0;  
    RETURN @ret; 

END






GO
/****** Object:  UserDefinedFunction [dbo].[baseMana]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[baseMana]
(
	-- Add the parameters for the function here
	@playerId int
)
RETURNS int
AS
BEGIN
	DECLARE @ret int;  


    SELECT @ret = 
	
	 Ceiling( (sum (hero.Intelligence) + SUM (items.BonusIntl)) *  80) +   
	 SUM(items.BonusMana)
    FROM dbo.Player player , dbo.Items  items , PlayerHasItem playerHasItem
	, Hero hero , PlayerControlHero playerHero
    WHERE player.ID = @playerId
	and    playerHasItem.PlayerID = player.ID and playerHasItem.ItemID = items.ID
	and hero.ID = playerHero.HeroID and player.ID = playerHero.PlayerID
        
		
		  
     IF (@ret IS NULL)   
        SET @ret = 0;  
    RETURN @ret; 

END






GO
/****** Object:  UserDefinedFunction [dbo].[baseStrength]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[baseStrength]
(
	-- Add the parameters for the function here
	@playerId int
)
RETURNS int
AS
BEGIN
	DECLARE @ret int;  


    SELECT @ret = 
	
	 (sum (hero.strength) + SUM (items.BonusStr))
    FROM dbo.Player player , dbo.Items  items , PlayerHasItem playerHasItem
	, Hero hero , PlayerControlHero playerHero
    WHERE player.ID = @playerId
	and    playerHasItem.PlayerID = player.ID and playerHasItem.ItemID = items.ID
	and hero.ID = playerHero.HeroID and player.ID = playerHero.PlayerID
        
		
		  
     IF (@ret IS NULL)   
        SET @ret = 0;  
    RETURN @ret; 

END







GO
/****** Object:  UserDefinedFunction [dbo].[checkSpellCondition]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[checkSpellCondition]
(
	-- Add the parameters for the function here
	@playerId int,
	@spell nchar(1000)
)
RETURNS int
AS
BEGIN
	DECLARE @level int;
	DECLARE @mana int;
	DECLARE @currentmana int;

	
	SELECT @level = [level] , @mana = mana FROM Magics WHERE Spell = @spell
	SELECT @currentmana = CurrentMana FROM Player WHERE ID = @playerId

	if(dbo.GetPlayerLevel(@playerId) >= @level and @mana > @currentmana)
		RETURN 1;

  RETURN 0; 

END






GO
/****** Object:  UserDefinedFunction [dbo].[GetGoldOnDeath]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GetGoldOnDeath]
(
	@PlayerId int
)
RETURNS int
AS
BEGIN
	DECLARE @ret int;  

	select @ret =
	
	player.Gold 
    FROM dbo.Player player 
    WHERE player.ID = @playerId
		
        
		
		  
     IF (@ret IS NULL)   
        SET @ret = 0;  
	IF(@ret < 400)
		RETURN @ret; 
	RETURN 400;

END






GO
/****** Object:  UserDefinedFunction [dbo].[GetPlayerAttack]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:    <Author,,Name>
-- Create date: <Create Date, ,>
-- Description:  <Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GetPlayerAttack]
(
  -- Add the parameters for the function here
  @playerId int
)
RETURNS int
AS
BEGIN
  DECLARE @ret int;  


    SELECT @ret = 
  
   Ceiling(sum (hero.Attack)) +   
   SUM(items.BonusAttack) +
   SUM(items.BonusStr) * 2
    FROM dbo.Player player , dbo.Items  items , PlayerHasItem playerHasItem
  , Hero hero , PlayerControlHero playerHero
    WHERE player.ID = @playerId
  and    playerHasItem.PlayerID = player.ID and playerHasItem.ItemID = items.ID
  and hero.ID = playerHero.HeroID and player.ID = playerHero.PlayerID
        
    
      
     IF (@ret IS NULL)   
        SET @ret = 0;  
    RETURN @ret; 

END



GO
/****** Object:  UserDefinedFunction [dbo].[GetPlayerLevel]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GetPlayerLevel]
(
	-- Add the parameters for the function here
	@playerId int
)
RETURNS int
AS
BEGIN
	DECLARE @ret int;  
	DECLARE @exp int;  


    SELECT @exp = 
	
	player.Exprience
    FROM dbo.Player player --, [dbo].[Level] lvl
    WHERE player.ID = @playerId
	


	select @ret =
	
	lvl.Number
    FROM dbo.Player player , [dbo].[Level] lvl
    WHERE player.ID = @playerId
		and @exp <= lvl.MaxExp and  @exp >= lvl.MinExp
        
		
		  
     IF (@ret IS NULL)   
        SET @ret = 0;  
    RETURN @ret; 

END






GO
/****** Object:  UserDefinedFunction [dbo].[GetPlayerRank]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GetPlayerRank]
(
	-- Add the parameters for the function here
	@playerId int
)
RETURNS int
AS
BEGIN
	DECLARE @ret int;  
	DECLARE @lvl int;  



	set @lvl=
	 [dbo].[GetPlayerLevel](@playerId)


	select @ret =
	
	player.[Kill] * 4 + player.Assint* 12 - player.Death * 3 + @lvl 
    FROM dbo.Player player 
    WHERE player.ID = @playerId
		
        
		
		  
     IF (@ret IS NULL)   
        SET @ret = 0;  
    RETURN @ret; 

END






GO
/****** Object:  UserDefinedFunction [dbo].[GetPlayerRegion]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GetPlayerRegion]
(
	-- Add the parameters for the function here
	@playerId int
)
RETURNS int
AS
BEGIN
	DECLARE @ret nchar(1000);  
	
	SELECT @ret = region.Name FROM dbo.Player player,dbo.PlayAtRegion playatregion,dbo.Region region
	WHERE player.ID = playatregion.PlayerID and playatregion.RegionID = region.Name
		  
     IF (@ret IS NULL)   
        SET @ret = 0;  
    RETURN @ret; 

END






GO
/****** Object:  UserDefinedFunction [dbo].[GoldSpy]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[GoldSpy]
(
	-- Add the parameters for the function here
	@Attacker int,
	@target int
)
RETURNS int
AS
Begin

	if(dbo.checkSpellCondition(@Attacker,'GoldSpy') != 1)
		return 0;

	EXEC dbo.DecreaseTurn @attacker;

	exec IncreaseExprience @attacker, 10;
	EXEC LogMagic @Attacker,@target,'GoldSpy';

	declare @ret int;


	select @ret =player.Gold
    FROM dbo.Player player 
    WHERE player.ID = @target

     IF (@ret IS NULL)   
        SET @ret = 0;  
    RETURN @ret; 
End


GO
/****** Object:  UserDefinedFunction [dbo].[HeroSpy]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[HeroSpy]
(
	-- Add the parameters for the function here
	@Attacker int,
	@target int
)
RETURNS @retTable TABLE 
(
	-- Add the SELECT statement with parameter references here
	Agility int,
	Strength int,
	Intelligence int,
	Gold int
		
 
)
AS
Begin

	if(dbo.checkSpellCondition(@Attacker,'HeroSpy') != 1)
		return;

	EXEC dbo.DecreaseTurn @attacker;

	exec IncreaseExprience @attacker, 10;
	EXEC LogMagic @Attacker,@target,'HeroSpy';


	declare @agl int =  dbo.baseAgility( @target);
	declare @str int =  dbo.baseStrength( @target);
	declare @intl int =  dbo.baseIntelligence( @target);




	insert @retTable select @agl , @str , @intl,
	(select player.Gold
    FROM dbo.Player player 
    WHERE player.ID = @target)

	Return
End


GO
/****** Object:  Table [dbo].[AttackLog]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AttackLog](
	[ActorID] [int] NOT NULL,
	[TargetID] [int] NOT NULL,
	[AttackAmount] [int] NOT NULL,
	[ID] [int] NOT NULL,
	[AttackRecieved] [int] NOT NULL,
	[createdAt] [datetime] NOT NULL,
 CONSTRAINT [PK_AttackLog] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[City]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[City](
	[Name] [nchar](1000) NOT NULL,
	[ID] [int] NOT NULL,
 CONSTRAINT [PK_City] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CityExistIn]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CityExistIn](
	[CityID] [int] NOT NULL,
	[CountryID] [int] NOT NULL,
	[ID] [int] NOT NULL,
 CONSTRAINT [PK_CityExistIn] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Constant]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Constant](
	[ID] [int] NOT NULL,
	[Name] [nchar](1000) NOT NULL,
	[Value] [nchar](1000) NOT NULL,
 CONSTRAINT [PK_Constant] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Country]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Country](
	[Name] [nchar](1000) NOT NULL,
	[ID] [int] NOT NULL,
 CONSTRAINT [PK_Country] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[HealLogs]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HealLogs](
	[ActorID] [int] NOT NULL,
	[HealAmount] [int] NOT NULL,
	[TargetID] [int] NOT NULL,
	[ID] [int] NOT NULL,
 CONSTRAINT [PK_HealLogs] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Hero]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Hero](
	[Name] [nchar](100) NOT NULL,
	[Intelligence] [int] NOT NULL,
	[agility] [int] NOT NULL,
	[strength] [int] NOT NULL,
	[Attack] [int] NOT NULL,
	[Logo] [nvarchar](max) NOT NULL,
	[Armor] [int] NOT NULL,
	[ID] [int] NOT NULL,
 CONSTRAINT [PK_Hero] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[HeroIsTypeOf]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HeroIsTypeOf](
	[TypeID] [int] NOT NULL,
	[HeroID] [int] NOT NULL,
	[ID] [int] NOT NULL,
 CONSTRAINT [PK_HeroIsTypeOf] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[HeroMemberOfTeam]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HeroMemberOfTeam](
	[TeamID] [int] NOT NULL,
	[HeroID] [int] NOT NULL,
	[ID] [int] NOT NULL,
 CONSTRAINT [PK_HeroMemberOfTeam] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[HeroUnique]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HeroUnique](
	[HeroID] [int] NOT NULL,
	[UniqueID] [int] NOT NULL,
	[ID] [int] NOT NULL,
 CONSTRAINT [PK_HeroUnique] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Items]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Items](
	[BonusStr] [int] NOT NULL,
	[BonusAgl] [int] NOT NULL,
	[BonusIntl] [int] NOT NULL,
	[BonusMana] [int] NOT NULL,
	[BonusHP] [int] NOT NULL,
	[BonusArmor] [int] NOT NULL,
	[Price] [int] NOT NULL,
	[ID] [int] NOT NULL,
	[BonusAttack] [int] NOT NULL,
	[name] [nchar](100) NOT NULL,
	[region] [nchar](10) NOT NULL,
	[level] [int] NOT NULL,
 CONSTRAINT [PK_Items] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[KillLogs]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KillLogs](
	[KillerID] [int] NOT NULL,
	[KilledID] [int] NOT NULL,
	[ID] [int] NOT NULL,
	[createdAt] [datetime] NOT NULL,
 CONSTRAINT [PK_KillLogs] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Level]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Level](
	[Number] [int] NOT NULL,
	[MinExp] [int] NOT NULL,
	[MaxExp] [int] NOT NULL,
	[ID] [int] NOT NULL,
 CONSTRAINT [PK_Level] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MagicLimitedByType]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MagicLimitedByType](
	[MagicID] [nchar](100) NOT NULL,
	[TypeId] [int] NOT NULL,
	[ID] [int] NOT NULL,
 CONSTRAINT [PK_MagicLimitedByType] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MagicLogs]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MagicLogs](
	[TargetID] [int] NOT NULL,
	[ActorID] [int] NOT NULL,
	[Spell] [nchar](100) NOT NULL,
	[ID] [int] NOT NULL,
	[createdAt] [datetime] NOT NULL,
 CONSTRAINT [PK_MagicLogs] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Magics]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Magics](
	[Description] [nchar](1000) NOT NULL,
	[Spell] [nchar](1000) NOT NULL,
	[ID] [nchar](100) NOT NULL,
	[level] [int] NOT NULL,
	[mana] [int] NOT NULL,
 CONSTRAINT [PK_Magics] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PlayAtRegion]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlayAtRegion](
	[PlayerID] [int] NOT NULL,
	[RegionID] [int] NOT NULL,
	[ID] [int] NOT NULL,
 CONSTRAINT [PK_PlayAtRegion] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Player]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Player](
	[KS] [int] NOT NULL,
	[Death] [int] NOT NULL,
	[CurrentMana] [int] NOT NULL,
	[Kill] [int] NOT NULL,
	[Assint] [int] NOT NULL,
	[CurrentHP] [int] NOT NULL,
	[Exprience] [int] NOT NULL,
	[BonusIntl] [int] NOT NULL,
	[BonusAgl] [int] NOT NULL,
	[BonusStr] [int] NOT NULL,
	[ID] [int] NOT NULL,
	[Gold] [int] NOT NULL,
	[Turn] [int] NOT NULL,
	[Bounce] [int] NOT NULL,
	[Terror] [bit] NOT NULL,
 CONSTRAINT [PK_Player] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PlayerControlHero]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlayerControlHero](
	[HeroID] [int] NOT NULL,
	[PlayerID] [int] NOT NULL,
	[ID] [int] NOT NULL,
 CONSTRAINT [PK_PlayerControlHero] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PlayerHasItem]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlayerHasItem](
	[PlayerID] [int] NOT NULL,
	[ItemID] [int] NOT NULL,
	[ID] [int] NOT NULL,
 CONSTRAINT [PK_PlayerHasItem] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Region]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Region](
	[Name] [nchar](1000) NOT NULL,
	[ID] [int] NOT NULL,
 CONSTRAINT [PK_Region] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Team]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Team](
	[Name] [nchar](100) NOT NULL,
	[Logo] [nvarchar](max) NOT NULL,
	[ID] [int] NOT NULL,
 CONSTRAINT [PK_Team] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TurnAssignment]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TurnAssignment](
	[Amount] [int] NOT NULL,
	[AgilityAmount] [int] NOT NULL,
	[ID] [int] NOT NULL,
	[TurnCeil] [int] NOT NULL,
	[type] [nchar](100) NOT NULL,
 CONSTRAINT [PK_TurnAssignment] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TurnLimitedBy]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TurnLimitedBy](
	[TurnID] [int] NOT NULL,
	[TypeID] [int] NOT NULL,
	[ID] [int] NOT NULL,
 CONSTRAINT [PK_LimitedBY] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Type]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Type](
	[Name] [nchar](100) NOT NULL,
	[HealGain] [int] NOT NULL,
	[ID] [int] NOT NULL,
 CONSTRAINT [PK_Type] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UniqueAbilitySP]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UniqueAbilitySP](
	[ID] [int] NOT NULL,
 CONSTRAINT [PK_UniqueAbilitySP] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[User]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[Age] [int] NOT NULL,
	[Name] [nchar](100) NOT NULL,
	[UserName] [nchar](100) NOT NULL,
	[Password] [nchar](1000) NOT NULL,
	[Email] [nchar](1000) NOT NULL,
	[ID] [int] NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserLocation]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserLocation](
	[CountryID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[ID] [int] NOT NULL,
	[CityID] [int] NOT NULL,
 CONSTRAINT [PK_UserLocation] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserMemberOf]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserMemberOf](
	[UserID] [int] NOT NULL,
	[TeamID] [int] NOT NULL,
	[ID] [int] NOT NULL,
 CONSTRAINT [PK_UserMemberOf] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserPlayPlayer]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserPlayPlayer](
	[PlayerID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[ID] [int] NOT NULL,
 CONSTRAINT [PK_UserPlayPlayer] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[VendorLocation]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VendorLocation](
	[ItemID] [int] NOT NULL,
	[RegionID] [int] NOT NULL,
	[ID] [int] NOT NULL,
 CONSTRAINT [PK_VendorLocation] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[baseArmor_View]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[baseArmor_View]
AS
SELECT        ID, dbo.baseArmor(ID) AS Expr1
FROM            dbo.Player






GO
/****** Object:  View [dbo].[baseHP_View]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[baseHP_View]
AS
SELECT        ID, dbo.baseHP(ID) AS Expr1
FROM            dbo.Player






GO
/****** Object:  View [dbo].[baseMana_View]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[baseMana_View]
AS
SELECT        ID, dbo.baseMana(ID) AS Expr1
FROM            dbo.Player






GO
/****** Object:  View [dbo].[GetPlayerRank_View]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[GetPlayerRank_View]
AS
SELECT        ID, dbo.GetPlayerRank(ID) AS Expr1
FROM            dbo.Player






GO
/****** Object:  View [dbo].[PlayersLevel_view]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[PlayersLevel_view]
AS
SELECT        ID, dbo.GetPlayerLevel(ID) AS Expr1
FROM            dbo.Player






GO
INSERT [dbo].[Items] ([BonusStr], [BonusAgl], [BonusIntl], [BonusMana], [BonusHP], [BonusArmor], [Price], [ID], [BonusAttack], [name], [region], [level]) VALUES (0, 0, 0, 0, 500, 0, 200, 1, 0, N'Flask of Sapphire Water                                                                             ', N'center    ', 1)
INSERT [dbo].[Items] ([BonusStr], [BonusAgl], [BonusIntl], [BonusMana], [BonusHP], [BonusArmor], [Price], [ID], [BonusAttack], [name], [region], [level]) VALUES (0, 0, 0, 500, 0, 0, 200, 2, 0, N'Lesser Clarity Portion                                                                              ', N'center    ', 1)
INSERT [dbo].[Items] ([BonusStr], [BonusAgl], [BonusIntl], [BonusMana], [BonusHP], [BonusArmor], [Price], [ID], [BonusAttack], [name], [region], [level]) VALUES (1, 1, 1, 0, 0, 0, 200, 3, 0, N'Ironwood Branch                                                                                     ', N'center    ', 1)
INSERT [dbo].[Items] ([BonusStr], [BonusAgl], [BonusIntl], [BonusMana], [BonusHP], [BonusArmor], [Price], [ID], [BonusAttack], [name], [region], [level]) VALUES (0, 0, 0, 250, 250, 0, 200, 4, 0, N'Bottle                                                                                              ', N'center    ', 1)
INSERT [dbo].[Items] ([BonusStr], [BonusAgl], [BonusIntl], [BonusMana], [BonusHP], [BonusArmor], [Price], [ID], [BonusAttack], [name], [region], [level]) VALUES (0, 0, 0, 0, 0, 0, 500, 5, 10, N'Blades of Attack                                                                                    ', N'center    ', 1)
INSERT [dbo].[Items] ([BonusStr], [BonusAgl], [BonusIntl], [BonusMana], [BonusHP], [BonusArmor], [Price], [ID], [BonusAttack], [name], [region], [level]) VALUES (4, 0, 0, 0, 0, 0, 850, 6, 0, N'Gauntlets of Ogre Strength                                                                          ', N'center    ', 1)
INSERT [dbo].[Items] ([BonusStr], [BonusAgl], [BonusIntl], [BonusMana], [BonusHP], [BonusArmor], [Price], [ID], [BonusAttack], [name], [region], [level]) VALUES (0, 4, 0, 0, 0, 0, 850, 7, 0, N'Slippers of Agility                                                                                 ', N'center    ', 1)
INSERT [dbo].[Items] ([BonusStr], [BonusAgl], [BonusIntl], [BonusMana], [BonusHP], [BonusArmor], [Price], [ID], [BonusAttack], [name], [region], [level]) VALUES (0, 0, 4, 0, 0, 0, 850, 8, 0, N'Mantle of Intelligence                                                                              ', N'center    ', 1)
INSERT [dbo].[Items] ([BonusStr], [BonusAgl], [BonusIntl], [BonusMana], [BonusHP], [BonusArmor], [Price], [ID], [BonusAttack], [name], [region], [level]) VALUES (0, 0, 0, 0, 0, 0, 1800, 9, 0, N'Sobi Mask                                                                                           ', N'center    ', 1)
INSERT [dbo].[Items] ([BonusStr], [BonusAgl], [BonusIntl], [BonusMana], [BonusHP], [BonusArmor], [Price], [ID], [BonusAttack], [name], [region], [level]) VALUES (0, 0, 0, 0, 0, 0, 3000, 10, 0, N'Ring of Regeneration                                                                                ', N'center    ', 1)
INSERT [dbo].[Level] ([Number], [MinExp], [MaxExp], [ID]) VALUES (1, 1000, 3000, 1)
INSERT [dbo].[Level] ([Number], [MinExp], [MaxExp], [ID]) VALUES (2, 3001, 4500, 2)
INSERT [dbo].[Level] ([Number], [MinExp], [MaxExp], [ID]) VALUES (3, 4501, 6750, 3)
INSERT [dbo].[Level] ([Number], [MinExp], [MaxExp], [ID]) VALUES (4, 6751, 11225, 4)
INSERT [dbo].[Level] ([Number], [MinExp], [MaxExp], [ID]) VALUES (5, 11226, 17000, 5)
INSERT [dbo].[Level] ([Number], [MinExp], [MaxExp], [ID]) VALUES (6, 17001, 99999, 6)
INSERT [dbo].[Magics] ([Description], [Spell], [ID], [level], [mana]) VALUES (N'The basic magic attack.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 ', N'LightningBolt                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           ', N'1                                                                                                   ', 1, 450)
INSERT [dbo].[Magics] ([Description], [Spell], [ID], [level], [mana]) VALUES (N'Take portion of enemy HP to heal yourself.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              ', N'BrandSap                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                ', N'10                                                                                                  ', 5, 850)
INSERT [dbo].[Magics] ([Description], [Spell], [ID], [level], [mana]) VALUES (N'Deadly spell that almost kill an enemy. (Level 7 spell if not in War)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   ', N'FingerOfDeath                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           ', N'11                                                                                                  ', 6, 900)
INSERT [dbo].[Magics] ([Description], [Spell], [ID], [level], [mana]) VALUES (N'Switch soul between enemy and you, thus carry enemy health and mana.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', N'Sunder                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  ', N'12                                                                                                  ', 6, 1500)
INSERT [dbo].[Magics] ([Description], [Spell], [ID], [level], [mana]) VALUES (N'Switch health pool with your enemy.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     ', N'SunderHealth                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            ', N'13                                                                                                  ', 6, 1500)
INSERT [dbo].[Magics] ([Description], [Spell], [ID], [level], [mana]) VALUES (N'This magic will give an estimate of gold reserve of an opponent.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        ', N'GoldSpy                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 ', N'2                                                                                                   ', 1, 200)
INSERT [dbo].[Magics] ([Description], [Spell], [ID], [level], [mana]) VALUES (N'Provide basic information of an opponent.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               ', N'HeroSpy                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 ', N'3                                                                                                   ', 1, 150)
INSERT [dbo].[Magics] ([Description], [Spell], [ID], [level], [mana]) VALUES (N'Disable enemy’s armor for 1 turn and enemy has no return damage for that turn.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          ', N'Terror                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  ', N'4                                                                                                   ', 1, 500)
INSERT [dbo].[Magics] ([Description], [Spell], [ID], [level], [mana]) VALUES (N'Deadly magic attack learned from legendary Leviathan.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   ', N'Gush                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', N'5                                                                                                   ', 2, 500)
INSERT [dbo].[Magics] ([Description], [Spell], [ID], [level], [mana]) VALUES (N'Burn up to 15% of enemy mana pool.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      ', N'ManaBurn                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                ', N'6                                                                                                   ', 2, 300)
INSERT [dbo].[Magics] ([Description], [Spell], [ID], [level], [mana]) VALUES (N'Destroy big portion of enemy’s gold reserve.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            ', N'GoldHunger                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              ', N'7                                                                                                   ', 3, 500)
INSERT [dbo].[Magics] ([Description], [Spell], [ID], [level], [mana]) VALUES (N'Protection spell to bounce next attack against you back to enemy                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        ', N'BounceAttack                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            ', N'8                                                                                                   ', 3, 1000)
INSERT [dbo].[Magics] ([Description], [Spell], [ID], [level], [mana]) VALUES (N'Coil of death that rips at a target.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', N'DeathCoil                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               ', N'9                                                                                                   ', 4, 850)
INSERT [dbo].[Region] ([Name], [ID]) VALUES (N'top                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     ', 1)
INSERT [dbo].[Region] ([Name], [ID]) VALUES (N'center                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  ', 2)
INSERT [dbo].[Region] ([Name], [ID]) VALUES (N'bottom                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  ', 3)
INSERT [dbo].[Region] ([Name], [ID]) VALUES (N'fountain                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                ', 4)
INSERT [dbo].[Team] ([Name], [Logo], [ID]) VALUES (N'Sentinel                                                                                            ', N'a.jpg', 1)
INSERT [dbo].[Team] ([Name], [Logo], [ID]) VALUES (N'Scourge                                                                                             ', N'b.jpg', 2)
INSERT [dbo].[TurnAssignment] ([Amount], [AgilityAmount], [ID], [TurnCeil], [type]) VALUES (6, 30, 1, 135, N'agility                                                                                             ')
INSERT [dbo].[TurnAssignment] ([Amount], [AgilityAmount], [ID], [TurnCeil], [type]) VALUES (4, 40, 2, 100, N'strength                                                                                            ')
INSERT [dbo].[TurnAssignment] ([Amount], [AgilityAmount], [ID], [TurnCeil], [type]) VALUES (4, 40, 3, 100, N'intelligence                                                                                        ')
INSERT [dbo].[Type] ([Name], [HealGain], [ID]) VALUES (N'agility                                                                                             ', 0, 1)
INSERT [dbo].[Type] ([Name], [HealGain], [ID]) VALUES (N'intelligence                                                                                        ', 0, 2)
INSERT [dbo].[Type] ([Name], [HealGain], [ID]) VALUES (N'strength                                                                                            ', 0, 3)
ALTER TABLE [dbo].[AttackLog] ADD  CONSTRAINT [DF_AttackLog_createdAt]  DEFAULT (getdate()) FOR [createdAt]
GO
ALTER TABLE [dbo].[KillLogs] ADD  CONSTRAINT [DF_KillLogs_createdAt]  DEFAULT (getdate()) FOR [createdAt]
GO
ALTER TABLE [dbo].[MagicLogs] ADD  CONSTRAINT [DF_MagicLogs_createdAt]  DEFAULT (getdate()) FOR [createdAt]
GO
ALTER TABLE [dbo].[Player] ADD  CONSTRAINT [DF_Player_Bounce]  DEFAULT ((0)) FOR [Bounce]
GO
ALTER TABLE [dbo].[Player] ADD  CONSTRAINT [DF_Player_Terror]  DEFAULT ((0)) FOR [Terror]
GO
ALTER TABLE [dbo].[AttackLog]  WITH CHECK ADD  CONSTRAINT [FK_AttackLog_User] FOREIGN KEY([ActorID])
REFERENCES [dbo].[User] ([ID])
GO
ALTER TABLE [dbo].[AttackLog] CHECK CONSTRAINT [FK_AttackLog_User]
GO
ALTER TABLE [dbo].[AttackLog]  WITH CHECK ADD  CONSTRAINT [FK_AttackLog_User1] FOREIGN KEY([TargetID])
REFERENCES [dbo].[User] ([ID])
GO
ALTER TABLE [dbo].[AttackLog] CHECK CONSTRAINT [FK_AttackLog_User1]
GO
ALTER TABLE [dbo].[CityExistIn]  WITH CHECK ADD  CONSTRAINT [FK_CityExistIn_City] FOREIGN KEY([CityID])
REFERENCES [dbo].[City] ([ID])
GO
ALTER TABLE [dbo].[CityExistIn] CHECK CONSTRAINT [FK_CityExistIn_City]
GO
ALTER TABLE [dbo].[CityExistIn]  WITH CHECK ADD  CONSTRAINT [FK_CityExistIn_Country] FOREIGN KEY([CountryID])
REFERENCES [dbo].[Country] ([ID])
GO
ALTER TABLE [dbo].[CityExistIn] CHECK CONSTRAINT [FK_CityExistIn_Country]
GO
ALTER TABLE [dbo].[HealLogs]  WITH CHECK ADD  CONSTRAINT [FK_HealLogs_User] FOREIGN KEY([TargetID])
REFERENCES [dbo].[User] ([ID])
GO
ALTER TABLE [dbo].[HealLogs] CHECK CONSTRAINT [FK_HealLogs_User]
GO
ALTER TABLE [dbo].[HealLogs]  WITH CHECK ADD  CONSTRAINT [FK_HealLogs_User1] FOREIGN KEY([ActorID])
REFERENCES [dbo].[User] ([ID])
GO
ALTER TABLE [dbo].[HealLogs] CHECK CONSTRAINT [FK_HealLogs_User1]
GO
ALTER TABLE [dbo].[HeroIsTypeOf]  WITH CHECK ADD  CONSTRAINT [FK_HeroIsTypeOf_HeroIsTypeOf] FOREIGN KEY([TypeID])
REFERENCES [dbo].[Type] ([ID])
GO
ALTER TABLE [dbo].[HeroIsTypeOf] CHECK CONSTRAINT [FK_HeroIsTypeOf_HeroIsTypeOf]
GO
ALTER TABLE [dbo].[HeroIsTypeOf]  WITH CHECK ADD  CONSTRAINT [FK_HeroIsTypeOf_HeroIsTypeOf1] FOREIGN KEY([HeroID])
REFERENCES [dbo].[Hero] ([ID])
GO
ALTER TABLE [dbo].[HeroIsTypeOf] CHECK CONSTRAINT [FK_HeroIsTypeOf_HeroIsTypeOf1]
GO
ALTER TABLE [dbo].[HeroMemberOfTeam]  WITH CHECK ADD  CONSTRAINT [FK_HeroMemberOfTeam_Hero] FOREIGN KEY([HeroID])
REFERENCES [dbo].[Hero] ([ID])
GO
ALTER TABLE [dbo].[HeroMemberOfTeam] CHECK CONSTRAINT [FK_HeroMemberOfTeam_Hero]
GO
ALTER TABLE [dbo].[HeroMemberOfTeam]  WITH CHECK ADD  CONSTRAINT [FK_HeroMemberOfTeam_HeroMemberOfTeam] FOREIGN KEY([TeamID])
REFERENCES [dbo].[Team] ([ID])
GO
ALTER TABLE [dbo].[HeroMemberOfTeam] CHECK CONSTRAINT [FK_HeroMemberOfTeam_HeroMemberOfTeam]
GO
ALTER TABLE [dbo].[HeroUnique]  WITH CHECK ADD  CONSTRAINT [FK_HeroUnique_Hero] FOREIGN KEY([HeroID])
REFERENCES [dbo].[Hero] ([ID])
GO
ALTER TABLE [dbo].[HeroUnique] CHECK CONSTRAINT [FK_HeroUnique_Hero]
GO
ALTER TABLE [dbo].[HeroUnique]  WITH CHECK ADD  CONSTRAINT [FK_HeroUnique_UniqueAbilitySP] FOREIGN KEY([UniqueID])
REFERENCES [dbo].[UniqueAbilitySP] ([ID])
GO
ALTER TABLE [dbo].[HeroUnique] CHECK CONSTRAINT [FK_HeroUnique_UniqueAbilitySP]
GO
ALTER TABLE [dbo].[KillLogs]  WITH CHECK ADD  CONSTRAINT [FK_KillLogs_User] FOREIGN KEY([KilledID])
REFERENCES [dbo].[User] ([ID])
GO
ALTER TABLE [dbo].[KillLogs] CHECK CONSTRAINT [FK_KillLogs_User]
GO
ALTER TABLE [dbo].[KillLogs]  WITH CHECK ADD  CONSTRAINT [FK_KillLogs_User1] FOREIGN KEY([KillerID])
REFERENCES [dbo].[User] ([ID])
GO
ALTER TABLE [dbo].[KillLogs] CHECK CONSTRAINT [FK_KillLogs_User1]
GO
ALTER TABLE [dbo].[MagicLimitedByType]  WITH CHECK ADD  CONSTRAINT [FK_MagicLimitedByType_Magics] FOREIGN KEY([MagicID])
REFERENCES [dbo].[Magics] ([ID])
GO
ALTER TABLE [dbo].[MagicLimitedByType] CHECK CONSTRAINT [FK_MagicLimitedByType_Magics]
GO
ALTER TABLE [dbo].[MagicLimitedByType]  WITH CHECK ADD  CONSTRAINT [FK_MagicLimitedByType_Type] FOREIGN KEY([TypeId])
REFERENCES [dbo].[Type] ([ID])
GO
ALTER TABLE [dbo].[MagicLimitedByType] CHECK CONSTRAINT [FK_MagicLimitedByType_Type]
GO
ALTER TABLE [dbo].[MagicLogs]  WITH CHECK ADD  CONSTRAINT [FK_MagicLogs_User] FOREIGN KEY([TargetID])
REFERENCES [dbo].[User] ([ID])
GO
ALTER TABLE [dbo].[MagicLogs] CHECK CONSTRAINT [FK_MagicLogs_User]
GO
ALTER TABLE [dbo].[MagicLogs]  WITH CHECK ADD  CONSTRAINT [FK_MagicLogs_User1] FOREIGN KEY([ActorID])
REFERENCES [dbo].[User] ([ID])
GO
ALTER TABLE [dbo].[MagicLogs] CHECK CONSTRAINT [FK_MagicLogs_User1]
GO
ALTER TABLE [dbo].[PlayAtRegion]  WITH CHECK ADD  CONSTRAINT [FK_PlayAtRegion_PlayAtRegion] FOREIGN KEY([RegionID])
REFERENCES [dbo].[Region] ([ID])
GO
ALTER TABLE [dbo].[PlayAtRegion] CHECK CONSTRAINT [FK_PlayAtRegion_PlayAtRegion]
GO
ALTER TABLE [dbo].[PlayAtRegion]  WITH CHECK ADD  CONSTRAINT [FK_PlayAtRegion_Player] FOREIGN KEY([PlayerID])
REFERENCES [dbo].[Player] ([ID])
GO
ALTER TABLE [dbo].[PlayAtRegion] CHECK CONSTRAINT [FK_PlayAtRegion_Player]
GO
ALTER TABLE [dbo].[Player]  WITH CHECK ADD  CONSTRAINT [FK_Player_Player] FOREIGN KEY([Bounce])
REFERENCES [dbo].[Player] ([ID])
GO
ALTER TABLE [dbo].[Player] CHECK CONSTRAINT [FK_Player_Player]
GO
ALTER TABLE [dbo].[PlayerControlHero]  WITH CHECK ADD  CONSTRAINT [FK_PlayerControlHero_Hero] FOREIGN KEY([HeroID])
REFERENCES [dbo].[Hero] ([ID])
GO
ALTER TABLE [dbo].[PlayerControlHero] CHECK CONSTRAINT [FK_PlayerControlHero_Hero]
GO
ALTER TABLE [dbo].[PlayerControlHero]  WITH CHECK ADD  CONSTRAINT [FK_PlayerControlHero_Player] FOREIGN KEY([PlayerID])
REFERENCES [dbo].[Player] ([ID])
GO
ALTER TABLE [dbo].[PlayerControlHero] CHECK CONSTRAINT [FK_PlayerControlHero_Player]
GO
ALTER TABLE [dbo].[PlayerHasItem]  WITH CHECK ADD  CONSTRAINT [FK_PlayerHasItem_Items] FOREIGN KEY([ItemID])
REFERENCES [dbo].[Items] ([ID])
GO
ALTER TABLE [dbo].[PlayerHasItem] CHECK CONSTRAINT [FK_PlayerHasItem_Items]
GO
ALTER TABLE [dbo].[PlayerHasItem]  WITH CHECK ADD  CONSTRAINT [FK_PlayerHasItem_Player] FOREIGN KEY([PlayerID])
REFERENCES [dbo].[Player] ([ID])
GO
ALTER TABLE [dbo].[PlayerHasItem] CHECK CONSTRAINT [FK_PlayerHasItem_Player]
GO
ALTER TABLE [dbo].[TurnAssignment]  WITH CHECK ADD  CONSTRAINT [FK_TurnAssignment_TurnAssignment] FOREIGN KEY([ID])
REFERENCES [dbo].[TurnAssignment] ([ID])
GO
ALTER TABLE [dbo].[TurnAssignment] CHECK CONSTRAINT [FK_TurnAssignment_TurnAssignment]
GO
ALTER TABLE [dbo].[TurnLimitedBy]  WITH CHECK ADD  CONSTRAINT [FK_TurnLimitedBy_Type] FOREIGN KEY([TypeID])
REFERENCES [dbo].[Type] ([ID])
GO
ALTER TABLE [dbo].[TurnLimitedBy] CHECK CONSTRAINT [FK_TurnLimitedBy_Type]
GO
ALTER TABLE [dbo].[UserLocation]  WITH CHECK ADD  CONSTRAINT [FK_UserLocation_City] FOREIGN KEY([CityID])
REFERENCES [dbo].[City] ([ID])
GO
ALTER TABLE [dbo].[UserLocation] CHECK CONSTRAINT [FK_UserLocation_City]
GO
ALTER TABLE [dbo].[UserLocation]  WITH CHECK ADD  CONSTRAINT [FK_UserLocation_Country] FOREIGN KEY([CountryID])
REFERENCES [dbo].[Country] ([ID])
GO
ALTER TABLE [dbo].[UserLocation] CHECK CONSTRAINT [FK_UserLocation_Country]
GO
ALTER TABLE [dbo].[UserLocation]  WITH CHECK ADD  CONSTRAINT [FK_UserLocation_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([ID])
GO
ALTER TABLE [dbo].[UserLocation] CHECK CONSTRAINT [FK_UserLocation_User]
GO
ALTER TABLE [dbo].[UserMemberOf]  WITH CHECK ADD  CONSTRAINT [FK_UserMemberOf_Team] FOREIGN KEY([TeamID])
REFERENCES [dbo].[Team] ([ID])
GO
ALTER TABLE [dbo].[UserMemberOf] CHECK CONSTRAINT [FK_UserMemberOf_Team]
GO
ALTER TABLE [dbo].[UserMemberOf]  WITH CHECK ADD  CONSTRAINT [FK_UserMemberOf_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([ID])
GO
ALTER TABLE [dbo].[UserMemberOf] CHECK CONSTRAINT [FK_UserMemberOf_User]
GO
ALTER TABLE [dbo].[UserPlayPlayer]  WITH CHECK ADD  CONSTRAINT [FK_UserPlayPlayer_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([ID])
GO
ALTER TABLE [dbo].[UserPlayPlayer] CHECK CONSTRAINT [FK_UserPlayPlayer_User]
GO
ALTER TABLE [dbo].[UserPlayPlayer]  WITH CHECK ADD  CONSTRAINT [FK_UserPlayPlayer_UserPlayPlayer] FOREIGN KEY([PlayerID])
REFERENCES [dbo].[Player] ([ID])
GO
ALTER TABLE [dbo].[UserPlayPlayer] CHECK CONSTRAINT [FK_UserPlayPlayer_UserPlayPlayer]
GO
ALTER TABLE [dbo].[VendorLocation]  WITH CHECK ADD  CONSTRAINT [FK_VendorLocation_Items] FOREIGN KEY([ItemID])
REFERENCES [dbo].[Items] ([ID])
GO
ALTER TABLE [dbo].[VendorLocation] CHECK CONSTRAINT [FK_VendorLocation_Items]
GO
ALTER TABLE [dbo].[VendorLocation]  WITH CHECK ADD  CONSTRAINT [FK_VendorLocation_Region] FOREIGN KEY([RegionID])
REFERENCES [dbo].[Region] ([ID])
GO
ALTER TABLE [dbo].[VendorLocation] CHECK CONSTRAINT [FK_VendorLocation_Region]
GO
/****** Object:  StoredProcedure [dbo].[AssignAssist]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AssignAssist]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	BEGIN TRANSACTION
	 
	 UPDATE Player SET Assint = Assint + 1 FROM KillLogs K,AttackLog A
		 WHERE K.createdAt < GETDATE() and A.createdAt < GETDATE() and K.createdAt > DATEADD(MINUTE,-30,GETDATE())
	 and A.createdAt > DATEADD(MINUTE,-30,GETDATE())
	 and A.createdAt < K.createdAt
	 and A.TargetID = K.KilledID
	 and A.ActorID != K.KillerID
	 and Player.ID = A.ActorID

	 UPDATE Player SET Assint = Assint + 1 FROM KillLogs K,MagicLogs M
		 WHERE K.createdAt < GETDATE() and M.createdAt < GETDATE() and K.createdAt > DATEADD(MINUTE,-30,GETDATE())
	 and M.createdAt > DATEADD(MINUTE,-30,GETDATE())
	 and M.createdAt < K.createdAt
	 and M.TargetID = K.KilledID
	 and M.ActorID != K.KillerID
	 and Player.ID = M.ActorID

	 COMMIT TRANSACTION

END






GO
/****** Object:  StoredProcedure [dbo].[AssignTurn]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AssignTurn]
	-- Add the parameters for the stored procedure here
	@playerId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @turn int;
	DECLARE @heroType nchar(100);
	DECLARE @agileunit int;
	DECLARE @amount int;
	DECLARE @turnNumber int;
	DECLARE @agility int;
	DECLARE @ceil int;

	SELECT @heroType = T.Name , @turn = P.Turn 
	FROM Player P,Hero H,PlayerControlHero PCH,HeroIsTypeOf HT,[Type] T
	WHERE P.ID = @playerId and PCH.PlayerID = P.ID and PCH.HeroID = H.ID and HT.HeroID = H.ID and HT.TypeID = T.ID

	SELECT @amount = TA.Amount,@agileunit = TA.AgilityAmount,@ceil = TurnCeil FROM TurnAssignment TA WHERE  @heroType = TA.[type]
	
	if(@amount = NULL or  @agileunit = NULL or @ceil = NULL)
		RETURN;

	SET @agility = dbo.baseAgility(@playerId);

	SET @turnNumber = CEILING(@agility / @agileunit);
	
	if(@turnNumber > @amount)
		SET @turnNumber = @amount;

	if( (@turnNumber + @turn) > @ceil)
		SET @turnNumber = @ceil;
	else
		SET @turnNumber = @turnNumber + @turn;
	
	UPDATE Player SET Turn = @turnNumber WHERE ID = @playerId;

END





GO
/****** Object:  StoredProcedure [dbo].[Attack]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Attack]
	-- Add the parameters for the stored procedure here
	@attacker int,
	@target int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	BEGIN TRANSACTION
	DECLARE @Region nchar(1000);
	SET @Region = dbo.GetPlayerRegion(@attacker);
	
	if(@Region = 'fountain')
		throw 1005, 'you can not attack' , 1
	 
	EXEC dbo.DecreaseTurn @attacker;

	DECLARE @AttackDamage int;
	DECLARE @TargetDamage int;
	DECLARE @Gold int;
	DECLARE @ErrorNumber int;
	DECLARE @terror bit;
	DECLARE @bounce int;

	SELECT @bounce = Bounce FROM Player WHERE ID = @attacker
	if (@bounce > 0) BEGIN
		DECLARE @temp int;
		SET @temp = @attacker;
		SET @attacker= @target;
		SET @target = @temp;
	END

	SET @AttackDamage = dbo.GetPlayerAttack(@attacker);
	SET @TargetDamage = CEILING(dbo.GetPlayerAttack(@target) / 50);

	SET @Gold = dbo.GetGoldOnDeath(@target);

	EXEC dbo.IncreaseExprience @attacker,10;

	BEGIN TRY
		EXEC dbo.DecreaseHp @target,@AttackDamage;
	END TRY
	BEGIN CATCH
		SET @ErrorNumber = Error_Number();
		if(@ErrorNumber = 1002) BEGIN
			EXEC dbo.KillPerson @attacker;
			EXEC dbo.LogKill @attacker,@target;
			EXEC dbo.IncreaseGold @attacker,@Gold;
			EXEC dbo.DecreaseGold @target,@Gold;
		END
	END CATCH

	BEGIN TRY
		SELECT @terror = Terror FROM Player WHERE ID = @target
		IF(@terror = 0)
			EXEC dbo.DecreaseHp @attacker,@TargetDamage;
	END TRY
	BEGIN CATCH
		SET @ErrorNumber = Error_Number();
		if(@ErrorNumber = 1002) BEGIN
			EXEC dbo.KillPerson @target ;
			EXEC dbo.LogKill @target,@attacker;
		END
	END CATCH

	EXEC dbo.LogAttack @attacker,@target,@AttackDamage,@TargetDamage;

	COMMIT TRANSACTION

END






GO
/****** Object:  StoredProcedure [dbo].[BounceAttack]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[BounceAttack]
	-- Add the parameters for the stored procedure here
	@attackerId int,
	@targetId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @herotype nchar(100);

	SELECT @herotype = T.Name
	FROM Player P,Hero H,PlayerControlHero PCH,HeroIsTypeOf HT,[Type] T 
	WHERE P.ID = @attackerId and P.ID = PCH.PlayerID and PCH.HeroID = H.ID and H.ID = HT.HeroID
	and HT.TypeID = T.ID

	if(@herotype != 'agility')
		throw 5001,'you are not agility',1

	if(dbo.checkSpellCondition(@attackerId,'BounceAttack') != 1)
		throw 5002,'conditions not satisfied',1

	BEGIN TRANSACTION

		EXEC dbo.DecreaseTurn @attackerId;
		EXEC dbo.IncreaseExprience @attackerId,10;

		UPDATE Player SET Bounce = @targetId WHERE ID = @targetId

	COMMIT TRANSACTION

	EXEC LogMagic @attackerId,@targetId,'BounceAttack';

END






GO
/****** Object:  StoredProcedure [dbo].[BrandSap]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[BrandSap]
	-- Add the parameters for the stored procedure here
	@attacker int,
	@target int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	BEGIN TRANSACTION
	 


	DECLARE @AttackDamage int;
	DECLARE @TargetDamage int;
	DECLARE @Gold int;
	DECLARE @ErrorNumber int;
	declare @HeroType NVARCHAR(100);
	SELECT @herotype = T.Name
	FROM Player P,Hero H,PlayerControlHero PCH,HeroIsTypeOf HT,[Type] T 
	WHERE P.ID = @attacker and P.ID = PCH.PlayerID and PCH.HeroID = H.ID and H.ID = HT.HeroID
	and HT.TypeID = T.ID

	if(@herotype != 'intelligence')
		throw 5001,'you are not intelligence',1
	

	if(dbo.checkSpellCondition(@attacker,'BrandSap') != 1)
		throw 5002,'conditions not satisfied',1

	EXEC dbo.DecreaseTurn @attacker;

	SET @AttackDamage = CEILING(dbo.baseIntelligence(@attacker) /50);


	EXEC dbo.IncreaseExprience @attacker,10;

	exec dbo.GetDamage @attacker, @target , @TargetDamage;

	exec dbo.IncreaseHp @attacker ,@TargetDamage;


	EXEC dbo.LogMagic @attacker , @target , 'BrandSap';

	COMMIT TRANSACTION

END







GO
/****** Object:  StoredProcedure [dbo].[BuyItem]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[BuyItem]
	-- Add the parameters for the stored procedure here
	@playerId int,
	@itemname nchar(100)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @price int,@region nchar(10),@level int,@itemId int;
	SELECT @price = Price,@region = region,@level = [Level],@itemId = ID  FROM Items WHERE Items.name = @itemname

	DECLARE @gold int;
	SELECT @gold = Gold FROM Player WHERE ID = @playerId
	
	if(@level >= dbo.GetPlayerLevel(@playerId) and @region = dbo.GetPlayerRegion(@playerId) and @price < @gold) BEGIN 
		EXEC dbo.DecreaseGold @playerId,@price;
		INSERT INTO PlayerHasItem(PlayerID,ItemID) VALUES (@playerId,@itemId);
	END
	ELSE
		throw 2000,'You can not Buy this Item',1 
END






GO
/****** Object:  StoredProcedure [dbo].[CycleJobs]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CycleJobs]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @playerId int;
	DECLARE @gold int;
	DECLARE @heroname int;
	
	DECLARE myCur CURSOR LOCAL FOR
	SELECT P.ID,H.Name FROM Player P,Hero H,Items  items,PlayerControlHero PCH
	 WHERE H.ID = PCH.HeroID and P.ID = PCH.PlayerID
	and dbo.GetPlayerRegion(P.ID) != 'fountain'

	OPEN myCur;
	FETCH NEXT FROM myCur INTO @playerId,@heroname
		WHILE @@FETCH_STATUS = 0 BEGIN
			SET @gold = 70 * dbo.GetPlayerLevel(@playerId);
			EXEC dbo.IncreaseGold @playerId,@gold;

			EXEC dbo.AssignTurn @playerId;

			if(@heroname = 'Lich')
				UPDATE Player SET CurrentMana = CEILING(CurrentMana*13/10) WHERE ID = @playerId
			
		UPDATE Player SET Terror = 0 WHERE ID = @playerId
	
	FETCH NEXT FROM myCur INTO @playerId
	END
	
	EXEC dbo.AssignAssist;

	CLOSE myCur
	DEALLOCATE myCur

END






GO
/****** Object:  StoredProcedure [dbo].[DeathCoil]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DeathCoil]
	-- Add the parameters for the stored procedure here
	@attacker int,
	@target int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	BEGIN TRANSACTION


	DECLARE @AttackDamage int;
	DECLARE @TargetDamage int;
	DECLARE @Gold int;
	DECLARE @ErrorNumber int;


	if(dbo.checkSpellCondition(@attacker,'DeathCoil') != 1)
		throw 5002,'conditions not satisfied',1

	EXEC dbo.DecreaseTurn @attacker;

	SET @AttackDamage = CEILING(dbo.baseIntelligence(@attacker) /5);

	EXEC dbo.IncreaseExprience @attacker,10;

	exec dbo.GetDamage @attacker, @target , @TargetDamage;

	EXEC dbo.LogMagic @attacker , @target , 'DeathCoil';

	COMMIT TRANSACTION

END







GO
/****** Object:  StoredProcedure [dbo].[DecreaseGold]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DecreaseGold]
	-- Add the parameters for the stored procedure here
	@playerId int,
	@amount   int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	declare @Gold int;


	select @Gold =
	Gold from Player 
	where ID = @playerId

	if(@Gold is null)
	 throw 1001 ,'current Gold is null' , 1

	if(@Gold < @amount)
		-- broken to be implemented
		throw 1003 ,'You Are Broken' , 1

	update Player set Gold  = Gold - @amount
	where ID = @playerId
END







GO
/****** Object:  StoredProcedure [dbo].[DecreaseHp]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DecreaseHp]
	-- Add the parameters for the stored procedure here
	@playerId int,
	@amount   int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	declare @currentHp int;


	select @currentHp =
	CurrentHP from Player 
	where ID = @playerId

	if(@currentHp is null)
	 throw 1001 ,'current HP is null' , 1

	if(@currentHp < @amount) BEGIN
		EXEC dbo.DiePerson @playerId;
		throw 1002 ,'current HP is less than Amount' , 1
	 END

	update Player set CurrentHP  = CurrentHP - @amount
	where ID = @playerId
END






GO
/****** Object:  StoredProcedure [dbo].[DecreaseMana]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DecreaseMana]
	-- Add the parameters for the stored procedure here
	@playerId int,
	@amount   int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	declare @currentMana int;


	select @currentMana =
	CurrentMana from Player 
	where ID = @playerId

	if(@currentMana is null)
	 throw 1001 ,'current Mana is null' , 1

	if(@currentMana < @amount) BEGIN
		EXEC dbo.DiePerson @playerId;
		throw 1002 ,'current Mana is less than Amount' , 1
	 END

	update Player set CurrentMana  = CurrentMana - @amount
	where ID = @playerId
END






GO
/****** Object:  StoredProcedure [dbo].[DecreaseTurn]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DecreaseTurn]
	-- Add the parameters for the stored procedure here
	@playerID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	declare @turn int;

	select @turn =
	p.Turn from Player as p 
	where ID = @playerId

	if(@turn < 1)
	 throw 1003 ,'current turn is less than 1' , 1
	
	update Player set Turn  = Turn - 1
	where ID = @playerId
	
END






GO
/****** Object:  StoredProcedure [dbo].[DiePerson]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DiePerson]
	-- Add the parameters for the stored procedure here
	@playerId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	declare @baseHp int;
	declare @baseMana int;

	SET @baseHp = dbo.baseHP(@playerId);
	SET @baseMana = dbo.baseMana(@playerId);

	update Player set Death  = Death + 1,
	CurrentHP = @baseHp,
	CurrentMana = @baseMana,
	KS = 0
	where ID = @playerId
END






GO
/****** Object:  StoredProcedure [dbo].[FingerOfDeath]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[FingerOfDeath]
	-- Add the parameters for the stored procedure here
	@attacker int,
	@target int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	BEGIN TRANSACTION
	 


	DECLARE @AttackDamage int;
	DECLARE @TargetDamage int;
	DECLARE @Gold int;
	DECLARE @ErrorNumber int;
	declare @HeroType NVARCHAR(100);
	SELECT @herotype = T.Name
	FROM Player P,Hero H,PlayerControlHero PCH,HeroIsTypeOf HT,[Type] T 
	WHERE P.ID = @attacker and P.ID = PCH.PlayerID and PCH.HeroID = H.ID and H.ID = HT.HeroID
	and HT.TypeID = T.ID

	if(@herotype != 'intelligence')
		throw 5001,'you are not intelligence',1
	

	if(dbo.checkSpellCondition(@attacker,'FingerOfDeath') != 1)
		throw 5002,'conditions not satisfied',1

	EXEC dbo.DecreaseTurn @attacker;

	SET @AttackDamage = CEILING(dbo.baseIntelligence(@attacker) * 0.4);


	EXEC dbo.IncreaseExprience @attacker,10;

	exec dbo.GetDamage @attacker, @target , @TargetDamage;

	EXEC dbo.LogMagic @attacker , @target , 'FingerOfDeath';

	COMMIT TRANSACTION

END



GO
/****** Object:  StoredProcedure [dbo].[GetDamage]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE  PROCEDURE [dbo].[GetDamage]
	-- Add the parameters for the stored procedure here
	@attacker int,
	@target int,
	@DamageAmount int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @ErrorNumber int;
	DECLARE @Gold int;
	SET @Gold = dbo.GetGoldOnDeath(@target);

    -- Insert statements for procedure here
	BEGIN TRY
		EXEC dbo.DecreaseHp @target,@DamageAmount;
	END TRY
	BEGIN CATCH
		SET @ErrorNumber = Error_Number();
		if(@ErrorNumber = 1002) BEGIN
			EXEC dbo.KillPerson @attacker;
			EXEC dbo.LogKill @attacker,@target;
			EXEC dbo.IncreaseGold @attacker,@Gold;
			EXEC dbo.DecreaseGold @target,@Gold;
		END
	END CATCH

END







GO
/****** Object:  StoredProcedure [dbo].[GoldHunger]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GoldHunger]
	-- Add the parameters for the stored procedure here
	@attackerId int,
	@targetId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @herotype nchar(100);
	DECLARE @gold int;

	SELECT @herotype = T.Name,@gold = P.Gold
	FROM Player P,Hero H,PlayerControlHero PCH,HeroIsTypeOf HT,[Type] T 
	WHERE P.ID = @attackerId and P.ID = PCH.PlayerID and PCH.HeroID = H.ID and H.ID = HT.HeroID
	and HT.TypeID = T.ID

	if(@herotype != 'intelligence')
		throw 5001,'you are not intelligence',1


	if(dbo.checkSpellCondition(@attackerId,'GoldHunger') != 1)
		throw 5002,'conditions not satisfied',1

	BEGIN TRANSACTION
		
		EXEC dbo.DecreaseTurn @attackerId;
		EXEC dbo.IncreaseExprience @attackerId,10;
		UPDATE Player SET Gold = CEILING(Gold / 5) WHERE ID = @targetId

	COMMIT TRANSACTION

	EXEC LogMagic @attackerId,@targetId,'GoldHunger';

END






GO
/****** Object:  StoredProcedure [dbo].[Gush]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Gush]
	-- Add the parameters for the stored procedure here
	@attacker int,
	@target int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	BEGIN TRANSACTION
	 
	EXEC dbo.DecreaseTurn @attacker;

	DECLARE @AttackDamage int;
	DECLARE @TargetDamage int;
	DECLARE @Gold int;
	DECLARE @ErrorNumber int;
	declare @HeroType NVARCHAR(100);
	SELECT @herotype = T.Name
	FROM Player P,Hero H,PlayerControlHero PCH,HeroIsTypeOf HT,[Type] T 
	WHERE P.ID = @attacker and P.ID = PCH.PlayerID and PCH.HeroID = H.ID and H.ID = HT.HeroID
	and HT.TypeID = T.ID

	if(@herotype != 'intelligence')
		throw 5001,'you are not intelligence',1
	

	if(dbo.checkSpellCondition(@attacker,'Gush') != 1)
		throw 5002,'conditions not satisfied',1


	EXEC dbo.DecreaseTurn @attacker;


	SET @AttackDamage = CEILING(dbo.baseIntelligence(@attacker) /10);


	EXEC dbo.IncreaseExprience @attacker,10;

	exec dbo.GetDamage @attacker, @target , @TargetDamage;


	EXEC dbo.LogMagic @attacker , @target , 'Gush';

	COMMIT TRANSACTION

END







GO
/****** Object:  StoredProcedure [dbo].[Heal]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Heal]
	-- Add the parameters for the stored procedure here
	@playerId int,
	@targetId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @amount int;

	SET @amount = dbo.baseIntelligence(@playerId);
	
	EXEC dbo.DecreaseTurn @playerId;
	EXEC dbo.DecreaseMana @playerId,10;
	EXEC dbo.IncreaseHp @playerId,@amount;
	EXEC dbo.IncreaseExprience @playerId,10;

END






GO
/****** Object:  StoredProcedure [dbo].[IncreaseExprience]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[IncreaseExprience]
	-- Add the parameters for the stored procedure here
	@playerId int,
	@amount   int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	declare @currentExp int;


	select @currentExp =
	CurrentHP from Player 
	where ID = @playerId

	if(@currentExp is null)
	 throw 1001 ,'current HP is null' , 1

	update Player set Exprience  = Exprience + @amount
	where ID = @playerId
END







GO
/****** Object:  StoredProcedure [dbo].[IncreaseGold]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[IncreaseGold]
	-- Add the parameters for the stored procedure here
	@playerId int,
	@amount   int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	declare @Gold int;


	select @Gold =
	Gold from Player 
	where ID = @playerId

	if(@Gold is null)
	 throw 1001 ,'current HP is null' , 1

	update Player set Gold  = Gold + @amount
	where ID = @playerId
END







GO
/****** Object:  StoredProcedure [dbo].[IncreaseHp]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[IncreaseHp]
	-- Add the parameters for the stored procedure here
	@playerId int,
	@amount   int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	declare @currentHp int;


	select @currentHp =
	CurrentHP from Player 
	where ID = @playerId

	if(@currentHp is null)
	 throw 1001 ,'current HP is null' , 1

	update Player set CurrentHP = CurrentHP + @amount where ID = @playerId;
	update Player set CurrentHP = (select Expr1 from baseHP_View as base where base.ID = @playerId)
	where ID = @playerId and CurrentHP > 
		(select Expr1 from baseHP_View as base where base.ID = @playerId);
END





GO
/****** Object:  StoredProcedure [dbo].[KillPerson]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[KillPerson]
	-- Add the parameters for the stored procedure here
	@playerId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	update Player SET [Kill] = [Kill] + 1,
	KS = KS + 1
	where ID = @playerId
END






GO
/****** Object:  StoredProcedure [dbo].[LightningBolt]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[LightningBolt]
	-- Add the parameters for the stored procedure here
	@attacker int,
	@target int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	BEGIN TRANSACTION
	 

	DECLARE @AttackDamage int;
	DECLARE @TargetDamage int;
	DECLARE @Gold int;
	DECLARE @ErrorNumber int;

	
	if(dbo.checkSpellCondition(@attacker,'LightningBolt') != 1)
		throw 5002,'conditions not satisfied',1

	EXEC dbo.DecreaseTurn @attacker;


	SET @AttackDamage = CEILING(dbo.baseIntelligence(@attacker) / 20);

	
	EXEC dbo.IncreaseExprience @attacker,10;

	exec dbo.GetDamage @attacker, @target , @TargetDamage;

	EXEC dbo.LogMagic @attacker , @target , 'LightningBolt';

	COMMIT TRANSACTION

END






GO
/****** Object:  StoredProcedure [dbo].[LogAttack]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[LogAttack]
	-- Add the parameters for the stored procedure here
	@attacker int,
	@target int,
	@attackamount int,
	@attackrecieved int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	INSERT INTO AttackLog(ActorID,TargetID,AttackAmount,AttackRecieved)
	VALUES (@attacker,@target,@attackamount,@attackrecieved);
    -- Insert statements for procedure here
	

END






GO
/****** Object:  StoredProcedure [dbo].[LogKill]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[LogKill]
	-- Add the parameters for the stored procedure here
	@attacker int,
	@target int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	INSERT INTO KillLogs(KillerID,KilledID)
	VALUES (@attacker,@target);
    -- Insert statements for procedure here
	

END






GO
/****** Object:  StoredProcedure [dbo].[LogMagic]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[LogMagic]
	-- Add the parameters for the stored procedure here
	@attacker int,
	@target int,
	@spell nchar(100)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	INSERT INTO MagicLogs(ActorID,TargetID,Spell)
	VALUES (@attacker,@target,@spell);

END




GO
/****** Object:  StoredProcedure [dbo].[ManaBurn]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ManaBurn]
	-- Add the parameters for the stored procedure here
	@attackerId int,
	@targetId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


	if(dbo.checkSpellCondition(@attackerId,'ManaBurn') != 1)
		throw 5002,'conditions not satisfied',1

	BEGIN TRANSACTION

		EXEC dbo.DecreaseTurn @attackerId;
		EXEC dbo.IncreaseExprience @attackerId,10;

		UPDATE Player SET CurrentMana = CEILING(CurrentMana * 17 / 20) WHERE ID = @targetId

	COMMIT TRANSACTION

	EXEC LogMagic @attackerId,@targetId,'ManaBurn';

END






GO
/****** Object:  StoredProcedure [dbo].[SellItem]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SellItem]
	-- Add the parameters for the stored procedure here
	@playerId int,
	@itemname nchar(100)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @price int,@itemId int;
	SELECT @price = Price,@itemId = PHI.ID  FROM Items items , PlayerHasItem PHI 
	WHERE items.name = @itemname and items.ID = PHI.ItemID and PHI.PlayerID = @playerId

	if( @price = NULL  or @itemId = NUlL)
		throw 2001,'You can not Sell this Item',1

	SET @price = CEILING(@price / 2);
	EXEC dbo.IncreaseGold @playerId,@price;
	DELETE FROM PlayerHasItem WHERE @itemId = ItemID and @playerId = PlayerID;

END






GO
/****** Object:  StoredProcedure [dbo].[Sunder]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Sunder]
	-- Add the parameters for the stored procedure here
	@attackerId int,
	@targetId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @attackerHP int;
	DECLARE @targetHP int;
	DECLARE @attackerMana int;
	DECLARE @targetMana int;
	DECLARE @herotype nchar(100);

	SELECT @attackerHP = P.CurrentHP,@herotype = T.Name,@attackerMana = P.CurrentMana
	FROM Player P,Hero H,PlayerControlHero PCH,HeroIsTypeOf HT,[Type] T 
	WHERE P.ID = @attackerId and P.ID = PCH.PlayerID and PCH.HeroID = H.ID and H.ID = HT.HeroID
	and HT.TypeID = T.ID

	if(@herotype != 'intelligence')
		throw 5001,'you are not intelligence',1
	
	SELECT @targetHP = P.CurrentHP FROM Player P,Hero H,PlayerControlHero PCH 
	WHERE P.ID = @targetId and P.ID = PCH.PlayerID and PCH.HeroID = H.ID


	if(dbo.checkSpellCondition(@attackerId,'Sunder') != 1)
		throw 5002,'conditions not satisfied',1

	BEGIN TRANSACTION
		
		EXEC dbo.DecreaseTurn @attackerId;
		EXEC dbo.IncreaseExprience @attackerId,10;
		UPDATE Player SET CurrentHP = @targetHP,CurrentMana = @targetMana WHERE ID = @attackerId
		UPDATE Player SET CurrentHP = @attackerHP,CurrentMana = @attackerMana WHERE ID = @targetId

	COMMIT TRANSACTION

	EXEC LogMagic @attackerId,@targetId,'Sunder';

END






GO
/****** Object:  StoredProcedure [dbo].[SunderHealth]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SunderHealth]
	-- Add the parameters for the stored procedure here
	@attackerId int,
	@targetId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @attackerHP int;
	DECLARE @targetHP int;
	DECLARE @heroname int;
	DECLARE @herotype nchar(100);

	SELECT @attackerHP = P.CurrentHP,@heroname = H.Name FROM Player P,Hero H,PlayerControlHero PCH 
	WHERE P.ID = @attackerId and P.ID = PCH.PlayerID and PCH.HeroID = H.ID

	if(@heroname != ' Lina Inverse' and @heroname != 'Holy Knight')
		throw 5000,'you are not hero can spell',1
	
	SELECT @targetHP = P.CurrentHP,@herotype = T.Name FROM Player P,Hero H,PlayerControlHero PCH,HeroIsTypeOf HT,[Type] T 
	WHERE P.ID = @targetId and P.ID = PCH.PlayerID and PCH.HeroID = H.ID and H.ID = HT.HeroID
	and HT.TypeID = T.ID

	if(@herotype = 'intelligence')
		throw 5001,'you can not do this on intelligence',1

	if(dbo.checkSpellCondition(@attackerId,'SunderHealth') != 1)
		throw 5002,'conditions not satisfied',1

	BEGIN TRANSACTION

		EXEC dbo.DecreaseTurn @attackerId;
		EXEC dbo.IncreaseExprience @attackerId,10;

		UPDATE Player SET CurrentHP = @targetHP WHERE ID = @attackerId
		UPDATE Player SET CurrentHP = @attackerHP WHERE ID = @targetId

	COMMIT TRANSACTION


END






GO
/****** Object:  StoredProcedure [dbo].[Terror]    Script Date: 12/30/2016 8:54:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Terror]
	-- Add the parameters for the stored procedure here
	@attackerId int,
	@targetId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @attackerHP int;
	DECLARE @targetHP int;
	DECLARE @attackerMana int;
	DECLARE @targetMana int;
	DECLARE @herotype nchar(100);

	

	SELECT @attackerHP = P.CurrentHP,@herotype = T.Name,@attackerMana = P.CurrentMana
	FROM Player P,Hero H,PlayerControlHero PCH,HeroIsTypeOf HT,[Type] T 
	WHERE P.ID = @attackerId and P.ID = PCH.PlayerID and PCH.HeroID = H.ID and H.ID = HT.HeroID
	and HT.TypeID = T.ID

	if(@herotype != 'agility')
		throw 5001,'you are not agility',1

	if(dbo.checkSpellCondition(@attackerId,'Terror') != 1)
		throw 5002,'conditions not satisfied',1

	BEGIN TRANSACTION
		EXEC dbo.DecreaseTurn @attackerId;
		EXEC dbo.IncreaseExprience @attackerId,10;

		UPDATE Player SET Terror = 1 WHERE ID = @targetId

	COMMIT TRANSACTION

	EXEC LogMagic @attackerId,@targetId,'Terror';

END



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
         Begin Table = "Player"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 7
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'baseArmor_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'baseArmor_View'
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
         Begin Table = "Player"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 7
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'baseHP_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'baseHP_View'
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
         Begin Table = "Player"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 7
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'baseMana_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'baseMana_View'
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
         Begin Table = "Player"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 7
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'GetPlayerRank_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'GetPlayerRank_View'
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
         Begin Table = "Player"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 7
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PlayersLevel_view'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PlayersLevel_view'
GO
USE [master]
GO
ALTER DATABASE [WebDota] SET  READ_WRITE 
GO
