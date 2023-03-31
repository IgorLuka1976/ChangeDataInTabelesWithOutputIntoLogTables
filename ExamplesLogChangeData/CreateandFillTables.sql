-----Important
USE [AdventureWorks2019]
GO

/****** Object:  Table [HumanResources].[EmployeeDepartmentHistoryLT]    Script Date: 30.03.2023 21:58:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Purchasing].[paymentsLT](
	[IdPayment] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[PayDate] [datetime] NULL,
	[PayAmount] [money] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdPayment] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [Purchasing].[logChangePaymentsLT](
	[IdLog] [int] IDENTITY(1,1) NOT NULL,
	[IdPayment] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[PayDatePrev] [datetime] NULL,
	[PayAmountPrev] [money] NULL,
	[PayDateNow] [datetime] NULL,
	[PayAmountNow] [money] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdLog] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
--------Fill tables

INSERT INTO [Purchasing].[paymentsLT]
           ([ProductID]
           ,[PayDate]
           ,[PayAmount])
SELECT [ProductID]
	  ,[DueDate]
      ,[UnitPrice]
  FROM [AdventureWorks2019].[Purchasing].[PurchaseOrderDetail]