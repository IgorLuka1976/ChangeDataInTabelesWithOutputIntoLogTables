# ChangeDataInTabelesWithOutputIntoLogTables
When it becomes necessary to change(Update,Insert,Delete) important data in tables in certain columns , the best way is to log these changes

For this example need to create test table (Purchasing.paymentsLT) and fill it.
run script: CreateandFillTables.sql

Than will create procedute(Purchasing.UpdatePaymentsLT) to update this table with loggin which data were change.
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
