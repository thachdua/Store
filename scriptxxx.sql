USE [master]
GO
/****** Object:  Database [QLCF]    Script Date: 3/16/2024 11:32:04 AM ******/
CREATE DATABASE [QLCF]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QLCF', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\QLCF.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'QLCF_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\QLCF_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [QLCF] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QLCF].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QLCF] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QLCF] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QLCF] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QLCF] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QLCF] SET ARITHABORT OFF 
GO
ALTER DATABASE [QLCF] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [QLCF] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QLCF] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QLCF] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QLCF] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QLCF] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QLCF] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QLCF] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QLCF] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QLCF] SET  DISABLE_BROKER 
GO
ALTER DATABASE [QLCF] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QLCF] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QLCF] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QLCF] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QLCF] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QLCF] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QLCF] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QLCF] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [QLCF] SET  MULTI_USER 
GO
ALTER DATABASE [QLCF] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QLCF] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QLCF] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QLCF] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [QLCF] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [QLCF] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'QLCF', N'ON'
GO
ALTER DATABASE [QLCF] SET QUERY_STORE = OFF
GO
USE [QLCF]
GO
/****** Object:  User [tinh]    Script Date: 3/16/2024 ******/
CREATE USER [tinh] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  UserDefinedFunction [dbo].[AUTO_IDBill]    Script Date: 3/16/2024 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[AUTO_IDBill]()
RETURNS VARCHAR(7)
AS
BEGIN
	DECLARE @ID VARCHAR(7)
	IF (SELECT COUNT(id) FROM Bill) = 0					
		SET @ID = '0'
	ELSE                                                              
		SELECT @ID = MAX(RIGHT(id, 5)) FROM Bill
		SELECT @ID = CASE
			WHEN @ID >= 0 AND @ID <= 8 THEN /**/'HD0000' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 9 AND @ID <= 98 THEN /**/'HD000' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 99 AND @ID <= 998 THEN /**/'HD00' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 999 AND @ID <= 9998 THEN /**/'HD0' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 9999 AND @ID <= 99998 THEN /**/'HD' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
		END
	RETURN @ID
END	
GO
/****** Object:  UserDefinedFunction [dbo].[AUTO_IDFood]    Script Date: 3/16/2024 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION /**/[dbo].[AUTO_IDFood]()
RETURNS VARCHAR(/**/5)
AS
BEGIN
	DECLARE @ID VARCHAR(/**/5)
	IF (SELECT COUNT(id) FROM /**/Food) = 0          
		SET @ID = '0'
	ELSE                                                              
		SELECT @ID = MAX(RIGHT(id, /**/4)) FROM /**/Food
		SELECT @ID = CASE
			WHEN @ID >= 0 AND @ID <= 8 THEN /**/'M000' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 9 AND @ID <= 98 THEN /**/'M00' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 99 AND @ID <= 998 THEN /**/'M0' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 999 AND @ID <= 9998 THEN /**/'M' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
		END
	RETURN @ID
END
GO
/****** Object:  UserDefinedFunction [dbo].[AUTO_IDFoodCategory]    Script Date: 3/16/2024 *****/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION /**/[dbo].[AUTO_IDFoodCategory]()
RETURNS VARCHAR(/**/5)
AS
BEGIN
	DECLARE @ID VARCHAR(/**/5)
	IF (SELECT COUNT(id) FROM /**/FoodCategory) = 0
		SET @ID = '0'
	ELSE
		SELECT @ID = MAX(RIGHT(id, /**/3)) FROM /**/FoodCategory
		SELECT @ID = CASE
			WHEN @ID >= 0 AND @ID <= 8 THEN /**/'DM00' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 9 AND @ID <= 98 THEN /**/'DM0' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 99 AND @ID <= 998 THEN /**/'DM' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
		END
	RETURN @ID
END
GO
/****** Object:  UserDefinedFunction [dbo].[AUTO_IDTableFood]    Script Date: 3/16/2024 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[AUTO_IDTableFood]()
RETURNS VARCHAR(5)
AS
BEGIN
	DECLARE @ID VARCHAR(5)
	IF (SELECT COUNT(id) FROM TableFood) = 0					
		SET @ID = '0'
	ELSE                                                              
		SELECT @ID = MAX(RIGHT(id, 4)) FROM TableFood
		SELECT @ID = CASE
			WHEN @ID >= 0 AND @ID <= 8 THEN /**/'B000' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 9 AND @ID <= 98 THEN /**/'B00' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 99 AND @ID <= 998 THEN /**/'B0' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 999 AND @ID <= 9998 THEN /**/'B' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
		END
	RETURN @ID
END
GO
/****** Object:  Table [dbo].[Account]    Script Date: 3/16/2024 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[UserName] [nvarchar](100) NOT NULL,
	[DisplayName] [nvarchar](100) NOT NULL,
	[PassWord] [nvarchar](1000) NOT NULL,
	[Sex] [nvarchar](10) NOT NULL,
	[PhoneNumber] [varchar](10) NOT NULL,
	[Address] [nvarchar](100) NOT NULL,
	[Type] [nvarchar](50) NOT NULL,
	[Salary] [int] NOT NULL,
	[exist] [int] NOT NULL,
	[DateOfBirth] [date] NULL,
 CONSTRAINT [PK__Account__C9F284577579EDDD] PRIMARY KEY CLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Bill]    Script Date: 3/16/2024 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bill](
	[id] [varchar](7) NOT NULL,
	[DateCheckIn] [datetime] NOT NULL,
	[DateCheckOut] [datetime] NULL,
	[discount] [float] NULL,
	[idTable] [varchar](5) NOT NULL,
	[userNameAccount] [nvarchar](100) NULL,
	[status] [int] NOT NULL,
	[totalPrice] [float] NOT NULL,
 CONSTRAINT [PK__Bill__3213E83F00604509] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BillInfo]    Script Date: 3/16/2024 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BillInfo](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idBill] [varchar](7) NOT NULL,
	[idFood] [varchar](5) NOT NULL,
	[count] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Food]    Script Date: 3/16/2024 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Food](
	[id] [varchar](5) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[idCategory] [varchar](5) NOT NULL,
	[unit] [nvarchar](50) NOT NULL,
	[price] [int] NOT NULL,
	[image] [image] NULL,
	[exist] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FoodCateGory]    Script Date: 3/16/2024 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FoodCateGory](
	[id] [varchar](5) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[exist] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TableFood]    Script Date: 3/16/2024 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TableFood](
	[id] [varchar](5) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[status] [nvarchar](100) NOT NULL,
	[exist] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TimeKeeping]    Script Date: 3/16/2024 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TimeKeeping](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[userName] [varchar](100) NOT NULL,
	[dateLogin] [datetime] NOT NULL,
	[dateLogout] [datetime] NOT NULL,
	[dentaT] [int] NULL,
	[totalSalary] [float] NULL,
	[salary] [float] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Account] ADD  CONSTRAINT [DF__Account__Display__31EC6D26]  DEFAULT (N'Chưa có tên') FOR [DisplayName]
GO
ALTER TABLE [dbo].[Account] ADD  CONSTRAINT [DF__Account__PassWor__32E0915F]  DEFAULT ((0)) FOR [PassWord]
GO
ALTER TABLE [dbo].[Account] ADD  CONSTRAINT [DF__Account__Type__33D4B598]  DEFAULT ((0)) FOR [Type]
GO
ALTER TABLE [dbo].[Account] ADD  CONSTRAINT [DF__Account__Salary__34C8D9D1]  DEFAULT ((0)) FOR [Salary]
GO
ALTER TABLE [dbo].[Account] ADD  CONSTRAINT [DF_Account_exist]  DEFAULT ((1)) FOR [exist]
GO
ALTER TABLE [dbo].[Bill] ADD  CONSTRAINT [DF__Bill__id__3E52440B]  DEFAULT ([dbo].[AUTO_IDBill]()) FOR [id]
GO
ALTER TABLE [dbo].[Bill] ADD  CONSTRAINT [DF__Bill__DateCheckI__3F466844]  DEFAULT (getdate()) FOR [DateCheckIn]
GO
ALTER TABLE [dbo].[Bill] ADD  CONSTRAINT [DF__Bill__status__403A8C7D]  DEFAULT ((0)) FOR [status]
GO
ALTER TABLE [dbo].[Bill] ADD  CONSTRAINT [DF__Bill__totalPrice__412EB0B6]  DEFAULT ((0)) FOR [totalPrice]
GO
ALTER TABLE [dbo].[BillInfo] ADD  DEFAULT ((0)) FOR [count]
GO
ALTER TABLE [dbo].[Food] ADD  DEFAULT ([dbo].[AUTO_IDFood]()) FOR [id]
GO
ALTER TABLE [dbo].[Food] ADD  DEFAULT (N'Chưa đặt tên') FOR [name]
GO
ALTER TABLE [dbo].[Food] ADD  DEFAULT ((0)) FOR [price]
GO
ALTER TABLE [dbo].[Food] ADD  DEFAULT ((1)) FOR [exist]
GO
ALTER TABLE [dbo].[FoodCateGory] ADD  DEFAULT ([dbo].[AUTO_IDFoodCategory]()) FOR [id]
GO
ALTER TABLE [dbo].[FoodCateGory] ADD  DEFAULT (N'Chưa đặt tên') FOR [name]
GO
ALTER TABLE [dbo].[FoodCateGory] ADD  DEFAULT ((1)) FOR [exist]
GO
ALTER TABLE [dbo].[TableFood] ADD  DEFAULT ([dbo].[AUTO_IDTableFood]()) FOR [id]
GO
ALTER TABLE [dbo].[TableFood] ADD  DEFAULT (N'Bàn chưa có tên') FOR [name]
GO
ALTER TABLE [dbo].[TableFood] ADD  DEFAULT (N'Trống') FOR [status]
GO
ALTER TABLE [dbo].[TableFood] ADD  DEFAULT ((1)) FOR [exist]
GO
ALTER TABLE [dbo].[Bill]  WITH CHECK ADD  CONSTRAINT [FK_Bill_Account] FOREIGN KEY([userNameAccount])
REFERENCES [dbo].[Account] ([UserName])
GO
ALTER TABLE [dbo].[Bill] CHECK CONSTRAINT [FK_Bill_Account]
GO
ALTER TABLE [dbo].[Bill]  WITH CHECK ADD  CONSTRAINT [FK_Bill_TableFood] FOREIGN KEY([idTable])
REFERENCES [dbo].[TableFood] ([id])
GO
ALTER TABLE [dbo].[Bill] CHECK CONSTRAINT [FK_Bill_TableFood]
GO
ALTER TABLE [dbo].[BillInfo]  WITH CHECK ADD  CONSTRAINT [FK_BillInfo_Bill] FOREIGN KEY([idBill])
REFERENCES [dbo].[Bill] ([id])
GO
ALTER TABLE [dbo].[BillInfo] CHECK CONSTRAINT [FK_BillInfo_Bill]
GO
ALTER TABLE [dbo].[BillInfo]  WITH CHECK ADD  CONSTRAINT [FK_BillInfo_Food] FOREIGN KEY([idFood])
REFERENCES [dbo].[Food] ([id])
GO
ALTER TABLE [dbo].[BillInfo] CHECK CONSTRAINT [FK_BillInfo_Food]
GO
ALTER TABLE [dbo].[Food]  WITH CHECK ADD  CONSTRAINT [FK_Food_FoodCateGory] FOREIGN KEY([idCategory])
REFERENCES [dbo].[FoodCateGory] ([id])
GO
ALTER TABLE [dbo].[Food] CHECK CONSTRAINT [FK_Food_FoodCateGory]
GO
/****** Object:  StoredProcedure [dbo].[UseProc_Login]    Script Date: 3/16/2024 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[UseProc_Login]
@userName nvarchar(100),
@passWord nvarchar(1000)
as
	select * from Account where UserName = @userName and PassWord = @passWord
GO
/****** Object:  StoredProcedure [dbo].[USP_GetListBillByDate]    Script Date: 3/16/2024 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Proc [dbo].[USP_GetListBillByDate]
@checkin date, @checkout date
AS
BEGIN
Select t.name as [Tên Bàn], DateCheckIn as [Ngày tạo hóa đơn], DateCheckOut as [Ngày thanh toán], b.totalPrice as [Tổng hóa đơn]
	From dbo.Bill AS b, dbo.TableFood AS t
	Where DateCheckIn >= @checkin AND DateCheckOut <= @checkout AND b.status = 1
	AND t.id = b.idTable
END
GO
/****** Object:  StoredProcedure [dbo].[USP_GetListBillByDate1]    Script Date: 3/16/2024 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[USP_GetListBillByDate1]
@checkIn date, @checkOut date
as
BEGIN
IF(@checkIn = @checkOut)
SELECT Bill.id ,TableFood.name as 'Tên bàn', datecheckin as 'Giờ vào',datecheckout as 'Giờ ra', discount as 'Giảm giá (%)',Bill.totalPrice as 'Tổng tiền', ((100-discount)/100)*totalPrice AS 'Thành tiền' FROM Bill INNER JOIN TableFood ON
Bill.idTable = TableFood.id
WHERE (Bill.datecheckout = @checkIn) and Bill.status = N'1'
ELSE
SELECT Bill.id ,TableFood.name as 'Tên bàn', datecheckin as 'Giờ vào',datecheckout as 'Giờ ra', discount as 'Giảm giá (%)',Bill.totalPrice as 'Tổng tiền', ((100-discount)/100)*totalPrice AS 'Thành tiền' FROM Bill INNER JOIN TableFood ON
Bill.idTable = TableFood.id
WHERE (datecheckout >= @checkIn and datecheckout <= @checkOut) and Bill.status = N'1'
END
GO
/****** Object:  StoredProcedure [dbo].[USP_GetListBillFood]    Script Date: 3/16/2024  ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Proc [dbo].[USP_GetListBillFood]
@checkin date, @checkout date
AS
Begin
Select  F.name as[Tên món ăn], SUM(bi.count) as "Số lượng bán ra"
	From dbo.Food as F, dbo.BillInfo As bi, dbo.Bill
	Where F.id = bi.idFood AND DateCheckIn >= @checkin AND DateCheckOut <= @checkout AND bi.idBill = Bill.id
	Group by F.name
END
GO
/****** Object:  StoredProcedure [dbo].[USP_UpdateAccount]    Script Date: 3/16/2024 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[USP_UpdateAccount]
@TaiKhoan varchar(50), @Sdt nchar(10) , @MatKhau varchar(50), @NewMatKhau varchar(50)
AS
BEGIN
	DEClare @isRightPass INT = 0
	Select @isRightPass = COUNT(*) From dbo.Account WHERE UserName = @TaiKhoan AND PassWord = @MatKhau
	If(@isRightPass = 1)
	Begin
	if(@NewMatKhau = NULL OR @NewMatKhau = '')
	BEGIn
	UPdate dbo.Account set PhoneNumber =@Sdt Where UserName = @TaiKhoan
	end
	else
	Update dbo.Account  set PhoneNumber = @Sdt ,PassWord = @NewMatKhau  where UserName = @TaiKhoan
	end
END
GO
USE [master]
GO
ALTER DATABASE [QLCF] SET  READ_WRITE 
GO
