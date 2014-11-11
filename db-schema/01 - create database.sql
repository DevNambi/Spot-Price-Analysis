CREATE DATABASE [SpotAnalysis]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SpotAnalysis', FILENAME = N'E:\MSSQL\SpotAnalysis.mdf' , SIZE = 102400KB , FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'SpotAnalysis_log', FILENAME = N'E:\MSSQL\SpotAnalysis_log.ldf' , SIZE = 102400KB , FILEGROWTH = 10%)
GO
ALTER DATABASE [SpotAnalysis] SET COMPATIBILITY_LEVEL = 110
GO
ALTER DATABASE [SpotAnalysis] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SpotAnalysis] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SpotAnalysis] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SpotAnalysis] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SpotAnalysis] SET ARITHABORT OFF 
GO
ALTER DATABASE [SpotAnalysis] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SpotAnalysis] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [SpotAnalysis] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SpotAnalysis] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SpotAnalysis] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SpotAnalysis] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SpotAnalysis] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SpotAnalysis] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SpotAnalysis] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SpotAnalysis] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SpotAnalysis] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SpotAnalysis] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SpotAnalysis] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SpotAnalysis] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SpotAnalysis] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SpotAnalysis] SET  READ_WRITE 
GO
ALTER DATABASE [SpotAnalysis] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [SpotAnalysis] SET  MULTI_USER 
GO
ALTER DATABASE [SpotAnalysis] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SpotAnalysis] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [SpotAnalysis]
GO
IF NOT EXISTS (SELECT name FROM sys.filegroups WHERE is_default=1 AND name = N'PRIMARY') ALTER DATABASE [SpotAnalysis] MODIFY FILEGROUP [PRIMARY] DEFAULT
GO
