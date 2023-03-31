# ChangeDataInTabelesWithOutputIntoLogTables
When it becomes necessary to change(Update,Insert,Delete) important data in tables in certain columns , the best way is to log these changes

For this example need to create test table (Purchasing.paymentsLT) and fill it.
run script: CreateandFillTables.sql

Update:
Than will create procedute(Purchasing.UpdatePaymentsLT) to update this table with loggin which data were change in table Purchasing.logChangePaymentsLT.
run script ProcedureUpdate.sql to create procedure Purchasing.UpdatePaymentsLT.
Than execute this procedure:

USE [AdventureWorks2019]
GO

DECLARE @RC int
DECLARE @IdPayment int=2
DECLARE @PayDate datetime='20201006'
DECLARE @PayAmount money=100.32

EXECUTE @RC = [Purchasing].[UpdatePaymentsLT] 
   @IdPayment
  ,@PayDate
  ,@PayAmount
GO

Merge:
This procedure consist is two parts, Update and Insert by Id(in this case ProductId). 
In case Update, the table Purchasing.logChangePaymentsLT is filled in exactly the same way as in the case wheh use pocedure Purchasing.UpdatePaymentsLT.
In case Insert, in table Purchasing.paymentsLT will insert a new row and the table Purchasing.logChangePaymentsLT is filled with value NULL in columns for PreviousValue and new values will insert in columns for NewValue.

Than execute this procedure:

USE [AdventureWorks2019]
GO

DECLARE @RC int
DECLARE @ProductID int=885
DECLARE @PayDate datetime='20190412'
DECLARE @PayAmount money=149.83

-- TODO: Set parameter values here.

EXECUTE @RC = [Purchasing].[MergePaymentsLT] 
   @ProductID
  ,@PayDate
  ,@PayAmount
GO
