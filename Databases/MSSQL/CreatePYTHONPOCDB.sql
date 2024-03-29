--SQL Server 16 on Rocky Linux 8
USE [master]
GO

/****** Object:  Database [MYPYTHONPOC]    Script Date: 2023-02-10 9:15:33 PM ******/
CREATE DATABASE [MYPYTHONPOC]
 CONTAINMENT = PARTIAL
 ON  PRIMARY 
( NAME = N'MYPYTHONPOC', FILENAME = N'/var/opt/mssql/data/MYPYTHONPOC.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 10240000KB )
 LOG ON 
( NAME = N'MYPYTHONPOC_log', FILENAME = N'/var/opt/mssql/data/MYPYTHONPOC_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH LEDGER = OFF
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MYPYTHONPOC].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [MYPYTHONPOC] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [MYPYTHONPOC] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [MYPYTHONPOC] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [MYPYTHONPOC] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [MYPYTHONPOC] SET ARITHABORT OFF 
GO

ALTER DATABASE [MYPYTHONPOC] SET AUTO_CLOSE ON 
GO

ALTER DATABASE [MYPYTHONPOC] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [MYPYTHONPOC] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [MYPYTHONPOC] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [MYPYTHONPOC] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [MYPYTHONPOC] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [MYPYTHONPOC] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [MYPYTHONPOC] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [MYPYTHONPOC] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [MYPYTHONPOC] SET  ENABLE_BROKER 
GO

ALTER DATABASE [MYPYTHONPOC] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [MYPYTHONPOC] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [MYPYTHONPOC] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [MYPYTHONPOC] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [MYPYTHONPOC] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [MYPYTHONPOC] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [MYPYTHONPOC] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [MYPYTHONPOC] SET RECOVERY SIMPLE 
GO

ALTER DATABASE [MYPYTHONPOC] SET  MULTI_USER 
GO

ALTER DATABASE [MYPYTHONPOC] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [MYPYTHONPOC] SET DB_CHAINING OFF 
GO

ALTER DATABASE [MYPYTHONPOC] SET DEFAULT_FULLTEXT_LANGUAGE = 1033 
GO

ALTER DATABASE [MYPYTHONPOC] SET DEFAULT_LANGUAGE = 1033 
GO

ALTER DATABASE [MYPYTHONPOC] SET NESTED_TRIGGERS = ON 
GO

ALTER DATABASE [MYPYTHONPOC] SET TRANSFORM_NOISE_WORDS = OFF 
GO

ALTER DATABASE [MYPYTHONPOC] SET TWO_DIGIT_YEAR_CUTOFF = 2049 
GO

ALTER DATABASE [MYPYTHONPOC] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [MYPYTHONPOC] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO

ALTER DATABASE [MYPYTHONPOC] SET DELAYED_DURABILITY = DISABLED 
GO

ALTER DATABASE [MYPYTHONPOC] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO

ALTER DATABASE [MYPYTHONPOC] SET QUERY_STORE = ON
GO

ALTER DATABASE [MYPYTHONPOC] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO

ALTER DATABASE [MYPYTHONPOC] SET  READ_WRITE 
GO

USE [MYPYTHONPOC]
GO

/****** Object:  User [MYPYTHONPOC_rw]    Script Date: 2023-02-10 9:17:06 PM ******/
CREATE USER [MYPYTHONPOC_rw] WITH PASSWORD=N'', DEFAULT_SCHEMA=[dbo]
GO

USE [MYPYTHONPOC]
GO
ALTER ROLE [db_datareader] ADD MEMBER [MYPYTHONPOC_rw]
GO
USE [MYPYTHONPOC]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [MYPYTHONPOC_rw]
GO


USE [MYPYTHONPOC]
GO

/****** Object:  Table [dbo].[monthly_average_retail_prices_for_gasoline]    Script Date: 2023-02-10 9:16:27 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[monthly_average_retail_prices_for_gasoline](
	[REF_DATE] [varchar](500) NULL,
	[GEO] [varchar](500) NULL,
	[DGUID] [varchar](500) NULL,
	[Type of fuel] [varchar](500) NULL,
	[UOM] [varchar](500) NULL,
	[UOM_ID] [float] NULL,
	[SCALAR_FACTOR] [varchar](500) NULL,
	[SCALAR_ID] [float] NULL,
	[VECTOR] [varchar](500) NULL,
	[COORDINATE] [float] NULL,
	[VALUE] [float] NULL,
	[STATUS] [varchar](500) NULL,
	[SYMBOL] [varchar](500) NULL,
	[TERMINATED] [varchar](500) NULL,
	[DECIMALS] [float] NULL
) ON [PRIMARY]
GO



